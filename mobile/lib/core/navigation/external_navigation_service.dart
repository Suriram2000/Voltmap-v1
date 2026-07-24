import 'package:url_launcher/url_launcher.dart';

class ExternalNavigationService {
  const ExternalNavigationService();

  Future<void> openDirections({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
      '&destination=$latitude,$longitude'
      '&travelmode=driving',
    );

    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched) {
      throw StateError('Unable to open navigation.');
    }
  }

  Future<void> openTrip({
    required String origin,
    required String destination,
  }) async {
    final uri = Uri.https(
      'www.google.com',
      '/maps/dir/',
      {
        'api': '1',
        'origin': origin,
        'destination': destination,
        'travelmode': 'driving',
      },
    );

    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched) {
      throw StateError('Unable to open trip navigation.');
    }
  }
}
