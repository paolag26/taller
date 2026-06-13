class AppFormatters {
  const AppFormatters._();

  static String money(dynamic value) {
    final number = value is num
        ? value.toDouble()
        : double.tryParse(value?.toString() ?? '') ?? 0;
    final sign = number < 0 ? '-' : '';
    final fixed = number.abs().toStringAsFixed(2);
    final parts = fixed.split('.');
    final buffer = StringBuffer();

    for (var i = 0; i < parts.first.length; i++) {
      final indexFromEnd = parts.first.length - i;
      buffer.write(parts.first[i]);
      if (indexFromEnd > 1 && indexFromEnd % 3 == 1) {
        buffer.write(',');
      }
    }

    return 'Bs $sign${buffer.toString()}.${parts.last}';
  }

  static String friendlyError(Object error) {
    final text = error.toString();
    if (text.contains('PostgrestException')) {
      return 'No se pudo completar la operacion. Revise permisos o datos requeridos.';
    }
    if (text.contains('Assertion failed')) {
      return 'La pantalla no pudo completar la accion solicitada.';
    }
    if (text.contains('Stacktrace') || text.contains('STACKTRACE')) {
      return 'Ocurrio un error inesperado.';
    }
    return text
        .replaceAll('Exception: ', '')
        .replaceAll('PostgrestException(message: ', '')
        .trim();
  }
}
