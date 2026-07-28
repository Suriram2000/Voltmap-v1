import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local_settings_repository.dart';
import '../data/settings_repository.dart';
import '../models/app_settings.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => const LocalSettingsRepository(),
);

final appSettingsProvider =
    AsyncNotifierProvider<AppSettingsController, AppSettings>(
  AppSettingsController.new,
);

class AppSettingsController extends AsyncNotifier<AppSettings> {
  @override
  Future<AppSettings> build() {
    return ref.read(settingsRepositoryProvider).load();
  }

  Future<void> update(AppSettings settings) async {
    state = AsyncData(settings);
    await ref.read(settingsRepositoryProvider).save(settings);
  }
}
