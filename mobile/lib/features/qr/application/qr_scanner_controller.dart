import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/charger_qr_payload.dart';

final qrScannerControllerProvider =
    NotifierProvider<QrScannerController, ChargerQrPayload?>(
  QrScannerController.new,
);

class QrScannerController extends Notifier<ChargerQrPayload?> {
  @override
  ChargerQrPayload? build() => null;

  bool parse(String rawValue) {
    final payload = ChargerQrPayload.tryParse(rawValue);

    if (payload == null) {
      return false;
    }

    state = payload;
    return true;
  }

  void clear() {
    state = null;
  }
}
