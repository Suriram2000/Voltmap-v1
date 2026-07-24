enum ChargingSessionStatus {
  preparing,
  charging,
  paused,
  completed,
  failed,
}

class ChargingSession {
  const ChargingSession({
    required this.id,
    required this.userId,
    required this.stationId,
    required this.connectorId,
    required this.status,
    required this.startedAt,
    this.endedAt,
    this.energyKwh = 0,
    this.cost = 0,
  });

  final String id;
  final String userId;
  final String stationId;
  final String connectorId;
  final ChargingSessionStatus status;
  final DateTime startedAt;
  final DateTime? endedAt;
  final double energyKwh;
  final double cost;

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'stationId': stationId,
      'connectorId': connectorId,
      'status': status.name,
      'startedAt': startedAt.toIso8601String(),
      'endedAt': endedAt?.toIso8601String(),
      'energyKwh': energyKwh,
      'cost': cost,
    };
  }
}
