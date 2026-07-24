import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/app_user.dart';
import '../../auth/application/auth_providers.dart';
import '../data/firestore_profile_repository.dart';
import '../data/profile_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => FirestoreProfileRepository(),
);

final currentProfileProvider = FutureProvider<AppUser?>((ref) async {
  final authUser = ref.watch(authStateProvider).valueOrNull;

  if (authUser == null) {
    return null;
  }

  final repository = ref.watch(profileRepositoryProvider);
  final existing = await repository.fetchProfile(authUser.uid);

  if (existing != null) {
    return existing;
  }

  final newProfile = AppUser(
    id: authUser.uid,
    name: authUser.displayName ?? '',
    email: authUser.email ?? '',
  );

  await repository.saveProfile(newProfile);
  return newProfile;
});
