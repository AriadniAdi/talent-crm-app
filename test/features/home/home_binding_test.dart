import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:talent_crm_app/features/home/home_binding.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talents_usecase.dart';

import '../helpers/wrapper.dart';

void main() {
  setUp(() {
    Get.reset();
    setupTestDependencies();
  });

  group('HomeBinding', () {
    test('registers GetTalentsUseCase and HomeController', () {
      final binding = HomeBinding();
      binding.dependencies();

      expect(Get.isRegistered<GetTalentsUseCase>(), true);
      expect(Get.isRegistered<HomeController>(), true);
    });

    test('HomeController resolves dependency chain correctly', () {
      final binding = HomeBinding();
      binding.dependencies();

      final controller = Get.find<HomeController>();

      expect(controller, isA<HomeController>());
    });
  });
}
