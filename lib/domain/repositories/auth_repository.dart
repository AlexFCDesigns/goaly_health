import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Stream<User?> get authStateChanges;
  User? get currentUser;
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> signOut();
}
