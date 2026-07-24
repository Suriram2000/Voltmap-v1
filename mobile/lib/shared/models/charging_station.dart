import 'package:google_maps_flutter/google_maps_flutter.dart';

enum ChargerStatus { available, busy, offline }

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
}
