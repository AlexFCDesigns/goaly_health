import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../../utils/validators.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _alturaController = TextEditingController();
  final _pesoObjetivoController = TextEditingController();

  String _generoSeleccionado = 'masculino';
  String _nivelActividadSeleccionado = 'moderado';
  String? _objetivoSaludSeleccionado;
  DateTime _fechaNacimiento = DateTime.now().subtract(
    const Duration(days: 365 * 25),
  ); // 25 años por defecto

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final authState = ref.read(authProvider);
    final user = authState.appUser;

    if (user != null) {
      _nameController.text = user.name;
      _alturaController.text = user.altura.toString();
      _pesoObjetivoController.text = user.pesoObjetivo.toString();
      _generoSeleccionado = user.genero;
      _nivelActividadSeleccionado = user.nivelActividad;
      _objetivoSaludSeleccionado = user.objetivoSalud;
      _fechaNacimiento = user.fechaNacimiento;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _alturaController.dispose();
    _pesoObjetivoController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaNacimiento,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _fechaNacimiento) {
      setState(() {
        _fechaNacimiento = picked;
      });
    }
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      final authState = ref.read(authProvider);
      final currentUser = authState.appUser;

      if (currentUser != null) {
        // Aquí actualizarías el usuario en el backend
        // final updatedUser = currentUser.copyWith(
        //   name: _nameController.text,
        //   altura: double.parse(_alturaController.text),
        //   pesoObjetivo: double.parse(_pesoObjetivoController.text),
        //   genero: _generoSeleccionado,
        //   nivelActividad: _nivelActividadSeleccionado,
        //   objetivoSalud: _objetivoSaludSeleccionado,
        //   fechaNacimiento: _fechaNacimiento,
        // );
        // ref.read(authProvider.notifier).updateUser(updatedUser);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Perfil actualizado exitosamente'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final user = authState.appUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mi Perfil',
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
                // Header con avatar
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.blue.shade400,
                              Colors.blue.shade600,
                            ],
                          ),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user?.name ?? 'Usuario',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        user?.email ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Información básica
                _buildSectionTitle('Información Básica'),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _nameController,
                  label: 'Nombre completo',
                  validator: Validators.validateName,
                ),
                const SizedBox(height: 16),

                // Fecha de nacimiento
                InkWell(
                  onTap: _selectDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.grey),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Fecha de nacimiento: ${_formatDate(_fechaNacimiento)}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Género
                _buildDropdownField(
                  'Género',
                  _generoSeleccionado,
                  ['masculino', 'femenino'],
                  (value) => setState(() => _generoSeleccionado = value!),
                ),
                const SizedBox(height: 24),

                // Datos físicos
                _buildSectionTitle('Datos Físicos'),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _alturaController,
                  label: 'Altura (cm)',
                  keyboardType: TextInputType.number,
                  validator: Validators.validateHeight,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _pesoObjetivoController,
                  label: 'Peso objetivo (kg)',
                  keyboardType: TextInputType.number,
                  validator: Validators.validateWeight,
                ),
                const SizedBox(height: 24),

                // Estilo de vida
                _buildSectionTitle('Estilo de Vida'),
                const SizedBox(height: 16),

                _buildDropdownField(
                  'Nivel de actividad',
                  _nivelActividadSeleccionado,
                  [
                    'sedentario',
                    'ligero',
                    'moderado',
                    'intenso',
                    'muy_intenso',
                  ],
                  (value) =>
                      setState(() => _nivelActividadSeleccionado = value!),
                ),
                const SizedBox(height: 16),

                _buildDropdownField(
                  'Objetivo de salud',
                  _objetivoSaludSeleccionado,
                  ['perder_peso', 'ganar_peso', 'mantener', 'ganar_musculo'],
                  (value) => setState(() => _objetivoSaludSeleccionado = value),
                  isRequired: false,
                ),
                const SizedBox(height: 32),

                // Botón de guardar
                CustomButton(text: 'Guardar Cambios', onPressed: _handleSave),
                const SizedBox(height: 16),

                // Información adicional
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
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
                        'Estos datos se utilizarán para calcular métricas como el IMC y para personalizar tus registros de salud.',
                        style: TextStyle(fontSize: 14),
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    String? value,
    List<String> items,
    ValueChanged<String?> onChanged, {
    bool isRequired = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(_formatDropdownItem(item)),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDropdownItem(String item) {
    switch (item) {
      case 'masculino':
        return 'Masculino';
      case 'femenino':
        return 'Femenino';
      case 'sedentario':
        return 'Sedentario';
      case 'ligero':
        return 'Ligero';
      case 'moderado':
        return 'Moderado';
      case 'intenso':
        return 'Intenso';
      case 'muy_intenso':
        return 'Muy Intenso';
      case 'perder_peso':
        return 'Perder Peso';
      case 'ganar_peso':
        return 'Ganar Peso';
      case 'mantener':
        return 'Mantener';
      case 'ganar_musculo':
        return 'Ganar Músculo';
      default:
        return item;
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre',
    ];
    return '${date.day} de ${months[date.month - 1]} de ${date.year}';
  }
}
