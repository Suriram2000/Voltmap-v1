import '../../../shared/models/charging_station.dart';

abstract interface class StationCache {
  Future<void> saveStations(List<ChargingStation> stations);
  Future<List<ChargingStation>> loadStations();
  Future<void> clear();
}
