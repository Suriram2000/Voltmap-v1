import '../../../shared/models/charging_station.dart';
import 'station_cache.dart';

class MemoryStationCache implements StationCache {
  List<ChargingStation> _stations = const [];

  @override
  Future<void> saveStations(List<ChargingStation> stations) async {
    _stations = List.unmodifiable(stations);
  }

  @override
  Future<List<ChargingStation>> loadStations() async {
    return List.unmodifiable(_stations);
  }

  @override
  Future<void> clear() async {
    _stations = const [];
  }
}
