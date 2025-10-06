import '../models/app_user.dart';

abstract class UserRepository {
  Future<void> createUser(AppUser user);
  Future<AppUser?> getUserById(String userId);
  Future<void> updateUser(AppUser user);
  Future<void> deleteUser(String userId);
  Stream<AppUser?> getUserStream(String userId);
}
