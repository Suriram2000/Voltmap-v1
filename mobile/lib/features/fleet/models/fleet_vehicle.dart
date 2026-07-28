class FleetVehicle {
  const FleetVehicle({
    required this.id,
    required this.fleetId,
    required this.name,
    required this.registrationNumber,
    this.make,
    this.model,
    this.rangeKm = 300,
    this.assignedDriverId,
    this.active = true,
  });

  final String id;
  final String fleetId;
  final String name;
  final String registrationNumber;
  final String? make;
  final String? model;
  final int rangeKm;
  final String? assignedDriverId;
  final bool active;

  factory FleetVehicle.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return FleetVehicle(
      id: id,
      fleetId: map['fleetId'] as String? ?? '',
      name: map['name'] as String? ?? 'Fleet vehicle',
      registrationNumber:
          map['registrationNumber'] as String? ?? '',
      make: map['make'] as String?,
      model: map['model'] as String?,
      rangeKm: map['rangeKm'] as int? ?? 300,
      assignedDriverId: map['assignedDriverId'] as String?,
      active: map['active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fleetId': fleetId,
      'name': name,
      'registrationNumber': registrationNumber,
      'make': make,
      'model': model,
      'rangeKm': rangeKm,
      'assignedDriverId': assignedDriverId,
      'active': active,
    };
  }
}
