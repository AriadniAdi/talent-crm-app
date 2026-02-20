import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:talent_crm_app/data/services/talent/talent_service.dart';
import 'package:talent_crm_app/domain/repositories/talent_repository.dart';
import 'package:talent_crm_app/domain/usecases/talent/get_talent_usecase.dart';
import 'package:talent_crm_app/presentation/home/controller/home_controller.dart';
import 'package:talent_crm_app/presentation/home/home_binding.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    Get.reset();
  });

  tearDown(() {
    Get.reset();
  });

  test('HomeBinding should register dependencies', () {
    HomeBinding().dependencies();

    final client = Get.find<http.Client>();
    final service = Get.find<TalentService>();
    final controller = Get.find<HomeController>();
    final talentRepository = Get.find<TalentRepository>();
    final getTalentUseCase = Get.find<GetTalentsUseCase>();

    expect(client, isA<http.Client>());
    expect(service, isA<TalentService>());
    expect(controller, isA<HomeController>());
    expect(talentRepository, isA<TalentRepository>());
    expect(getTalentUseCase, isA<GetTalentsUseCase>());
  });
}
