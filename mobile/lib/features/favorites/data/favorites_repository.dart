abstract interface class FavoritesRepository {
  Stream<Set<String>> watchFavorites(String userId);
  Future<void> addFavorite(String userId, String stationId);
  Future<void> removeFavorite(String userId, String stationId);
}
