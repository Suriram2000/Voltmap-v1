import '../models/trip_plan.dart';

abstract interface class TripRepository {
  Future<TripPlan> buildTrip({
    required String origin,
    required String destination,
    required int vehicleRangeKm,
    required int startingChargePercent,
  });
}
