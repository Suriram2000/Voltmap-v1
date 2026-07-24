import '../../../shared/models/charging_station.dart';

abstract interface class StationRepository {
  Future<List<ChargingStation>> fetchStations();
}
