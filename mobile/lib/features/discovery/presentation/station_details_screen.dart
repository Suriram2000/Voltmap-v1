import 'package:flutter/material.dart';

import '../../../core/navigation/external_navigation_service.dart';
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
    const navigationService = ExternalNavigationService();

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
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(child: Icon(Icons.bolt)),
            title: const Text('Maximum power'),
            subtitle: Text('${station.maxPowerKw} kW'),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              child: Icon(Icons.electrical_services),
            ),
            title: const Text('Connectors'),
            subtitle: Text(station.connectorSummary),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(child: Icon(Icons.currency_rupee)),
            title: const Text('Price'),
            subtitle: Text(
              '₹${station.pricePerKwh.toStringAsFixed(0)} per kWh',
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () async {
              try {
                await navigationService.openDirections(
                  latitude: station.position.latitude,
                  longitude: station.position.longitude,
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
              child: Text('Navigate'),
            ),
          ),
        ],
      ),
    );
  }
}
