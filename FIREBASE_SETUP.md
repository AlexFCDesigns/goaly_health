# Configuración de Firebase para Goaly App

## Pasos para configurar Firebase

### 1. Crear proyecto en Firebase Console

1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Haz clic en "Crear un proyecto"
3. Ingresa el nombre del proyecto: `goaly-app` (o el que prefieras)
4. Habilita Google Analytics (opcional)
5. Crea el proyecto

### 2. Configurar Authentication

1. En el panel lateral, ve a "Authentication"
2. Haz clic en "Comenzar"
3. Ve a la pestaña "Sign-in method"
4. Habilita "Correo electrónico/contraseña"
5. Guarda los cambios

### 3. Configurar Firestore Database

1. En el panel lateral, ve a "Firestore Database"
2. Haz clic en "Crear base de datos"
3. Selecciona "Comenzar en modo de prueba" (para desarrollo)
4. Elige una ubicación para tu base de datos
5. Haz clic en "Habilitar"

### 4. Configurar la aplicación Flutter

#### Para Android:

1. En Firebase Console, haz clic en el ícono de Android
2. Ingresa el nombre del paquete: `com.example.goaly_app`
3. Descarga el archivo `google-services.json`
4. Coloca el archivo en `android/app/google-services.json`

#### Para iOS:

1. En Firebase Console, haz clic en el ícono de iOS
2. Ingresa el ID del paquete: `com.example.goalyApp`
3. Descarga el archivo `GoogleService-Info.plist`
4. Coloca el archivo en `ios/Runner/GoogleService-Info.plist`

### 5. Actualizar firebase_options.dart

Después de configurar las plataformas, ejecuta:

```bash
flutterfire configure
```

Esto actualizará automáticamente el archivo `lib/firebase_options.dart` con las configuraciones correctas.

### 6. Reglas de Firestore (Opcional)

Para mayor seguridad, puedes configurar reglas de Firestore. Ve a "Firestore Database" > "Reglas" y actualiza:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Los usuarios solo pueden leer y escribir sus propios datos
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

### 7. Ejecutar la aplicación

```bash
flutter pub get
flutter run
```

## Estructura de la base de datos

La aplicación creará automáticamente documentos en la colección `users` con la siguiente estructura:

```json
{
  "id": "user_uid",
  "email": "usuario@ejemplo.com",
  "name": "Nombre del Usuario",
  "createdAt": "2024-01-01T00:00:00.000Z",
  "photoUrl": null
}
```

## Funcionalidades implementadas

- ✅ Registro de usuarios con email y contraseña
- ✅ Inicio de sesión con email y contraseña
- ✅ Persistencia de sesión
- ✅ Almacenamiento de datos de usuario en Firestore
- ✅ Validación de formularios
- ✅ Manejo de errores
- ✅ Estados de carga
- ✅ Arquitectura limpia con Riverpod
- ✅ Separación en capas (data, domain, presentation)

## Próximos pasos

1. Configurar Firebase según las instrucciones
2. Ejecutar `flutterfire configure` para actualizar las configuraciones
3. Probar la aplicación en un dispositivo o emulador
4. Personalizar la UI según tus necesidades
