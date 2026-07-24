import '../models/charging_session.dart';

abstract interface class ChargingSessionRepository {
  Future<String> createSession(ChargingSession session);
  Stream<ChargingSession?> watchSession(String sessionId);
  Future<void> completeSession(String sessionId);
}
