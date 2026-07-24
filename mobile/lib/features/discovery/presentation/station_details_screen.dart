import 'package:flutter/material.dart';

import '../../../shared/models/charging_station.dart';

class StationDetailsScreen extends StatelessWidget {
  const StationDetailsScreen({
    required this.station,
    required this.isFavorite,
    required this.onFavoritePressed,
    super.key,
  });

  final ChargingStation station;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(station.network),
        actions: [
          IconButton(
            onPressed: onFavoritePressed,
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 190,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.secondaryContainer,
                ],
              ),
            ),
            child: const Icon(Icons.ev_station, size: 96),
          ),
          const SizedBox(height: 20),
          Text(
            station.name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 6),
          Text(station.address),
          const SizedBox(height: 20),
          _DetailRow(
            icon: Icons.bolt,
            title: 'Maximum power',
            value: '${station.maxPowerKw} kW',
          ),
          _DetailRow(
            icon: Icons.electrical_services,
            title: 'Connectors',
            value: station.connectorSummary,
          ),
          _DetailRow(
            icon: Icons.currency_rupee,
            title: 'Price',
            value: '₹${station.pricePerKwh.toStringAsFixed(0)} per kWh',
          ),
          _DetailRow(
            icon: Icons.schedule,
            title: 'Hours',
            value: station.isOpen24Hours ? 'Open 24 hours' : 'Limited hours',
          ),
          _DetailRow(
            icon: Icons.ev_station,
            title: 'Availability',
            value:
                '${station.availableConnectors} of ${station.totalConnectors} connectors',
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Turn-by-turn navigation will be connected next.'),
                ),
              );
            },
            icon: const Icon(Icons.navigation),
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text('Navigate'),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(child: Icon(icon)),
      title: Text(title),
      subtitle: Text(value),
    );
  }
}
