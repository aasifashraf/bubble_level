import '../../../../data/repositories/g_force_repository.dart';
import '../../../../domain/g_force.dart';
import '../../../core/sensor_view_model.dart';

/// What the push is doing now, for the status line.
enum GMotion { steady, braking, speedingUp, leftBend, rightBend }

/// G-force meter: speeding up, braking and cornering, felt as a push, for a
/// phone in a car mount. The accelerometer runs only while it's open.
class GForceViewModel extends ActiveViewModel {
  GForceViewModel({required this._repository}) : super(_repository);

  final GForceRepository _repository;

  /// Below this the car counts as steady, g.
  static const steadyBelow = 0.08;

  /// Where gentle ends and firm begins, and where firm becomes hard, g.
  static const firmAt = 0.3, hardAt = 0.6;

  GReading get reading => _repository.value;

  GMotion get motion {
    final r = reading;
    if (r.total < steadyBelow) return GMotion.steady;
    if (r.lon.abs() >= r.lat.abs()) {
      return r.lon < 0 ? GMotion.braking : GMotion.speedingUp;
    }
    return r.lat > 0 ? GMotion.leftBend : GMotion.rightBend;
  }

  /// The size of the push now in its own direction, g.
  double get strength => switch (motion) {
    GMotion.steady => reading.total,
    GMotion.braking || GMotion.speedingUp => reading.lon.abs(),
    GMotion.leftBend || GMotion.rightBend => reading.lat.abs(),
  };

  DateTime? _zeroedAt;

  /// For a moment after Zero, the status says it took.
  bool get justZeroed =>
      _zeroedAt != null &&
      DateTime.now().difference(_zeroedAt!) < const Duration(seconds: 2);

  void zero() {
    _repository.zero();
    _zeroedAt = DateTime.now();
    notifyListeners();
  }

  void resetPeaks() => _repository.resetPeaks();

  @override
  void onActivate() {
    _zeroedAt = null;
    _repository
      ..clear()
      ..start();
  }

  @override
  void onDeactivate() => _repository.stop();

  @override
  void update() => notifyListeners();
}
