class AppUser {
  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.vehicleName,
    this.vehicleRangeKm,
  });

  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? vehicleName;
  final int? vehicleRangeKm;

  factory AppUser.fromMap(String id, Map<String, dynamic> map) {
    return AppUser(
      id: id,
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      phone: map['phone'] as String?,
      vehicleName: map['vehicleName'] as String?,
      vehicleRangeKm: map['vehicleRangeKm'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'vehicleName': vehicleName,
      'vehicleRangeKm': vehicleRangeKm,
    };
  }

  AppUser copyWith({
    String? name,
    String? email,
    String? phone,
    String? vehicleName,
    int? vehicleRangeKm,
  }) {
    return AppUser(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      vehicleName: vehicleName ?? this.vehicleName,
      vehicleRangeKm: vehicleRangeKm ?? this.vehicleRangeKm,
    );
  }
}
