import 'dart:collection';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import 'angles.dart';

/// The vibration's spectrum: how strong each frequency is, and the
/// strongest one when it clearly stands out.
@immutable
class Spectrum {
  const Spectrum({
    required this.levels,
    required this.step,
    required this.maxHz,
    required this.strength,
    this.peakHz,
  });

  /// Strength of each frequency from 0 Hz up to [maxHz], every [step] Hz,
  /// relative to the strongest (0 to 1, on an amplitude scale).
  final List<double> levels;
  final double step;

  /// The highest frequency this phone can measure honestly: a little under
  /// half its sampling rate, and at most [FrequencyAnalyzer.ceiling].
  final double maxHz;

  /// The size of the strongest frequency's shaking, m/s² (about).
  final double strength;

  /// The strongest frequency, or null when no single one stands out.
  final double? peakHz;

  double? get rpm => peakHz == null ? null : peakHz! * 60;
}

/// Finds the frequency of a vibration from the last [window] seconds of
/// acceleration: each axis is resampled evenly, windowed and turned into a
/// spectrum (FFT), and the axes' power is added (so a vibration counts
/// whichever way it shakes). The strongest peak, refined between bins, is
/// the frequency, if it clearly stands out from the rest.
class FrequencyAnalyzer {
  FrequencyAnalyzer({this.window = 2.5});

  final double window;

  /// Below this, hand movement and the phone settling swamp the reading.
  static const floor = 3.0;

  /// The top of the scale, 100 Hz (6 000 RPM): phones sample at about
  /// 200 Hz, and frequencies above half the sampling rate fold back down.
  static const ceiling = 100.0;

  /// How much stronger than the typical frequency the peak must be (power)
  /// to count as "clear".
  static const clarity = 20.0;

  /// The weakest vibration with a frequency worth showing, m/s²: below
  /// this it's the sensor's own noise.
  static const quietest = 0.02;

  final _samples = Queue<(double, Vec3)>();

  void add(Vec3 acceleration, double seconds) {
    _samples.addLast((seconds, acceleration));
    while (_samples.isNotEmpty && seconds - _samples.first.$1 > window) {
      _samples.removeFirst();
    }
  }

  void clear() => _samples.clear();

  /// The spectrum of the samples so far, or null until there's most of a
  /// window of them.
  Spectrum? analyze() {
    if (_samples.length < 64) return null;
    final t0 = _samples.first.$1, t1 = _samples.last.$1;
    if (t1 - t0 < window * 0.8) return null;
    // An even grid over the samples' time span, a power of two long and
    // at least as fine as the samples (so nothing is lost).
    var n = 64;
    while (n < _samples.length) {
      n *= 2;
    }
    final dt = (t1 - t0) / (n - 1), rate = 1 / dt;
    final axes = List.generate(3, (_) => Float64List(n));
    final list = _samples.toList();
    var j = 0;
    for (var i = 0; i < n; i++) {
      final t = t0 + i * dt;
      while (j < list.length - 2 && list[j + 1].$1 < t) {
        j++;
      }
      final (ta, a) = list[j];
      final (tb, b) = list[j + 1];
      final k = tb > ta ? ((t - ta) / (tb - ta)).clamp(0.0, 1.0) : 0.0;
      axes[0][i] = a.x + (b.x - a.x) * k;
      axes[1][i] = a.y + (b.y - a.y) * k;
      axes[2][i] = a.z + (b.z - a.z) * k;
    }
    final power = Float64List(n ~/ 2 + 1);
    for (final x in axes) {
      _addPower(x, power);
    }

    final step = rate / n;
    // The phone's own sampling sets the limit, not the finer grid: above
    // half its rate the grid holds only interpolation.
    final sampled = (list.length - 1) / (t1 - t0);
    final maxHz = math.min(sampled * 0.45, ceiling);
    final last = math.min(power.length - 2, (maxHz / step).floor());
    final first = math.max(1, (floor / step).ceil());
    if (last <= first + 2) return null;

    var best = first;
    for (var k = first; k <= last; k++) {
      if (power[k] > power[best]) best = k;
    }
    final band = [for (var k = first; k <= last; k++) power[k]]..sort();
    final typical = band[band.length ~/ 2];
    // A Hann window shows a sine of amplitude A as A·n/4 in its bin.
    final amplitude = 4 * math.sqrt(power[best]) / n;
    final clear =
        power[best] >= clarity * typical &&
        amplitude >= quietest &&
        best > first &&
        best < last;

    double? peak;
    if (clear) {
      // Between bins: a parabola through the peak and its neighbours.
      final a = math.log(power[best - 1] + 1e-12);
      final b = math.log(power[best] + 1e-12);
      final c = math.log(power[best + 1] + 1e-12);
      final d = a - 2 * b + c;
      final shift = d == 0 ? 0.0 : (0.5 * (a - c) / d).clamp(-0.5, 0.5);
      peak = (best + shift) * step;
    }

    final top = math.sqrt(power[best]);
    return Spectrum(
      levels: [
        for (var k = 0; k <= last; k++)
          k < first || top == 0 ? 0 : math.sqrt(power[k]) / top,
      ],
      step: step,
      maxHz: maxHz,
      strength: amplitude,
      peakHz: peak,
    );
  }

  /// Adds the windowed power spectrum of [x] to [power].
  static void _addPower(Float64List x, Float64List power) {
    final n = x.length;
    var mean = 0.0;
    for (final v in x) {
      mean += v;
    }
    mean /= n;
    final re = Float64List(n), im = Float64List(n);
    for (var i = 0; i < n; i++) {
      final hann = 0.5 - 0.5 * math.cos(2 * math.pi * i / (n - 1));
      re[i] = (x[i] - mean) * hann;
    }
    _fft(re, im);
    for (var k = 0; k < power.length; k++) {
      power[k] += re[k] * re[k] + im[k] * im[k];
    }
  }

  /// In-place radix-2 FFT; the length must be a power of two.
  static void _fft(Float64List re, Float64List im) {
    final n = re.length;
    for (var i = 1, j = 0; i < n; i++) {
      var bit = n >> 1;
      for (; j & bit != 0; bit >>= 1) {
        j ^= bit;
      }
      j ^= bit;
      if (i < j) {
        final r = re[i];
        re[i] = re[j];
        re[j] = r;
        final m = im[i];
        im[i] = im[j];
        im[j] = m;
      }
    }
    for (var len = 2; len <= n; len <<= 1) {
      final a = -2 * math.pi / len;
      final wr = math.cos(a), wi = math.sin(a);
      for (var i = 0; i < n; i += len) {
        var cr = 1.0, ci = 0.0;
        for (var k = 0; k < len ~/ 2; k++) {
          final ur = re[i + k], ui = im[i + k];
          final vr = re[i + k + len ~/ 2] * cr - im[i + k + len ~/ 2] * ci;
          final vi = re[i + k + len ~/ 2] * ci + im[i + k + len ~/ 2] * cr;
          re[i + k] = ur + vr;
          im[i + k] = ui + vi;
          re[i + k + len ~/ 2] = ur - vr;
          im[i + k + len ~/ 2] = ui - vi;
          final nr = cr * wr - ci * wi;
          ci = cr * wi + ci * wr;
          cr = nr;
        }
      }
    }
  }
}
