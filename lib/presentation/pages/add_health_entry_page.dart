import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../providers/health_entry_provider.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../../domain/models/health_entry.dart';
import '../../utils/validators.dart';

class AddHealthEntryPage extends ConsumerStatefulWidget {
  const AddHealthEntryPage({super.key});

  @override
  ConsumerState<AddHealthEntryPage> createState() => _AddHealthEntryPageState();
}

class _AddHealthEntryPageState extends ConsumerState<AddHealthEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final _pesoController = TextEditingController();
  final _grasaCorporalController = TextEditingController();
  final _masaMuscularController = TextEditingController();
  final _grasaVisceralController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final authState = ref.read(authProvider);
    final user = authState.appUser;

    if (user != null) {
      // Pre-llenar con datos del perfil si están disponibles
      // Por ejemplo, podríamos mostrar el peso objetivo como referencia
    }
  }

  @override
  void dispose() {
    _pesoController.dispose();
    _grasaCorporalController.dispose();
    _masaMuscularController.dispose();
    _grasaVisceralController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final authState = ref.read(authProvider);
      final user = authState.appUser;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error: Usuario no encontrado'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final peso = double.parse(_pesoController.text);
      final altura = user.altura / 100; // Convertir cm a m desde el perfil
      final imc = HealthEntry.calculateIMC(peso, altura);

      final entry = HealthEntry(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: authState.firebaseUser!.uid,
        fecha: DateTime.now(),
        peso: peso,
        grasaCorporal: double.parse(_grasaCorporalController.text),
        masaMuscular: double.parse(_masaMuscularController.text),
        grasaVisceral: double.parse(_grasaVisceralController.text),
        imc: imc,
      );

      ref
          .read(healthEntryProvider(authState.firebaseUser!.uid).notifier)
          .createHealthEntry(entry);

      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registro agregado exitosamente'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final healthEntryState = ref.watch(
      healthEntryProvider(authState.firebaseUser?.uid ?? ''),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agregar Registro',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Título
                const Icon(Icons.fitness_center, size: 80, color: Colors.blue),
                const SizedBox(height: 24),
                const Text(
                  'Nuevo Registro de Progreso',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Registra tus métricas de salud actuales',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Información del perfil
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '📋 Información de tu perfil',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Altura: ${authState.appUser?.altura.toStringAsFixed(0)} cm',
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        'Peso objetivo: ${authState.appUser?.pesoObjetivo.toStringAsFixed(1)} kg',
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        'IMC se calculará automáticamente',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Campo de peso
                CustomTextField(
                  controller: _pesoController,
                  label: 'Peso actual (kg)',
                  keyboardType: TextInputType.number,
                  validator: Validators.validateWeight,
                ),
                const SizedBox(height: 16),

                // Campo de grasa corporal
                CustomTextField(
                  controller: _grasaCorporalController,
                  label: 'Grasa Corporal (%)',
                  keyboardType: TextInputType.number,
                  validator: Validators.validateBodyFat,
                ),
                const SizedBox(height: 16),

                // Campo de masa muscular
                CustomTextField(
                  controller: _masaMuscularController,
                  label: 'Masa Muscular (kg)',
                  keyboardType: TextInputType.number,
                  validator: Validators.validateMuscleMass,
                ),
                const SizedBox(height: 16),

                // Campo de grasa visceral
                CustomTextField(
                  controller: _grasaVisceralController,
                  label: 'Grasa Visceral (nivel)',
                  keyboardType: TextInputType.number,
                  validator: Validators.validateVisceralFat,
                ),
                const SizedBox(height: 32),

                // Botón de guardar
                CustomButton(
                  text: 'Guardar Registro',
                  onPressed: healthEntryState.isLoading ? null : _handleSubmit,
                  isLoading: healthEntryState.isLoading,
                ),
                const SizedBox(height: 16),

                // Información sobre IMC
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '💡 Información',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'El IMC se calculará automáticamente usando tu peso actual y la altura de tu perfil.',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Si necesitas cambiar tu altura, ve a tu perfil de usuario.',
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
