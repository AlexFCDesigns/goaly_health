class Validators {
  // Validar email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El email es requerido';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Ingresa un email válido';
    }

    return null;
  }

  // Validar contraseña
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }

    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }

    return null;
  }

  // Validar confirmación de contraseña
  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Confirma tu contraseña';
    }

    if (value != password) {
      return 'Las contraseñas no coinciden';
    }

    return null;
  }

  // Validar nombre
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'El nombre es requerido';
    }

    if (value.length < 2) {
      return 'El nombre debe tener al menos 2 caracteres';
    }

    return null;
  }

  // Validar peso
  static String? validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'El peso es requerido';
    }

    final weight = double.tryParse(value);
    if (weight == null) {
      return 'Ingresa un peso válido';
    }

    if (weight < 20 || weight > 300) {
      return 'El peso debe estar entre 20 y 300 kg';
    }

    return null;
  }

  // Validar porcentaje de grasa corporal
  static String? validateBodyFat(String? value) {
    if (value == null || value.isEmpty) {
      return 'El porcentaje de grasa corporal es requerido';
    }

    final bodyFat = double.tryParse(value);
    if (bodyFat == null) {
      return 'Ingresa un porcentaje válido';
    }

    if (bodyFat < 0 || bodyFat > 50) {
      return 'El porcentaje debe estar entre 0 y 50%';
    }

    return null;
  }

  // Validar masa muscular
  static String? validateMuscleMass(String? value) {
    if (value == null || value.isEmpty) {
      return 'La masa muscular es requerida';
    }

    final muscleMass = double.tryParse(value);
    if (muscleMass == null) {
      return 'Ingresa una masa muscular válida';
    }

    if (muscleMass < 0 || muscleMass > 200) {
      return 'La masa muscular debe estar entre 0 y 200 kg';
    }

    return null;
  }

  // Validar grasa visceral
  static String? validateVisceralFat(String? value) {
    if (value == null || value.isEmpty) {
      return 'El nivel de grasa visceral es requerido';
    }

    final visceralFat = double.tryParse(value);
    if (visceralFat == null) {
      return 'Ingresa un nivel válido';
    }

    if (visceralFat < 0 || visceralFat > 30) {
      return 'El nivel debe estar entre 0 y 30';
    }

    return null;
  }

  // Validar altura (para calcular IMC)
  static String? validateHeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'La altura es requerida';
    }

    final height = double.tryParse(value);
    if (height == null) {
      return 'Ingresa una altura válida';
    }

    if (height < 100 || height > 250) {
      return 'La altura debe estar entre 100 y 250 cm';
    }

    return null;
  }
}
