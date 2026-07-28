class FleetChargingSession {
  const FleetChargingSession({
    required this.id,
    required this.fleetId,
    required this.driverId,
    required this.vehicleId,
    required this.stationId,
    required this.startedAt,
    this.endedAt,
    this.energyKwh = 0,
    this.costCents = 0,
  });

  final String id;
  final String fleetId;
  final String driverId;
  final String vehicleId;
  final String stationId;
  final DateTime startedAt;
  final DateTime? endedAt;
  final double energyKwh;
  final int costCents;

  double get cost => costCents / 100;

  factory FleetChargingSession.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return FleetChargingSession(
      id: id,
      fleetId: map['fleetId'] as String? ?? '',
      driverId: map['driverId'] as String? ?? '',
      vehicleId: map['vehicleId'] as String? ?? '',
      stationId: map['stationId'] as String? ?? '',
      startedAt: DateTime.tryParse(
            map['startedAt'] as String? ?? '',
          ) ??
          DateTime.now(),
      endedAt: DateTime.tryParse(
        map['endedAt'] as String? ?? '',
      ),
      energyKwh:
          (map['energyKwh'] as num?)?.toDouble() ?? 0,
      costCents: map['costCents'] as int? ?? 0,
    );
  }
}
