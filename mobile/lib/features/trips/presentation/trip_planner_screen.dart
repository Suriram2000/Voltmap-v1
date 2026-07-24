import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/trip_providers.dart';
import 'trip_result_screen.dart';

class TripPlannerScreen extends ConsumerStatefulWidget {
  const TripPlannerScreen({super.key});

  @override
  ConsumerState<TripPlannerScreen> createState() =>
      _TripPlannerScreenState();
}

class _TripPlannerScreenState extends ConsumerState<TripPlannerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _originController = TextEditingController();
  final _destinationController = TextEditingController();

  double _vehicleRangeKm = 350;
  double _startingChargePercent = 80;

  @override
  void dispose() {
    _originController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(tripPlannerProvider, (previous, next) {
      next.whenOrNull(
        data: (plan) {
          if (plan == null || !mounted) return;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TripResultScreen(plan: plan),
            ),
          );

          ref.read(tripPlannerProvider.notifier).clear();
        },
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unable to plan trip: $error')),
          );
        },
      );
    });

    final state = ref.watch(tripPlannerProvider);
    final isLoading = state.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Plan a Trip',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Plan charging stops before you drive.',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _originController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Starting point',
                prefixIcon: Icon(Icons.trip_origin),
              ),
              validator: _requiredValidator,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _destinationController,
              decoration: const InputDecoration(
                labelText: 'Destination',
                prefixIcon: Icon(Icons.location_on),
              ),
              validator: _requiredValidator,
            ),
            const SizedBox(height: 26),
            Text(
              'Vehicle range: ${_vehicleRangeKm.round()} km',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              min: 120,
              max: 700,
              divisions: 29,
              value: _vehicleRangeKm,
              label: '${_vehicleRangeKm.round()} km',
              onChanged: (value) {
                setState(() => _vehicleRangeKm = value);
              },
            ),
            const SizedBox(height: 16),
            Text(
              'Starting charge: ${_startingChargePercent.round()}%',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              min: 10,
              max: 100,
              divisions: 18,
              value: _startingChargePercent,
              label: '${_startingChargePercent.round()}%',
              onChanged: (value) {
                setState(() => _startingChargePercent = value);
              },
            ),
            const SizedBox(height: 28),
            FilledButton.icon(
              onPressed: isLoading ? null : _createTrip,
              icon: isLoading
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.route),
              label: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Text(isLoading ? 'Planning...' : 'Create Trip Plan'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required.';
    }

    return null;
  }

  Future<void> _createTrip() async {
    if (!_formKey.currentState!.validate()) return;

    await ref.read(tripPlannerProvider.notifier).createTrip(
          origin: _originController.text.trim(),
          destination: _destinationController.text.trim(),
          vehicleRangeKm: _vehicleRangeKm.round(),
          startingChargePercent: _startingChargePercent.round(),
        );
  }
}
