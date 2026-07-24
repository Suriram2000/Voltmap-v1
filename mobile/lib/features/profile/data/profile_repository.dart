import '../../../shared/models/app_user.dart';

abstract interface class ProfileRepository {
  Future<AppUser?> fetchProfile(String userId);
  Future<void> saveProfile(AppUser user);
}
