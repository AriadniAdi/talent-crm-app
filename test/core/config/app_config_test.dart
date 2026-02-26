import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/core/config/app_config.dart';

void main() {
  group('AppConfig', () {
    test('baseUrl deve ser correto', () {
      expect(
        AppConfig.baseUrl,
        'https://jsonplaceholder.typicode.com',
      );
    });

    test('defaultHeaders deve conter headers padrão', () {
      expect(AppConfig.defaultHeaders['User-Agent'], 'Mozilla/5.0');
      expect(AppConfig.defaultHeaders['Accept'], 'application/json');
      expect(AppConfig.defaultHeaders['Content-Type'], 'application/json');
    });

    test('uri deve montar URL corretamente', () {
      final uri = AppConfig.uri('/users');

      expect(
        uri.toString(),
        'https://jsonplaceholder.typicode.com/users',
      );
    });

    test('uri deve funcionar com múltiplos paths', () {
      final usersUri = AppConfig.uri('/users');
      final postsUri = AppConfig.uri('/posts/1');

      expect(usersUri.toString(), 'https://jsonplaceholder.typicode.com/users');

      expect(
          postsUri.toString(), 'https://jsonplaceholder.typicode.com/posts/1');
    });

    test('uri deve retornar um objeto Uri válido', () {
      final uri = AppConfig.uri('/users');

      expect(uri, isA<Uri>());
      expect(uri.scheme, 'https');
      expect(uri.host, 'jsonplaceholder.typicode.com');
    });
  });
}
