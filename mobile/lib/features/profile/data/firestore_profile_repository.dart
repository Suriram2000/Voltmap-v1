import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../shared/models/app_user.dart';
import 'profile_repository.dart';

class FirestoreProfileRepository implements ProfileRepository {
  FirestoreProfileRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection('users');

  @override
  Future<AppUser?> fetchProfile(String userId) async {
    final snapshot = await _users.doc(userId).get();

    if (!snapshot.exists || snapshot.data() == null) {
      return null;
    }

    return AppUser.fromMap(snapshot.id, snapshot.data()!);
  }

  @override
  Future<void> saveProfile(AppUser user) {
    return _users.doc(user.id).set(
          user.toMap(),
          SetOptions(merge: true),
        );
  }
}
