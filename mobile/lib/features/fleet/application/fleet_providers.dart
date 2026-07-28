import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/application/auth_providers.dart';
import '../data/firestore_fleet_repository.dart';
import '../data/fleet_repository.dart';
import '../models/fleet_account.dart';
import '../models/fleet_charging_session.dart';
import '../models/fleet_driver.dart';
import '../models/fleet_vehicle.dart';

final fleetRepositoryProvider = Provider<FleetRepository>(
  (ref) => FirestoreFleetRepository(),
);

final fleetsProvider = StreamProvider<List<FleetAccount>>((ref) {
  final user = ref.watch(authStateProvider).valueOrNull;

  if (user == null) {
    return const Stream.empty();
  }

  return ref.watch(fleetRepositoryProvider).watchFleets(user.uid);
});

final fleetDriversProvider = StreamProvider.family<
    List<FleetDriver>, String>((ref, fleetId) {
  return ref.watch(fleetRepositoryProvider).watchDrivers(fleetId);
});

final fleetVehiclesProvider = StreamProvider.family<
    List<FleetVehicle>, String>((ref, fleetId) {
  return ref.watch(fleetRepositoryProvider).watchVehicles(fleetId);
});

final fleetSessionsProvider = StreamProvider.family<
    List<FleetChargingSession>, String>((ref, fleetId) {
  return ref.watch(fleetRepositoryProvider).watchSessions(fleetId);
});
