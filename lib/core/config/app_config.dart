class AppConfig {
  AppConfig._();

  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  static const Map<String, String> defaultHeaders = {
    'User-Agent': 'Mozilla/5.0',
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  static Uri uri(String path) {
    return Uri.parse('$baseUrl$path');
  }
}
