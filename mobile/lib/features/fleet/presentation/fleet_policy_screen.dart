import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/fleet_providers.dart';
import '../models/fleet_charging_policy.dart';

class FleetPolicyScreen extends ConsumerStatefulWidget {
  const FleetPolicyScreen({
    required this.fleetId,
    super.key,
  });

  final String fleetId;

  @override
  ConsumerState<FleetPolicyScreen> createState() =>
      _FleetPolicyScreenState();
}

class _FleetPolicyScreenState
    extends ConsumerState<FleetPolicyScreen> {
  bool allowFastCharging = true;
  bool allowRoaming = true;
  double maximumSessionCost = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Charging Policy')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SwitchListTile(
            value: allowFastCharging,
            title: const Text('Allow fast charging'),
            onChanged: (value) {
              setState(() => allowFastCharging = value);
            },
          ),
          SwitchListTile(
            value: allowRoaming,
            title: const Text('Allow roaming networks'),
            onChanged: (value) {
              setState(() => allowRoaming = value);
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Maximum session cost: '
            '\$${maximumSessionCost.toStringAsFixed(0)}',
          ),
          Slider(
            min: 10,
            max: 300,
            divisions: 29,
            value: maximumSessionCost,
            onChanged: (value) {
              setState(() => maximumSessionCost = value);
            },
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _save,
            child: const Text('Save Policy'),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    await ref.read(fleetRepositoryProvider).savePolicy(
          FleetChargingPolicy(
            fleetId: widget.fleetId,
            allowFastCharging: allowFastCharging,
            allowRoaming: allowRoaming,
            maximumSessionCostCents:
                (maximumSessionCost * 100).round(),
          ),
        );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fleet policy saved.')),
    );
  }
}
