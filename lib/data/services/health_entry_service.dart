import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/health_entry.dart';

class HealthEntryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = 'health_entries';

  // Crear registro de salud
  Future<void> createHealthEntry(HealthEntry entry) async {
    try {
      print('HealthEntryService: Creando registro con ID: ${entry.id}');
      print('HealthEntryService: Datos del registro: ${entry.toJson()}');
      await _firestore
          .collection(_collection)
          .doc(entry.id)
          .set(entry.toJson());
      print('HealthEntryService: Registro creado exitosamente en Firestore');
    } catch (e) {
      print('HealthEntryService: Error al crear registro: $e');
      throw 'Error al crear registro de salud: $e';
    }
  }

  // Obtener todos los registros de un usuario ordenados por fecha
  Future<List<HealthEntry>> getHealthEntriesByUser(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .orderBy('fecha', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => HealthEntry.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw 'Error al obtener registros de salud: $e';
    }
  }

  // Stream de registros de salud de un usuario
  Stream<List<HealthEntry>> getHealthEntriesStream(String userId) {
    print('HealthEntryService: Iniciando stream para usuario: $userId');
    return _firestore
        .collection(_collection)
        .where('userId', isEqualTo: userId)
        .orderBy('fecha', descending: true)
        .snapshots()
        .map((snapshot) {
          print(
            'HealthEntryService: Snapshot recibido con ${snapshot.docs.length} documentos',
          );
          final entries = snapshot.docs
              .map((doc) => HealthEntry.fromMap(doc.data()))
              .toList();
          print('HealthEntryService: Entradas procesadas: ${entries.length}');
          return entries;
        });
  }

  // Obtener un registro específico
  Future<HealthEntry?> getHealthEntryById(String entryId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(entryId).get();

      if (doc.exists && doc.data() != null) {
        return HealthEntry.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      throw 'Error al obtener registro de salud: $e';
    }
  }

  // Actualizar registro de salud
  Future<void> updateHealthEntry(HealthEntry entry) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(entry.id)
          .update(entry.toJson());
    } catch (e) {
      throw 'Error al actualizar registro de salud: $e';
    }
  }

  // Eliminar registro de salud
  Future<void> deleteHealthEntry(String entryId) async {
    try {
      await _firestore.collection(_collection).doc(entryId).delete();
    } catch (e) {
      throw 'Error al eliminar registro de salud: $e';
    }
  }

  // Obtener el último registro de un usuario
  Future<HealthEntry?> getLastHealthEntry(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .orderBy('fecha', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return HealthEntry.fromMap(querySnapshot.docs.first.data());
      }
      return null;
    } catch (e) {
      throw 'Error al obtener último registro: $e';
    }
  }
}
