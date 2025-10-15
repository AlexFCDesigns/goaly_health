import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import 'home_page.dart';
import '../../utils/validators.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();

  // Controladores para datos básicos
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Controladores para datos del perfil
  final _alturaController = TextEditingController();
  final _pesoObjetivoController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  int _currentStep = 0;

  // Variables para datos del perfil
  String _generoSeleccionado = 'masculino';
  String _nivelActividadSeleccionado = 'moderado';
  String? _objetivoSaludSeleccionado;
  DateTime _fechaNacimiento = DateTime.now().subtract(
    const Duration(days: 365 * 25),
  ); // 25 años por defecto

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _alturaController.dispose();
    _pesoObjetivoController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_formKey.currentState!.validate()) {
      if (_currentStep < 2) {
        setState(() {
          _currentStep++;
        });
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        _handleRegister();
      }
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
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

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      // Crear el usuario con todos los datos del perfil
      final userData = {
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'altura': double.parse(_alturaController.text),
        'pesoObjetivo': double.parse(_pesoObjetivoController.text),
        'genero': _generoSeleccionado,
        'nivelActividad': _nivelActividadSeleccionado,
        'objetivoSalud': _objetivoSaludSeleccionado,
        'fechaNacimiento': _fechaNacimiento,
      };

      ref
          .read(authProvider.notifier)
          .signUp(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            name: _nameController.text.trim(),
            userData: userData,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    // Escuchar cambios en el estado de autenticación
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!), backgroundColor: Colors.red),
        );
      }

      if (next.isAuthenticated) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro - Paso ${_currentStep + 1} de 3'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: _currentStep > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _previousStep,
              )
            : null,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Indicador de progreso
            LinearProgressIndicator(
              value: (_currentStep + 1) / 3,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 24),

            // Contenido de las páginas
            Expanded(
              child: Form(
                key: _formKey,
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildBasicInfoStep(),
                    _buildPhysicalDataStep(),
                    _buildLifestyleStep(),
                  ],
                ),
              ),
            ),

            // Botones de navegación
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: CustomButton(
                        text: 'Anterior',
                        onPressed: _previousStep,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ),
                  if (_currentStep > 0) const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      text: _currentStep == 2 ? 'Crear Cuenta' : 'Siguiente',
                      onPressed: authState.isLoading ? null : _nextStep,
                      isLoading: authState.isLoading,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.person_add_outlined, size: 80, color: Colors.blue),
            const SizedBox(height: 32),
            const Text(
              'Información Básica',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Crea tu cuenta para comenzar',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),

            CustomTextField(
              controller: _nameController,
              label: 'Nombre completo',
              validator: Validators.validateName,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              controller: _emailController,
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
              validator: Validators.validateEmail,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              controller: _passwordController,
              label: 'Contraseña',
              obscureText: _obscurePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              validator: Validators.validatePassword,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              controller: _confirmPasswordController,
              label: 'Confirmar contraseña',
              obscureText: _obscureConfirmPassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
              validator: (value) => Validators.validateConfirmPassword(
                value,
                _passwordController.text,
              ),
            ),
            const SizedBox(height: 24),

            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                '¿Ya tienes cuenta? Inicia sesión',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhysicalDataStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.fitness_center, size: 80, color: Colors.blue),
            const SizedBox(height: 32),
            const Text(
              'Datos Físicos',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Información básica sobre tu cuerpo',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),

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
          ],
        ),
      ),
    );
  }

  Widget _buildLifestyleStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.sports, size: 80, color: Colors.blue),
            const SizedBox(height: 32),
            const Text(
              'Estilo de Vida',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Ayúdanos a personalizar tu experiencia',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),

            _buildDropdownField(
              'Nivel de actividad',
              _nivelActividadSeleccionado,
              ['sedentario', 'ligero', 'moderado', 'intenso', 'muy_intenso'],
              (value) => setState(() => _nivelActividadSeleccionado = value!),
            ),
            const SizedBox(height: 16),

            _buildDropdownField(
              'Objetivo de salud',
              _objetivoSaludSeleccionado,
              ['perder_peso', 'ganar_peso', 'mantener', 'ganar_musculo'],
              (value) => setState(() => _objetivoSaludSeleccionado = value),
              isRequired: false,
            ),
            const SizedBox(height: 24),

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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Estos datos nos ayudarán a calcular métricas personalizadas y sugerir objetivos realistas para tu salud.',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
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
