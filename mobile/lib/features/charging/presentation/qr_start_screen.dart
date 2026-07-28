import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/application/auth_providers.dart';
import '../../qr/models/charger_qr_payload.dart';
import '../../qr/presentation/qr_scanner_screen.dart';
import '../data/firestore_charging_session_repository.dart';
import '../models/charging_session.dart';

class QrStartScreen extends ConsumerStatefulWidget {
  const QrStartScreen({super.key});

  @override
  ConsumerState<QrStartScreen> createState() => _QrStartScreenState();
}

class _QrStartScreenState extends ConsumerState<QrStartScreen> {
  final _stationController = TextEditingController();
  final _connectorController = TextEditingController();
  bool _starting = false;

  @override
  void dispose() {
    _stationController.dispose();
    _connectorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Charging'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Container(
            height: 210,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color:
                  Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: const Icon(
              Icons.qr_code_scanner,
              size: 110,
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: _openScanner,
            icon: const Icon(Icons.camera_alt),
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text('Scan Charger QR'),
            ),
          ),
          const SizedBox(height: 24),
          const Row(
            children: [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('or enter manually'),
              ),
              Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _stationController,
            decoration: const InputDecoration(
              labelText: 'Station ID',
              prefixIcon: Icon(Icons.ev_station),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _connectorController,
            decoration: const InputDecoration(
              labelText: 'Connector ID',
              prefixIcon: Icon(Icons.electrical_services),
            ),
          ),
          const SizedBox(height: 22),
          OutlinedButton.icon(
            onPressed: _starting ? null : _startSession,
            icon: _starting
                ? const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.bolt),
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text('Start Charging Session'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openScanner() async {
    final result = await Navigator.push<ChargerQrPayload>(
      context,
      MaterialPageRoute(
        builder: (_) => const QrScannerScreen(),
      ),
    );

    if (result == null) return;

    _stationController.text = result.stationId;
    _connectorController.text = result.connectorId;

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Charger verified: ${result.displayCode}'),
      ),
    );
  }

  Future<void> _startSession() async {
    final user = ref.read(authStateProvider).valueOrNull;
    final stationId = _stationController.text.trim();
    final connectorId = _connectorController.text.trim();

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign in before charging.')),
      );
      return;
    }

    if (stationId.isEmpty || connectorId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter both station and connector IDs.'),
        ),
      );
      return;
    }

    setState(() => _starting = true);

    try {
      final repository = FirestoreChargingSessionRepository();

      final sessionId = await repository.createSession(
        ChargingSession(
          id: '',
          userId: user.uid,
          stationId: stationId,
          connectorId: connectorId,
          status: ChargingSessionStatus.preparing,
          startedAt: DateTime.now(),
        ),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Charging session created: $sessionId'),
        ),
      );
    } on Exception catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to start session: $error')),
      );
    } finally {
      if (mounted) {
        setState(() => _starting = false);
      }
    }
  }
}
