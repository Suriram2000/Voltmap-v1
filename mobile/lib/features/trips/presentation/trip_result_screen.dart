import 'package:flutter/material.dart';

import '../../../core/navigation/external_navigation_service.dart';
import '../models/trip_plan.dart';
import 'widgets/trip_stop_card.dart';

class TripResultScreen extends StatelessWidget {
  const TripResultScreen({
    required this.plan,
    super.key,
  });

  final TripPlan plan;

  @override
  Widget build(BuildContext context) {
    const navigationService = ExternalNavigationService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Plan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            '${plan.origin} → ${plan.destination}',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  icon: Icons.route,
                  label: 'Distance',
                  value: '${plan.distanceKm.toStringAsFixed(0)} km',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  icon: Icons.schedule,
                  label: 'Time',
                  value: plan.durationLabel,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  icon: Icons.ev_station,
                  label: 'Stops',
                  value: '${plan.stopCount}',
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          Text(
            plan.recommendedStops.isEmpty
                ? 'No charging stop required'
                : 'Recommended charging stops',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 12),
          if (plan.recommendedStops.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Text(
                  'Your estimated starting charge should cover this trip.',
                ),
              ),
            )
          else
            for (var i = 0; i < plan.recommendedStops.length; i++)
              TripStopCard(
                index: i,
                station: plan.recommendedStops[i],
              ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () async {
              try {
                await navigationService.openTrip(
                  origin: plan.origin,
                  destination: plan.destination,
                );
              } on Exception catch (error) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error.toString())),
                );
              }
            },
            icon: const Icon(Icons.navigation),
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text('Start Navigation'),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            Icon(icon),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
