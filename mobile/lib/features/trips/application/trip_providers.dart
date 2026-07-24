import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/mock_trip_repository.dart';
import '../data/trip_repository.dart';
import '../models/trip_plan.dart';

final tripRepositoryProvider = Provider<TripRepository>(
  (ref) => const MockTripRepository(),
);

final tripPlannerProvider =
    AsyncNotifierProvider<TripPlannerController, TripPlan?>(
  TripPlannerController.new,
);

class TripPlannerController extends AsyncNotifier<TripPlan?> {
  @override
  Future<TripPlan?> build() async => null;

  Future<void> createTrip({
    required String origin,
    required String destination,
    required int vehicleRangeKm,
    required int startingChargePercent,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () => ref.read(tripRepositoryProvider).buildTrip(
            origin: origin,
            destination: destination,
            vehicleRangeKm: vehicleRangeKm,
            startingChargePercent: startingChargePercent,
          ),
    );
  }

  void clear() {
    state = const AsyncData(null);
  }
}
