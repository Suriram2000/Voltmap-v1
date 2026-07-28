import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/fleet_charging_session.dart';

class FleetUsageSummary extends StatelessWidget {
  const FleetUsageSummary({
    required this.sessions,
    super.key,
  });

  final List<FleetChargingSession> sessions;

  @override
  Widget build(BuildContext context) {
    final energy = sessions.fold<double>(
      0,
      (total, session) => total + session.energyKwh,
    );

    final costCents = sessions.fold<int>(
      0,
      (total, session) => total + session.costCents,
    );

    final currency = NumberFormat.simpleCurrency(locale: 'en_US');

    return Row(
      children: [
        Expanded(
          child: _MetricCard(
            icon: Icons.bolt,
            label: 'Energy',
            value: '${energy.toStringAsFixed(1)} kWh',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _MetricCard(
            icon: Icons.payments,
            label: 'Spend',
            value: currency.format(costCents / 100),
          ),
        ),
      ],
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
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Icon(icon),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}
