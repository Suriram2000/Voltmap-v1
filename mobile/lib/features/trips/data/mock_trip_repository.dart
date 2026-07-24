import '../../../shared/models/charging_station.dart';
import '../../discovery/data/mock_station_repository.dart';
import '../models/trip_plan.dart';
import 'trip_repository.dart';

class MockTripRepository implements TripRepository {
  const MockTripRepository({
    this.stationRepository = const MockStationRepository(),
  });

  final MockStationRepository stationRepository;

  @override
  Future<TripPlan> buildTrip({
    required String origin,
    required String destination,
    required int vehicleRangeKm,
    required int startingChargePercent,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));

    final stations = await stationRepository.fetchStations();
    final usableRange = vehicleRangeKm * startingChargePercent / 100;
    final simulatedDistance = _estimateDistance(origin, destination);
    final requiredStops = simulatedDistance <= usableRange
        ? 0
        : ((simulatedDistance - usableRange) / (vehicleRangeKm * 0.75)).ceil();

    final availableStations = stations
        .where((station) => station.isAvailable)
        .toList()
      ..sort((a, b) => b.maxPowerKw.compareTo(a.maxPowerKw));

    final stops = <ChargingStation>[
      for (var index = 0;
          index < requiredStops && index < availableStations.length;
          index++)
        availableStations[index],
    ];

    return TripPlan(
      origin: origin,
      destination: destination,
      distanceKm: simulatedDistance,
      estimatedDurationMinutes: (simulatedDistance / 55 * 60).round() +
          (stops.length * 25),
      vehicleRangeKm: vehicleRangeKm,
      recommendedStops: stops,
    );
  }

  double _estimateDistance(String origin, String destination) {
    final seed = origin.trim().length + destination.trim().length;
    return 160 + (seed % 8) * 55;
  }
}
