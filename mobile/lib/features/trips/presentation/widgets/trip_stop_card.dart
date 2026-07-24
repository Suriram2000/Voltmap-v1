import 'package:flutter/material.dart';

import '../../../../shared/models/charging_station.dart';

class TripStopCard extends StatelessWidget {
  const TripStopCard({
    required this.index,
    required this.station,
    super.key,
  });

  final int index;
  final ChargingStation station;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              child: Text('${index + 1}'),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    station.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(station.address),
                  const SizedBox(height: 8),
                  Text(
                    '${station.maxPowerKw} kW • '
                    '${station.availableConnectors}/${station.totalConnectors} available',
                  ),
                  Text(
                    '₹${station.pricePerKwh.toStringAsFixed(0)}/kWh • '
                    '${station.connectorSummary}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
