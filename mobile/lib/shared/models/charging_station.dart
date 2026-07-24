import 'package:google_maps_flutter/google_maps_flutter.dart';

enum ChargerStatus { available, busy, offline }
enum ConnectorType { ccs2, chademo, type2, bharatDc001, gbT }

class ChargingStation {
  const ChargingStation({
    required this.id,
    required this.name,
    required this.network,
    required this.position,
    required this.distanceKm,
    required this.maxPowerKw,
    required this.availableConnectors,
    required this.totalConnectors,
    required this.pricePerKwh,
    required this.status,
    required this.address,
    required this.connectorTypes,
    required this.isOpen24Hours,
  });

  final String id;
  final String name;
  final String network;
  final LatLng position;
  final double distanceKm;
  final int maxPowerKw;
  final int availableConnectors;
  final int totalConnectors;
  final double pricePerKwh;
  final ChargerStatus status;
  final String address;
  final List<ConnectorType> connectorTypes;
  final bool isOpen24Hours;

  bool get isAvailable =>
      status == ChargerStatus.available && availableConnectors > 0;

  String get connectorSummary =>
      connectorTypes.map((type) => type.label).join(', ');
}

extension ConnectorTypeLabel on ConnectorType {
  String get label => switch (this) {
        ConnectorType.ccs2 => 'CCS2',
        ConnectorType.chademo => 'CHAdeMO',
        ConnectorType.type2 => 'Type 2',
        ConnectorType.bharatDc001 => 'Bharat DC-001',
        ConnectorType.gbT => 'GB/T',
      };
}
