enum ChargerAlertType {
  available,
  bookingReminder,
  chargingStarted,
  chargingCompleted,
  paymentUpdate,
}

class ChargerAlert {
  const ChargerAlert({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.createdAt,
    this.stationId,
    this.sessionId,
  });

  final String id;
  final String title;
  final String message;
  final ChargerAlertType type;
  final DateTime createdAt;
  final String? stationId;
  final String? sessionId;

  factory ChargerAlert.fromMap(Map<String, dynamic> map) {
    return ChargerAlert(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? 'VoltMap',
      message: map['message'] as String? ?? '',
      type: ChargerAlertType.values.firstWhere(
        (value) => value.name == map['type'],
        orElse: () => ChargerAlertType.available,
      ),
      createdAt: DateTime.tryParse(
            map['createdAt'] as String? ?? '',
          ) ??
          DateTime.now(),
      stationId: map['stationId'] as String?,
      sessionId: map['sessionId'] as String?,
    );
  }
}
