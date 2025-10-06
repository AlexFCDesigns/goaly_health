import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/auth_service.dart';
import '../../data/services/user_service.dart';
import '../../data/services/health_entry_service.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../data/repositories/health_entry_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/repositories/health_entry_repository.dart';

// Providers de servicios
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final userServiceProvider = Provider<UserService>((ref) {
  return UserService();
});

final healthEntryServiceProvider = Provider<HealthEntryService>((ref) {
  return HealthEntryService();
});

// Providers de repositorios
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthRepositoryImpl(authService);
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final userService = ref.watch(userServiceProvider);
  return UserRepositoryImpl(userService);
});

final healthEntryRepositoryProvider = Provider<HealthEntryRepository>((ref) {
  final healthEntryService = ref.watch(healthEntryServiceProvider);
  return HealthEntryRepositoryImpl(healthEntryService);
});
