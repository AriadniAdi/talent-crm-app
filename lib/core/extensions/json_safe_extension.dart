extension JsonSafe on Map<String, dynamic> {
  String getString(String key) {
    final value = this[key];
    return value is String ? value : '';
  }

  int getInt(String key) {
    final value = this[key];
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  double getDouble(String key) {
    final value = this[key];
    if (value is double) return value;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  bool getBool(String key) {
    final value = this[key];
    if (value is bool) return value;
    if (value is String) return value.toLowerCase() == 'true';
    return false;
  }

  Map<String, dynamic>? getMap(String key) {
    final value = this[key];
    return value is Map<String, dynamic> ? value : null;
  }

  List<dynamic> getList(String key) {
    final value = this[key];
    return value is List ? value : [];
  }
}
