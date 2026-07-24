import 'package:flutter/material.dart';

import '../../../../shared/models/charging_station.dart';

class StationCard extends StatelessWidget {
  const StationCard({
    required this.station,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoritePressed,
    super.key,
  });

  final ChargingStation station;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoritePressed;

  @override
  Widget build(BuildContext context) {
    final statusColor = switch (station.status) {
      ChargerStatus.available => Colors.green,
      ChargerStatus.busy => Colors.orange,
      ChargerStatus.offline => Colors.red,
    };

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: statusColor.withValues(alpha: 0.14),
                child: Icon(Icons.ev_station, color: statusColor),
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
                    Text('${station.network} • ${station.distanceKm} km'),
                    const SizedBox(height: 6),
                    Text(
                      '${station.maxPowerKw} kW • '
                      '${station.availableConnectors}/${station.totalConnectors} available',
                    ),
                    const SizedBox(height: 6),
                    Text(
                      station.connectorSummary,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: isFavorite ? 'Remove favorite' : 'Add favorite',
                onPressed: onFavoritePressed,
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
