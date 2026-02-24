import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:talent_crm_app/features/home/home_binding.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';
import 'package:talent_crm_app/features/talent/services/talent_service.dart';
import 'package:talent_crm_app/features/talent/repositories/talent_repository.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talent_usecase.dart';

void main() {
  setUp(() {
    Get.reset();
  });

  group('HomeBinding', () {
    test('registers all dependencies correctly', () {
      // Simula dependência global necessária
      Get.put<http.Client>(http.Client());

      final binding = HomeBinding();
      binding.dependencies();

      // Verifica registros
      expect(Get.isRegistered<TalentService>(), true);
      expect(Get.isRegistered<TalentRepository>(), true);
      expect(Get.isRegistered<GetTalentsUseCase>(), true);
      expect(Get.isRegistered<HomeController>(), true);
    });

    test('HomeController resolves dependency chain', () {
      Get.put<http.Client>(http.Client());

      final binding = HomeBinding();
      binding.dependencies();

      final controller = Get.find<HomeController>();

      expect(controller, isA<HomeController>());
    });
  });
}
