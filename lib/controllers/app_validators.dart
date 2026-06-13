import 'package:flutter/services.dart';

class AppValidators {
  static final RegExp _lettersRegex = RegExp(r"^[A-Za-zÁÉÍÓÚáéíóúÑñÜü\s]+$");
  static final RegExp _addressRegex = RegExp(
    r"^[A-Za-zÁÉÍÓÚáéíóúÑñÜü0-9\s,.\-#]+$",
  );
  static final RegExp _emailRegex = RegExp(
    r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
  );
  static final RegExp _decimalRegex = RegExp(r'^\d+(\.\d+)?$');
  static final RegExp _integerRegex = RegExp(r'^\d+$');
  static final RegExp _dangerousRegex = RegExp(
    r'[<>{}\[\]`~^|\\]|script|javascript:',
    caseSensitive: false,
  );

  static final List<TextInputFormatter> lettersOnly = [
    FilteringTextInputFormatter.allow(RegExp(r"[A-Za-zÁÉÍÓÚáéíóúÑñÜü\s]")),
  ];

  static final List<TextInputFormatter> integerOnly = [
    FilteringTextInputFormatter.digitsOnly,
  ];

  static final List<TextInputFormatter> decimalOnly = [
    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
    _SingleDecimalPointFormatter(),
  ];

  static final List<TextInputFormatter> signedDecimalOnly = [
    FilteringTextInputFormatter.allow(RegExp(r'[0-9.-]')),
    _SignedDecimalFormatter(),
  ];

  static final List<TextInputFormatter> phoneOnly = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(10),
  ];

  static final List<TextInputFormatter> ciOnly = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(12),
  ];

  static final List<TextInputFormatter> address = [
    FilteringTextInputFormatter.allow(
      RegExp(r"[A-Za-zÁÉÍÓÚáéíóúÑñÜü0-9\s,.\-#]"),
    ),
  ];

  static final List<TextInputFormatter> safeText = [
    FilteringTextInputFormatter.deny(RegExp(r'[<>{}\[\]`~^|\\]')),
  ];

  static String sanitizeText(String value) {
    return value
        .replaceAll(_dangerousRegex, '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  static String sanitizeNumeric(String value) {
    return value.replaceAll(RegExp(r'[^0-9.]'), '').trim();
  }

  static String sanitizeInteger(String value) {
    return value.replaceAll(RegExp(r'[^0-9]'), '').trim();
  }

  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) return 'Campo requerido';
    if (_dangerousRegex.hasMatch(value)) return 'Caracteres no permitidos.';
    return null;
  }

  static String? letters(String? value, {bool required = true}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return required ? 'Campo requerido' : null;
    if (!_lettersRegex.hasMatch(text)) return 'Este campo solo admite letras.';
    return null;
  }

  static String? safeTextValidator(String? value, {bool required = false}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return required ? 'Campo requerido' : null;
    if (_dangerousRegex.hasMatch(text)) return 'Caracteres no permitidos.';
    return null;
  }

  static String? addressValidator(String? value, {bool required = false}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return required ? 'Campo requerido' : null;
    if (!_addressRegex.hasMatch(text)) return 'Direccion invalida.';
    if (_dangerousRegex.hasMatch(text)) return 'Caracteres no permitidos.';
    return null;
  }

  static String? decimal(
    String? value, {
    bool required = true,
    bool positive = true,
  }) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return required ? 'Campo requerido' : null;
    if (!_decimalRegex.hasMatch(text)) {
      return 'Este campo solo admite valores numericos.';
    }
    final number = double.tryParse(text);
    if (number == null) return 'Este campo solo admite valores numericos.';
    if (positive && number <= 0) return 'Ingrese un valor mayor a cero.';
    return null;
  }

  static String? signedDecimal(String? value, {bool required = false}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return required ? 'Campo requerido' : null;
    if (double.tryParse(text) == null) {
      return 'Este campo solo admite valores numericos.';
    }
    return null;
  }

  static String? integer(String? value, {bool required = true, int min = 1}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return required ? 'Campo requerido' : null;
    if (!_integerRegex.hasMatch(text)) {
      return 'Este campo solo admite valores numericos.';
    }
    final number = int.tryParse(text);
    if (number == null || number < min) return 'Ingrese un valor valido.';
    return null;
  }

  static String? phone(String? value, {bool required = false}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return required ? 'Campo requerido' : null;
    if (!_integerRegex.hasMatch(text) || text.length < 7 || text.length > 10) {
      return 'Numero de telefono invalido.';
    }
    return null;
  }

  static String? ci(String? value, {int minLength = 5, int maxLength = 12}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Campo requerido';
    if (!_integerRegex.hasMatch(text) ||
        text.length < minLength ||
        text.length > maxLength) {
      return 'CI invalido.';
    }
    return null;
  }

  static String? email(String? value, {bool required = false}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return required ? 'Campo requerido' : null;
    if (text.contains(' ') || !_emailRegex.hasMatch(text)) {
      return 'Correo invalido.';
    }
    return null;
  }
}

class _SingleDecimalPointFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if ('.'.allMatches(text).length > 1) return oldValue;
    return newValue;
  }
}

class _SignedDecimalFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if ('-'.allMatches(text).length > 1) return oldValue;
    if (text.contains('-') && !text.startsWith('-')) return oldValue;
    if ('.'.allMatches(text).length > 1) return oldValue;
    return newValue;
  }
}
