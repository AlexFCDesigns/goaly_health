import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String name,
    required String email,
    required DateTime fechaRegistro,
    // Datos inamovibles del perfil
    required double altura, // en cm
    required double pesoObjetivo, // en kg
    required String genero, // 'masculino' o 'femenino'
    required DateTime fechaNacimiento,
    required String
    nivelActividad, // 'sedentario', 'ligero', 'moderado', 'intenso', 'muy_intenso'
    String?
    objetivoSalud, // 'perder_peso', 'ganar_peso', 'mantener', 'ganar_musculo'
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  factory AppUser.fromMap(Map<String, dynamic> map) => AppUser(
    id: map['id'] as String,
    name: map['name'] as String,
    email: map['email'] as String,
    fechaRegistro: DateTime.parse(map['fechaRegistro'] as String),
    altura: (map['altura'] as num).toDouble(),
    pesoObjetivo: (map['pesoObjetivo'] as num).toDouble(),
    genero: map['genero'] as String,
    fechaNacimiento: DateTime.parse(map['fechaNacimiento'] as String),
    nivelActividad: map['nivelActividad'] as String,
    objetivoSalud: map['objetivoSalud'] as String?,
  );
}
