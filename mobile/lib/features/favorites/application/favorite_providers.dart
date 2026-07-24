import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/application/auth_providers.dart';
import '../data/favorites_repository.dart';
import '../data/firestore_favorites_repository.dart';

final favoritesRepositoryProvider = Provider<FavoritesRepository>(
  (ref) => FirestoreFavoritesRepository(),
);

final persistentFavoriteIdsProvider = StreamProvider<Set<String>>((ref) {
  final authUser = ref.watch(authStateProvider).valueOrNull;

  if (authUser == null) {
    return Stream.value(<String>{});
  }

  return ref
      .watch(favoritesRepositoryProvider)
      .watchFavorites(authUser.uid);
});
