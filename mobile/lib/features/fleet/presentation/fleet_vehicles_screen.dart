import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/fleet_providers.dart';
import '../models/fleet_vehicle.dart';

class FleetVehiclesScreen extends ConsumerWidget {
  const FleetVehiclesScreen({
    required this.fleetId,
    super.key,
  });

  final String fleetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicles = ref.watch(fleetVehiclesProvider(fleetId));

    return Scaffold(
      appBar: AppBar(title: const Text('Fleet Vehicles')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addVehicle(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Add Vehicle'),
      ),
      body: vehicles.when(
        data: (items) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final vehicle = items[index];

            return Card(
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.local_shipping),
                ),
                title: Text(vehicle.name),
                subtitle: Text(
                  '${vehicle.registrationNumber} • ${vehicle.rangeKm} km',
                ),
              ),
            );
          },
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) => Center(
          child: Text('Unable to load vehicles: $error'),
        ),
      ),
    );
  }

  Future<void> _addVehicle(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final nameController = TextEditingController();
    final registrationController = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add fleet vehicle'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Vehicle name',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: registrationController,
              decoration: const InputDecoration(
                labelText: 'Registration number',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(fleetRepositoryProvider).addVehicle(
            FleetVehicle(
              id: '',
              fleetId: fleetId,
              name: nameController.text.trim(),
              registrationNumber:
                  registrationController.text.trim(),
            ),
          );
    }

    nameController.dispose();
    registrationController.dispose();
  }
}
