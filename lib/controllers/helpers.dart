class Helpers {
  static String currency(double amount) {
    return 'Bs. ${amount.toStringAsFixed(2)}';
  }

  static String date(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obligatorio';
    }

    return null;
  }
}
