// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HealthEntryImpl _$$HealthEntryImplFromJson(Map<String, dynamic> json) =>
    _$HealthEntryImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      fecha: DateTime.parse(json['fecha'] as String),
      peso: (json['peso'] as num).toDouble(),
      grasaCorporal: (json['grasaCorporal'] as num).toDouble(),
      masaMuscular: (json['masaMuscular'] as num).toDouble(),
      grasaVisceral: (json['grasaVisceral'] as num).toDouble(),
      imc: (json['imc'] as num).toDouble(),
    );

Map<String, dynamic> _$$HealthEntryImplToJson(_$HealthEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'fecha': instance.fecha.toIso8601String(),
      'peso': instance.peso,
      'grasaCorporal': instance.grasaCorporal,
      'masaMuscular': instance.masaMuscular,
      'grasaVisceral': instance.grasaVisceral,
      'imc': instance.imc,
    };
