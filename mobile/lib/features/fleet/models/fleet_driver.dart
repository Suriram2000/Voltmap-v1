enum FleetDriverStatus {
  invited,
  active,
  suspended,
}

class FleetDriver {
  const FleetDriver({
    required this.id,
    required this.fleetId,
    required this.name,
    required this.email,
    this.userId,
    this.status = FleetDriverStatus.invited,
    this.monthlyLimitCents,
  });

  final String id;
  final String fleetId;
  final String name;
  final String email;
  final String? userId;
  final FleetDriverStatus status;
  final int? monthlyLimitCents;

  factory FleetDriver.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return FleetDriver(
      id: id,
      fleetId: map['fleetId'] as String? ?? '',
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      userId: map['userId'] as String?,
      status: FleetDriverStatus.values.firstWhere(
        (value) => value.name == map['status'],
        orElse: () => FleetDriverStatus.invited,
      ),
      monthlyLimitCents: map['monthlyLimitCents'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fleetId': fleetId,
      'name': name,
      'email': email,
      'userId': userId,
      'status': status.name,
      'monthlyLimitCents': monthlyLimitCents,
    };
  }
}
