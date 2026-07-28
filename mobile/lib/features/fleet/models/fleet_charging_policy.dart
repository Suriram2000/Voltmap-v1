class FleetChargingPolicy {
  const FleetChargingPolicy({
    required this.fleetId,
    this.allowedNetworks = const [],
    this.maximumSessionCostCents,
    this.maximumEnergyKwh,
    this.allowFastCharging = true,
    this.allowRoaming = true,
    this.requireApprovalAboveCents,
  });

  final String fleetId;
  final List<String> allowedNetworks;
  final int? maximumSessionCostCents;
  final double? maximumEnergyKwh;
  final bool allowFastCharging;
  final bool allowRoaming;
  final int? requireApprovalAboveCents;

  factory FleetChargingPolicy.fromMap(
    Map<String, dynamic> map,
  ) {
    return FleetChargingPolicy(
      fleetId: map['fleetId'] as String? ?? '',
      allowedNetworks: List<String>.from(
        map['allowedNetworks'] as List? ?? const [],
      ),
      maximumSessionCostCents:
          map['maximumSessionCostCents'] as int?,
      maximumEnergyKwh:
          (map['maximumEnergyKwh'] as num?)?.toDouble(),
      allowFastCharging:
          map['allowFastCharging'] as bool? ?? true,
      allowRoaming: map['allowRoaming'] as bool? ?? true,
      requireApprovalAboveCents:
          map['requireApprovalAboveCents'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fleetId': fleetId,
      'allowedNetworks': allowedNetworks,
      'maximumSessionCostCents': maximumSessionCostCents,
      'maximumEnergyKwh': maximumEnergyKwh,
      'allowFastCharging': allowFastCharging,
      'allowRoaming': allowRoaming,
      'requireApprovalAboveCents': requireApprovalAboveCents,
    };
  }
}
