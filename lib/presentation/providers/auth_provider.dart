import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/user_repository.dart';
import 'service_providers.dart';

part 'auth_provider.freezed.dart';

// Estado de autenticación
@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    @Default(false) bool isAuthenticated,
    firebase_auth.User? firebaseUser,
    AppUser? appUser,
    String? error,
  }) = _AuthState;
}

// Provider del estado de autenticación
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userRepository = ref.watch(userRepositoryProvider);
  return AuthNotifier(authRepository, userRepository);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  AuthNotifier(this._authRepository, this._userRepository)
    : super(const AuthState()) {
    _init();
  }

  void _init() {
    // Escuchar cambios en el estado de autenticación
    _authRepository.authStateChanges.listen((firebaseUser) async {
      if (firebaseUser != null) {
        // Usuario autenticado, obtener datos del usuario
        final appUser = await _userRepository.getUserById(firebaseUser.uid);
        state = state.copyWith(
          isAuthenticated: true,
          firebaseUser: firebaseUser,
          appUser: appUser,
          isLoading: false,
          error: null,
        );
      } else {
        // Usuario no autenticado
        state = state.copyWith(
          isAuthenticated: false,
          firebaseUser: null,
          appUser: null,
          isLoading: false,
          error: null,
        );
      }
    });
  }

  // Registro
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final credential = await _authRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Crear usuario en Firestore
      final user = AppUser(
        id: credential.user!.uid,
        name: name,
        email: email,
        fechaRegistro: DateTime.now(),
      );

      await _userRepository.createUser(user);

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        firebaseUser: credential.user,
        appUser: user,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Inicio de sesión
  Future<void> signIn({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final credential = await _authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Obtener datos del usuario desde Firestore
      final appUser = await _userRepository.getUserById(credential.user!.uid);

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        firebaseUser: credential.user,
        appUser: appUser,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _authRepository.signOut();
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        firebaseUser: null,
        appUser: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Limpiar error
  void clearError() {
    state = state.copyWith(error: null);
  }
}
