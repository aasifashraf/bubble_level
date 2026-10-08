import '../../domain/orientation_reading.dart';
import '../../domain/speed.dart';
import '../services/location_service.dart';
import 'sensor_stream_repository.dart';

/// GPS fixes turned into speed and a trip. Runs only while the speedometer
/// is open and in front.
class SpeedRepository
    extends SensorStreamRepository<LocationFix, SpeedReading> {
  SpeedRepository({this._location = const LocationService()})
    : super(const SpeedReading());

  final LocationService _location;
  final _trip = TripMeter();

  @override
  Stream<LocationFix> open() => _location.fixes();

  @override
  void onSample(LocationFix fix) {
    _trip.add(fix);
    value = _trip.reading(SensorState.ok);
  }

  @override
  void onMissing() => value = _trip.reading(SensorState.missing);

  /// Starts the trip again: distance, top and average.
  void resetTrip() {
    _trip.reset();
    value = _trip.reading(value.state);
  }
}
