import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/fleet_providers.dart';
import 'fleet_drivers_screen.dart';
import 'fleet_policy_screen.dart';
import 'fleet_usage_summary.dart';
import 'fleet_vehicles_screen.dart';

class FleetDashboardScreen extends ConsumerWidget {
  const FleetDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fleets = ref.watch(fleetsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fleet Management',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: fleets.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Text('No fleet account is assigned yet.'),
            );
          }

          final fleet = items.first;
          final sessions = ref.watch(
            fleetSessionsProvider(fleet.id),
          );

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                fleet.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                fleet.billingEmail ?? 'Business charging account',
              ),
              const SizedBox(height: 20),
              sessions.when(
                data: (items) => FleetUsageSummary(sessions: items),
                loading: () => const LinearProgressIndicator(),
                error: (error, _) => Text(
                  'Unable to load usage: $error',
                ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.badge),
                      title: const Text('Drivers'),
                      subtitle: const Text(
                        'Invite and manage fleet drivers',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FleetDriversScreen(
                            fleetId: fleet.id,
                          ),
                        ),
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.local_shipping),
                      title: const Text('Vehicles'),
                      subtitle: const Text(
                        'Assign vehicles and track range',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FleetVehiclesScreen(
                            fleetId: fleet.id,
                          ),
                        ),
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.policy),
                      title: const Text('Charging policy'),
                      subtitle: const Text(
                        'Control networks, limits, and approvals',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FleetPolicyScreen(
                            fleetId: fleet.id,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) => Center(
          child: Text('Unable to load fleet: $error'),
        ),
      ),
    );
  }
}
