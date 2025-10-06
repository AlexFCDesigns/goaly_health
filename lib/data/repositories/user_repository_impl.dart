import '../../domain/models/app_user.dart';
import '../../domain/repositories/user_repository.dart';
import '../services/user_service.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService _userService;

  UserRepositoryImpl(this._userService);

  @override
  Future<void> createUser(AppUser user) async {
    await _userService.createUser(user);
  }

  @override
  Future<AppUser?> getUserById(String userId) async {
    return await _userService.getUserById(userId);
  }

  @override
  Future<void> updateUser(AppUser user) async {
    await _userService.updateUser(user);
  }

  @override
  Future<void> deleteUser(String userId) async {
    await _userService.deleteUser(userId);
  }

  @override
  Stream<AppUser?> getUserStream(String userId) {
    return _userService.getUserStream(userId);
  }
}
