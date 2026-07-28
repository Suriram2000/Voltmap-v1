class ChargerQrPayload {
  const ChargerQrPayload({
    required this.stationId,
    required this.connectorId,
    this.network,
  });

  final String stationId;
  final String connectorId;
  final String? network;

  static ChargerQrPayload? tryParse(String rawValue) {
    final value = rawValue.trim();

    if (value.isEmpty) {
      return null;
    }

    final uri = Uri.tryParse(value);

    if (uri != null &&
        uri.scheme.toLowerCase() == 'voltmap' &&
        uri.host.toLowerCase() == 'charger') {
      final stationId = uri.queryParameters['stationId'];
      final connectorId = uri.queryParameters['connectorId'];

      if (stationId == null ||
          stationId.isEmpty ||
          connectorId == null ||
          connectorId.isEmpty) {
        return null;
      }

      return ChargerQrPayload(
        stationId: stationId,
        connectorId: connectorId,
        network: uri.queryParameters['network'],
      );
    }

    final parts = value.split(':');

    if (parts.length == 2 &&
        parts[0].trim().isNotEmpty &&
        parts[1].trim().isNotEmpty) {
      return ChargerQrPayload(
        stationId: parts[0].trim(),
        connectorId: parts[1].trim(),
      );
    }

    return null;
  }

  String get displayCode => '$stationId • $connectorId';
}
