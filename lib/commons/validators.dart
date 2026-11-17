String? validateRequired(String? value, {int minLength = 2}) {
  final text = value?.trim() ?? '';
  if (text.isEmpty) {
    return 'Preencha este campo.';
  }
  if (text.length < minLength) {
    return 'Use pelo menos $minLength caracteres.';
  }
  return null;
}

String? validateEmail(String? value) {
  final text = value?.trim() ?? '';
  if (text.isEmpty) {
    return 'Informe o e-mail.';
  }
  final email = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  if (!email.hasMatch(text)) {
    return 'Informe um e-mail válido.';
  }
  return null;
}
