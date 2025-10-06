// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'health_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HealthEntry _$HealthEntryFromJson(Map<String, dynamic> json) {
  return _HealthEntry.fromJson(json);
}

/// @nodoc
mixin _$HealthEntry {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get fecha => throw _privateConstructorUsedError;
  double get peso => throw _privateConstructorUsedError; // en kg
  double get grasaCorporal => throw _privateConstructorUsedError; // porcentaje
  double get masaMuscular => throw _privateConstructorUsedError; // en kg
  double get grasaVisceral => throw _privateConstructorUsedError; // nivel
  double get imc => throw _privateConstructorUsedError;

  /// Serializes this HealthEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthEntryCopyWith<HealthEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthEntryCopyWith<$Res> {
  factory $HealthEntryCopyWith(
    HealthEntry value,
    $Res Function(HealthEntry) then,
  ) = _$HealthEntryCopyWithImpl<$Res, HealthEntry>;
  @useResult
  $Res call({
    String id,
    String userId,
    DateTime fecha,
    double peso,
    double grasaCorporal,
    double masaMuscular,
    double grasaVisceral,
    double imc,
  });
}

/// @nodoc
class _$HealthEntryCopyWithImpl<$Res, $Val extends HealthEntry>
    implements $HealthEntryCopyWith<$Res> {
  _$HealthEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? fecha = null,
    Object? peso = null,
    Object? grasaCorporal = null,
    Object? masaMuscular = null,
    Object? grasaVisceral = null,
    Object? imc = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            fecha: null == fecha
                ? _value.fecha
                : fecha // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            peso: null == peso
                ? _value.peso
                : peso // ignore: cast_nullable_to_non_nullable
                      as double,
            grasaCorporal: null == grasaCorporal
                ? _value.grasaCorporal
                : grasaCorporal // ignore: cast_nullable_to_non_nullable
                      as double,
            masaMuscular: null == masaMuscular
                ? _value.masaMuscular
                : masaMuscular // ignore: cast_nullable_to_non_nullable
                      as double,
            grasaVisceral: null == grasaVisceral
                ? _value.grasaVisceral
                : grasaVisceral // ignore: cast_nullable_to_non_nullable
                      as double,
            imc: null == imc
                ? _value.imc
                : imc // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HealthEntryImplCopyWith<$Res>
    implements $HealthEntryCopyWith<$Res> {
  factory _$$HealthEntryImplCopyWith(
    _$HealthEntryImpl value,
    $Res Function(_$HealthEntryImpl) then,
  ) = __$$HealthEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    DateTime fecha,
    double peso,
    double grasaCorporal,
    double masaMuscular,
    double grasaVisceral,
    double imc,
  });
}

/// @nodoc
class __$$HealthEntryImplCopyWithImpl<$Res>
    extends _$HealthEntryCopyWithImpl<$Res, _$HealthEntryImpl>
    implements _$$HealthEntryImplCopyWith<$Res> {
  __$$HealthEntryImplCopyWithImpl(
    _$HealthEntryImpl _value,
    $Res Function(_$HealthEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HealthEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? fecha = null,
    Object? peso = null,
    Object? grasaCorporal = null,
    Object? masaMuscular = null,
    Object? grasaVisceral = null,
    Object? imc = null,
  }) {
    return _then(
      _$HealthEntryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        fecha: null == fecha
            ? _value.fecha
            : fecha // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        peso: null == peso
            ? _value.peso
            : peso // ignore: cast_nullable_to_non_nullable
                  as double,
        grasaCorporal: null == grasaCorporal
            ? _value.grasaCorporal
            : grasaCorporal // ignore: cast_nullable_to_non_nullable
                  as double,
        masaMuscular: null == masaMuscular
            ? _value.masaMuscular
            : masaMuscular // ignore: cast_nullable_to_non_nullable
                  as double,
        grasaVisceral: null == grasaVisceral
            ? _value.grasaVisceral
            : grasaVisceral // ignore: cast_nullable_to_non_nullable
                  as double,
        imc: null == imc
            ? _value.imc
            : imc // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthEntryImpl implements _HealthEntry {
  const _$HealthEntryImpl({
    required this.id,
    required this.userId,
    required this.fecha,
    required this.peso,
    required this.grasaCorporal,
    required this.masaMuscular,
    required this.grasaVisceral,
    required this.imc,
  });

  factory _$HealthEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final DateTime fecha;
  @override
  final double peso;
  // en kg
  @override
  final double grasaCorporal;
  // porcentaje
  @override
  final double masaMuscular;
  // en kg
  @override
  final double grasaVisceral;
  // nivel
  @override
  final double imc;

  @override
  String toString() {
    return 'HealthEntry(id: $id, userId: $userId, fecha: $fecha, peso: $peso, grasaCorporal: $grasaCorporal, masaMuscular: $masaMuscular, grasaVisceral: $grasaVisceral, imc: $imc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.fecha, fecha) || other.fecha == fecha) &&
            (identical(other.peso, peso) || other.peso == peso) &&
            (identical(other.grasaCorporal, grasaCorporal) ||
                other.grasaCorporal == grasaCorporal) &&
            (identical(other.masaMuscular, masaMuscular) ||
                other.masaMuscular == masaMuscular) &&
            (identical(other.grasaVisceral, grasaVisceral) ||
                other.grasaVisceral == grasaVisceral) &&
            (identical(other.imc, imc) || other.imc == imc));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    fecha,
    peso,
    grasaCorporal,
    masaMuscular,
    grasaVisceral,
    imc,
  );

  /// Create a copy of HealthEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthEntryImplCopyWith<_$HealthEntryImpl> get copyWith =>
      __$$HealthEntryImplCopyWithImpl<_$HealthEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthEntryImplToJson(this);
  }
}

abstract class _HealthEntry implements HealthEntry {
  const factory _HealthEntry({
    required final String id,
    required final String userId,
    required final DateTime fecha,
    required final double peso,
    required final double grasaCorporal,
    required final double masaMuscular,
    required final double grasaVisceral,
    required final double imc,
  }) = _$HealthEntryImpl;

  factory _HealthEntry.fromJson(Map<String, dynamic> json) =
      _$HealthEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  DateTime get fecha;
  @override
  double get peso; // en kg
  @override
  double get grasaCorporal; // porcentaje
  @override
  double get masaMuscular; // en kg
  @override
  double get grasaVisceral; // nivel
  @override
  double get imc;

  /// Create a copy of HealthEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthEntryImplCopyWith<_$HealthEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
