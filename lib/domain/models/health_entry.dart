import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_entry.freezed.dart';
part 'health_entry.g.dart';

@freezed
class HealthEntry with _$HealthEntry {
  const factory HealthEntry({
    required String id,
    required String userId,
    required DateTime fecha,
    required double peso, // en kg
    required double grasaCorporal, // porcentaje
    required double masaMuscular, // en kg
    required double grasaVisceral, // nivel
    required double imc, // índice de masa corporal
  }) = _HealthEntry;

  factory HealthEntry.fromJson(Map<String, dynamic> json) =>
      _$HealthEntryFromJson(json);

  factory HealthEntry.fromMap(Map<String, dynamic> map) => HealthEntry(
    id: map['id'] as String,
    userId: map['userId'] as String,
    fecha: DateTime.parse(map['fecha'] as String),
    peso: (map['peso'] as num).toDouble(),
    grasaCorporal: (map['grasaCorporal'] as num).toDouble(),
    masaMuscular: (map['masaMuscular'] as num).toDouble(),
    grasaVisceral: (map['grasaVisceral'] as num).toDouble(),
    imc: (map['imc'] as num).toDouble(),
  );

  // Método para calcular IMC automáticamente
  static double calculateIMC(double peso, double altura) {
    return peso / (altura * altura);
  }
}
