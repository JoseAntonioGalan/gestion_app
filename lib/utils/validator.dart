class Validator {
  static String? name(String? name) {
    if (name == null || name.isEmpty) {
      return 'Nombre no puede estar vacío';
    }

    return null;
  }

  static String? email(String? email) {
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email == null || email.isEmpty) {
      return 'Email no puede estar vacío';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Introduce un email correcto';
    }

    return null;
  }

  static String? password(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password no puede estar vacío';
    } else if (password.length < 8) {
      return 'La contraseña debe de tener minimo 8 caracteres';
    }

    return null;
  }
}
