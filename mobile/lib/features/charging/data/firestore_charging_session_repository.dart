import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/charging_session.dart';
import 'charging_session_repository.dart';

class FirestoreChargingSessionRepository
    implements ChargingSessionRepository {
  FirestoreChargingSessionRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _sessions =>
      _firestore.collection('chargingSessions');

  @override
  Future<String> createSession(ChargingSession session) async {
    final document = session.id.isEmpty
        ? _sessions.doc()
        : _sessions.doc(session.id);

    await document.set(session.toMap());
    return document.id;
  }

  @override
  Stream<ChargingSession?> watchSession(String sessionId) {
    return _sessions.doc(sessionId).snapshots().map((snapshot) {
      final data = snapshot.data();

      if (!snapshot.exists || data == null) {
        return null;
      }

      return ChargingSession(
        id: snapshot.id,
        userId: data['userId'] as String,
        stationId: data['stationId'] as String,
        connectorId: data['connectorId'] as String,
        status: ChargingSessionStatus.values.byName(
          data['status'] as String,
        ),
        startedAt: DateTime.parse(data['startedAt'] as String),
        endedAt: data['endedAt'] == null
            ? null
            : DateTime.parse(data['endedAt'] as String),
        energyKwh: (data['energyKwh'] as num?)?.toDouble() ?? 0,
        cost: (data['cost'] as num?)?.toDouble() ?? 0,
      );
    });
  }

  @override
  Future<void> completeSession(String sessionId) {
    return _sessions.doc(sessionId).update({
      'status': ChargingSessionStatus.completed.name,
      'endedAt': DateTime.now().toIso8601String(),
    });
  }
}
