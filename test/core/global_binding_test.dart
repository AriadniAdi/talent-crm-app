import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:talent_crm_app/core/global_binding.dart';

void main() {
  setUp(() {
    Get.reset();
  });

  group('GlobalBinding', () {
    test('registers http.Client in Get', () {
      final binding = GlobalBinding();

      binding.dependencies();

      expect(Get.isRegistered<http.Client>(), true);
    });

    test('registered http.Client can be retrieved', () {
      final binding = GlobalBinding();

      binding.dependencies();

      final client = Get.find<http.Client>();

      expect(client, isA<http.Client>());
    });

    test('http.Client is permanent', () {
      final binding = GlobalBinding();

      binding.dependencies();

      expect(Get.isRegistered<http.Client>(), true);

      Get.delete<http.Client>();

      // permanent: true impede deleção
      expect(Get.isRegistered<http.Client>(), true);
    });
  });
}
