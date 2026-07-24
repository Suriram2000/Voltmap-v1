import 'package:cloud_firestore/cloud_firestore.dart';

import 'favorites_repository.dart';

class FirestoreFavoritesRepository implements FavoritesRepository {
  FirestoreFavoritesRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _favorites(String userId) =>
      _firestore.collection('users').doc(userId).collection('favorites');

  @override
  Stream<Set<String>> watchFavorites(String userId) {
    return _favorites(userId).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.id).toSet(),
        );
  }

  @override
  Future<void> addFavorite(String userId, String stationId) {
    return _favorites(userId).doc(stationId).set({
      'stationId': stationId,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> removeFavorite(String userId, String stationId) {
    return _favorites(userId).doc(stationId).delete();
  }
}
