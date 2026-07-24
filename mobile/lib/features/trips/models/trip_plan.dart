import '../../../shared/models/charging_station.dart';

class TripPlan {
  const TripPlan({
    required this.origin,
    required this.destination,
    required this.distanceKm,
    required this.estimatedDurationMinutes,
    required this.vehicleRangeKm,
    required this.recommendedStops,
  });

  final String origin;
  final String destination;
  final double distanceKm;
  final int estimatedDurationMinutes;
  final int vehicleRangeKm;
  final List<ChargingStation> recommendedStops;

  int get stopCount => recommendedStops.length;

  String get durationLabel {
    final hours = estimatedDurationMinutes ~/ 60;
    final minutes = estimatedDurationMinutes % 60;

    if (hours == 0) return '$minutes min';
    return '${hours}h ${minutes}m';
  }
}
