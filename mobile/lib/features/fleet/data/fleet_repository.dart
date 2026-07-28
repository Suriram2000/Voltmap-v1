import '../models/fleet_account.dart';
import '../models/fleet_charging_policy.dart';
import '../models/fleet_charging_session.dart';
import '../models/fleet_driver.dart';
import '../models/fleet_vehicle.dart';

abstract interface class FleetRepository {
  Stream<List<FleetAccount>> watchFleets(String ownerUserId);
  Stream<List<FleetDriver>> watchDrivers(String fleetId);
  Stream<List<FleetVehicle>> watchVehicles(String fleetId);
  Stream<List<FleetChargingSession>> watchSessions(String fleetId);
  Future<FleetChargingPolicy?> getPolicy(String fleetId);
  Future<void> savePolicy(FleetChargingPolicy policy);
  Future<String> addDriver(FleetDriver driver);
  Future<String> addVehicle(FleetVehicle vehicle);
}
