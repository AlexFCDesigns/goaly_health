// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return _AppUser.fromJson(json);
}

/// @nodoc
mixin _$AppUser {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  DateTime get fechaRegistro =>
      throw _privateConstructorUsedError; // Datos inamovibles del perfil
  double get altura => throw _privateConstructorUsedError; // en cm
  double get pesoObjetivo => throw _privateConstructorUsedError; // en kg
  String get genero =>
      throw _privateConstructorUsedError; // 'masculino' o 'femenino'
  DateTime get fechaNacimiento => throw _privateConstructorUsedError;
  String get nivelActividad =>
      throw _privateConstructorUsedError; // 'sedentario', 'ligero', 'moderado', 'intenso', 'muy_intenso'
  String? get objetivoSalud => throw _privateConstructorUsedError;

  /// Serializes this AppUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppUserCopyWith<AppUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) then) =
      _$AppUserCopyWithImpl<$Res, AppUser>;
  @useResult
  $Res call({
    String id,
    String name,
    String email,
    DateTime fechaRegistro,
    double altura,
    double pesoObjetivo,
    String genero,
    DateTime fechaNacimiento,
    String nivelActividad,
    String? objetivoSalud,
  });
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res, $Val extends AppUser>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? fechaRegistro = null,
    Object? altura = null,
    Object? pesoObjetivo = null,
    Object? genero = null,
    Object? fechaNacimiento = null,
    Object? nivelActividad = null,
    Object? objetivoSalud = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            fechaRegistro: null == fechaRegistro
                ? _value.fechaRegistro
                : fechaRegistro // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            altura: null == altura
                ? _value.altura
                : altura // ignore: cast_nullable_to_non_nullable
                      as double,
            pesoObjetivo: null == pesoObjetivo
                ? _value.pesoObjetivo
                : pesoObjetivo // ignore: cast_nullable_to_non_nullable
                      as double,
            genero: null == genero
                ? _value.genero
                : genero // ignore: cast_nullable_to_non_nullable
                      as String,
            fechaNacimiento: null == fechaNacimiento
                ? _value.fechaNacimiento
                : fechaNacimiento // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            nivelActividad: null == nivelActividad
                ? _value.nivelActividad
                : nivelActividad // ignore: cast_nullable_to_non_nullable
                      as String,
            objetivoSalud: freezed == objetivoSalud
                ? _value.objetivoSalud
                : objetivoSalud // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppUserImplCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$$AppUserImplCopyWith(
    _$AppUserImpl value,
    $Res Function(_$AppUserImpl) then,
  ) = __$$AppUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String email,
    DateTime fechaRegistro,
    double altura,
    double pesoObjetivo,
    String genero,
    DateTime fechaNacimiento,
    String nivelActividad,
    String? objetivoSalud,
  });
}

/// @nodoc
class __$$AppUserImplCopyWithImpl<$Res>
    extends _$AppUserCopyWithImpl<$Res, _$AppUserImpl>
    implements _$$AppUserImplCopyWith<$Res> {
  __$$AppUserImplCopyWithImpl(
    _$AppUserImpl _value,
    $Res Function(_$AppUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? fechaRegistro = null,
    Object? altura = null,
    Object? pesoObjetivo = null,
    Object? genero = null,
    Object? fechaNacimiento = null,
    Object? nivelActividad = null,
    Object? objetivoSalud = freezed,
  }) {
    return _then(
      _$AppUserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        fechaRegistro: null == fechaRegistro
            ? _value.fechaRegistro
            : fechaRegistro // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        altura: null == altura
            ? _value.altura
            : altura // ignore: cast_nullable_to_non_nullable
                  as double,
        pesoObjetivo: null == pesoObjetivo
            ? _value.pesoObjetivo
            : pesoObjetivo // ignore: cast_nullable_to_non_nullable
                  as double,
        genero: null == genero
            ? _value.genero
            : genero // ignore: cast_nullable_to_non_nullable
                  as String,
        fechaNacimiento: null == fechaNacimiento
            ? _value.fechaNacimiento
            : fechaNacimiento // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        nivelActividad: null == nivelActividad
            ? _value.nivelActividad
            : nivelActividad // ignore: cast_nullable_to_non_nullable
                  as String,
        objetivoSalud: freezed == objetivoSalud
            ? _value.objetivoSalud
            : objetivoSalud // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppUserImpl implements _AppUser {
  const _$AppUserImpl({
    required this.id,
    required this.name,
    required this.email,
    required this.fechaRegistro,
    required this.altura,
    required this.pesoObjetivo,
    required this.genero,
    required this.fechaNacimiento,
    required this.nivelActividad,
    this.objetivoSalud,
  });

  factory _$AppUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppUserImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final DateTime fechaRegistro;
  // Datos inamovibles del perfil
  @override
  final double altura;
  // en cm
  @override
  final double pesoObjetivo;
  // en kg
  @override
  final String genero;
  // 'masculino' o 'femenino'
  @override
  final DateTime fechaNacimiento;
  @override
  final String nivelActividad;
  // 'sedentario', 'ligero', 'moderado', 'intenso', 'muy_intenso'
  @override
  final String? objetivoSalud;

  @override
  String toString() {
    return 'AppUser(id: $id, name: $name, email: $email, fechaRegistro: $fechaRegistro, altura: $altura, pesoObjetivo: $pesoObjetivo, genero: $genero, fechaNacimiento: $fechaNacimiento, nivelActividad: $nivelActividad, objetivoSalud: $objetivoSalud)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.fechaRegistro, fechaRegistro) ||
                other.fechaRegistro == fechaRegistro) &&
            (identical(other.altura, altura) || other.altura == altura) &&
            (identical(other.pesoObjetivo, pesoObjetivo) ||
                other.pesoObjetivo == pesoObjetivo) &&
            (identical(other.genero, genero) || other.genero == genero) &&
            (identical(other.fechaNacimiento, fechaNacimiento) ||
                other.fechaNacimiento == fechaNacimiento) &&
            (identical(other.nivelActividad, nivelActividad) ||
                other.nivelActividad == nivelActividad) &&
            (identical(other.objetivoSalud, objetivoSalud) ||
                other.objetivoSalud == objetivoSalud));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    email,
    fechaRegistro,
    altura,
    pesoObjetivo,
    genero,
    fechaNacimiento,
    nivelActividad,
    objetivoSalud,
  );

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      __$$AppUserImplCopyWithImpl<_$AppUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppUserImplToJson(this);
  }
}

abstract class _AppUser implements AppUser {
  const factory _AppUser({
    required final String id,
    required final String name,
    required final String email,
    required final DateTime fechaRegistro,
    required final double altura,
    required final double pesoObjetivo,
    required final String genero,
    required final DateTime fechaNacimiento,
    required final String nivelActividad,
    final String? objetivoSalud,
  }) = _$AppUserImpl;

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$AppUserImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get email;
  @override
  DateTime get fechaRegistro; // Datos inamovibles del perfil
  @override
  double get altura; // en cm
  @override
  double get pesoObjetivo; // en kg
  @override
  String get genero; // 'masculino' o 'femenino'
  @override
  DateTime get fechaNacimiento;
  @override
  String get nivelActividad; // 'sedentario', 'ligero', 'moderado', 'intenso', 'muy_intenso'
  @override
  String? get objetivoSalud;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
