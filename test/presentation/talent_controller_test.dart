import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/data/models/talent_model.dart';
import 'package:talent_crm_app/data/services/talent_service.dart';
import 'package:talent_crm_app/presentation/talent_controller.dart';

class MockTalentService extends Mock implements TalentService {}

void main() {
  late TalentController controller;
  late MockTalentService mockService;

  setUp(() {
    Get.testMode = true;
    mockService = MockTalentService();
    controller = TalentController(mockService);
  });

  final fakeModel = TalentModel(
    id: 1,
    name: 'John',
    email: 'john@email.com',
    website: 'site.com',
    city: 'POA',
    catchPhrase: 'Hello',
    companyName: 'Company',
    phone: '9999',
  );

  test('should load talents successfully', () async {
    when(() => mockService.fetchTalents()).thenAnswer((_) async => [fakeModel]);

    await controller.fetchTalents();

    expect(controller.isLoading.value, false);
    expect(controller.error.value, null);
    expect(controller.talents.length, 1);
    expect(controller.talents.first.name, 'John');
  });

  test('should set error when service throws', () async {
    when(() => mockService.fetchTalents()).thenThrow(Exception('error'));

    await controller.fetchTalents();

    expect(controller.isLoading.value, false);
    expect(controller.error.value, isNotNull);
    expect(controller.talents.isEmpty, true);
  });
}
