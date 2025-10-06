import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/app_user.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = 'users';

  // Crear usuario en Firestore
  Future<void> createUser(AppUser user) async {
    try {
      await _firestore.collection(_collection).doc(user.id).set(user.toJson());
    } catch (e) {
      throw 'Error al crear usuario: $e';
    }
  }

  // Obtener usuario por ID
  Future<AppUser?> getUserById(String userId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(userId).get();

      if (doc.exists && doc.data() != null) {
        return AppUser.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      throw 'Error al obtener usuario: $e';
    }
  }

  // Actualizar usuario
  Future<void> updateUser(AppUser user) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(user.id)
          .update(user.toJson());
    } catch (e) {
      throw 'Error al actualizar usuario: $e';
    }
  }

  // Eliminar usuario
  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection(_collection).doc(userId).delete();
    } catch (e) {
      throw 'Error al eliminar usuario: $e';
    }
  }

  // Stream del usuario (para escuchar cambios en tiempo real)
  Stream<AppUser?> getUserStream(String userId) {
    return _firestore.collection(_collection).doc(userId).snapshots().map((
      doc,
    ) {
      if (doc.exists && doc.data() != null) {
        return AppUser.fromMap(doc.data()!);
      }
      return null;
    });
  }
}
