import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/global_binding.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';
import 'package:talent_crm_app/features/talent/services/talent_service.dart';
import 'package:talent_crm_app/features/talent/repositories/talent_repository.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talent_usecase.dart';
import 'package:talent_crm_app/features/home/home_binding.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    Get.reset();

    GlobalBinding().dependencies();
  });

  tearDown(() {
    Get.reset();
  });

  test('HomeBinding should register dependencies', () {
    HomeBinding().dependencies();

    final service = Get.find<TalentService>();
    final controller = Get.find<HomeController>();
    final talentRepository = Get.find<TalentRepository>();
    final getTalentUseCase = Get.find<GetTalentsUseCase>();

    expect(service, isA<TalentService>());
    expect(controller, isA<HomeController>());
    expect(talentRepository, isA<TalentRepository>());
    expect(getTalentUseCase, isA<GetTalentsUseCase>());
  });
}
