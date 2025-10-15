// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      fechaRegistro: DateTime.parse(json['fechaRegistro'] as String),
      altura: (json['altura'] as num).toDouble(),
      pesoObjetivo: (json['pesoObjetivo'] as num).toDouble(),
      genero: json['genero'] as String,
      fechaNacimiento: DateTime.parse(json['fechaNacimiento'] as String),
      nivelActividad: json['nivelActividad'] as String,
      objetivoSalud: json['objetivoSalud'] as String?,
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'fechaRegistro': instance.fechaRegistro.toIso8601String(),
      'altura': instance.altura,
      'pesoObjetivo': instance.pesoObjetivo,
      'genero': instance.genero,
      'fechaNacimiento': instance.fechaNacimiento.toIso8601String(),
      'nivelActividad': instance.nivelActividad,
      'objetivoSalud': instance.objetivoSalud,
    };
