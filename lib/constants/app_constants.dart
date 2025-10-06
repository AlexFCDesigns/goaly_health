/// Constantes de la aplicación
class AppConstants {
  // Nombres de colecciones de Firestore
  static const String usersCollection = 'users';

  // Claves de SharedPreferences
  static const String userSessionKey = 'user_session';
  static const String themeKey = 'theme_mode';

  // Validaciones
  static const int minPasswordLength = 6;
  static const int minNameLength = 2;

  // URLs y endpoints
  static const String privacyPolicyUrl = 'https://example.com/privacy';
  static const String termsOfServiceUrl = 'https://example.com/terms';

  // Mensajes de error comunes
  static const String networkErrorMessage =
      'Error de conexión. Verifica tu internet.';
  static const String unknownErrorMessage = 'Ha ocurrido un error inesperado.';
  static const String authErrorMessage = 'Error de autenticación.';

  // Mensajes de éxito
  static const String loginSuccessMessage = '¡Bienvenido!';
  static const String registerSuccessMessage = '¡Cuenta creada exitosamente!';
  static const String logoutSuccessMessage = 'Sesión cerrada correctamente.';
}
