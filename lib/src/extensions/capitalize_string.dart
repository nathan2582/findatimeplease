extension CapitalizeString on String {
  String get cap =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}
