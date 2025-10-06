import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Configuración de Firebase para la aplicación
class FirebaseConfig {
  static FirebaseApp? _app;
  static FirebaseAuth? _auth;
  static FirebaseFirestore? _firestore;

  /// Inicializa Firebase con la configuración por defecto
  static Future<void> initialize() async {
    _app = await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;

    // Configurar Firestore para desarrollo
    if (FirebaseConfig.isDevelopment) {
      _firestore?.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );
    }
  }

  /// Verifica si estamos en modo desarrollo
  static bool get isDevelopment {
    const bool.fromEnvironment('dart.vm.product') == false;
    return true; // Cambiar a false en producción
  }

  /// Obtiene la instancia de Firebase Auth
  static FirebaseAuth get auth {
    if (_auth == null) {
      throw Exception(
        'Firebase no ha sido inicializado. Llama a FirebaseConfig.initialize() primero.',
      );
    }
    return _auth!;
  }

  /// Obtiene la instancia de Firestore
  static FirebaseFirestore get firestore {
    if (_firestore == null) {
      throw Exception(
        'Firebase no ha sido inicializado. Llama a FirebaseConfig.initialize() primero.',
      );
    }
    return _firestore!;
  }

  /// Obtiene la instancia de Firebase App
  static FirebaseApp get app {
    if (_app == null) {
      throw Exception(
        'Firebase no ha sido inicializado. Llama a FirebaseConfig.initialize() primero.',
      );
    }
    return _app!;
  }
}
