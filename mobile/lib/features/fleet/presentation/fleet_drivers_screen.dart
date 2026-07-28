import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/fleet_providers.dart';
import '../models/fleet_driver.dart';

class FleetDriversScreen extends ConsumerWidget {
  const FleetDriversScreen({
    required this.fleetId,
    super.key,
  });

  final String fleetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drivers = ref.watch(fleetDriversProvider(fleetId));

    return Scaffold(
      appBar: AppBar(title: const Text('Fleet Drivers')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addDriver(context, ref),
        icon: const Icon(Icons.person_add),
        label: const Text('Add Driver'),
      ),
      body: drivers.when(
        data: (items) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final driver = items[index];

            return Card(
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text(driver.name),
                subtitle: Text(driver.email),
                trailing: Chip(
                  label: Text(driver.status.name),
                ),
              ),
            );
          },
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) => Center(
          child: Text('Unable to load drivers: $error'),
        ),
      ),
    );
  }

  Future<void> _addDriver(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final nameController = TextEditingController();
    final emailController = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add fleet driver'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Driver name',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
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
      await ref.read(fleetRepositoryProvider).addDriver(
            FleetDriver(
              id: '',
              fleetId: fleetId,
              name: nameController.text.trim(),
              email: emailController.text.trim(),
            ),
          );
    }

    nameController.dispose();
    emailController.dispose();
  }
}
