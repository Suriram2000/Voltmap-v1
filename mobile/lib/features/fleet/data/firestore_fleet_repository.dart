import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/fleet_account.dart';
import '../models/fleet_charging_policy.dart';
import '../models/fleet_charging_session.dart';
import '../models/fleet_driver.dart';
import '../models/fleet_vehicle.dart';
import 'fleet_repository.dart';

class FirestoreFleetRepository implements FleetRepository {
  FirestoreFleetRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _fleets =>
      _firestore.collection('fleets');

  @override
  Stream<List<FleetAccount>> watchFleets(String ownerUserId) {
    return _fleets
        .where('ownerUserId', isEqualTo: ownerUserId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (document) => FleetAccount.fromMap(
                  document.id,
                  document.data(),
                ),
              )
              .toList(),
        );
  }

  @override
  Stream<List<FleetDriver>> watchDrivers(String fleetId) {
    return _fleets
        .doc(fleetId)
        .collection('drivers')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (document) => FleetDriver.fromMap(
                  document.id,
                  document.data(),
                ),
              )
              .toList(),
        );
  }

  @override
  Stream<List<FleetVehicle>> watchVehicles(String fleetId) {
    return _fleets
        .doc(fleetId)
        .collection('vehicles')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (document) => FleetVehicle.fromMap(
                  document.id,
                  document.data(),
                ),
              )
              .toList(),
        );
  }

  @override
  Stream<List<FleetChargingSession>> watchSessions(
    String fleetId,
  ) {
    return _fleets
        .doc(fleetId)
        .collection('sessions')
        .orderBy('startedAt', descending: true)
        .limit(100)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (document) => FleetChargingSession.fromMap(
                  document.id,
                  document.data(),
                ),
              )
              .toList(),
        );
  }

  @override
  Future<FleetChargingPolicy?> getPolicy(String fleetId) async {
    final document =
        await _fleets.doc(fleetId).collection('settings').doc('policy').get();

    final data = document.data();

    if (data == null) {
      return null;
    }

    return FleetChargingPolicy.fromMap(data);
  }

  @override
  Future<void> savePolicy(FleetChargingPolicy policy) {
    return _fleets
        .doc(policy.fleetId)
        .collection('settings')
        .doc('policy')
        .set(policy.toMap());
  }

  @override
  Future<String> addDriver(FleetDriver driver) async {
    final document = await _fleets
        .doc(driver.fleetId)
        .collection('drivers')
        .add(driver.toMap());

    return document.id;
  }

  @override
  Future<String> addVehicle(FleetVehicle vehicle) async {
    final document = await _fleets
        .doc(vehicle.fleetId)
        .collection('vehicles')
        .add(vehicle.toMap());

    return document.id;
  }
}
