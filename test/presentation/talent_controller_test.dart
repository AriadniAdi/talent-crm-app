import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/data/services/talent_service.dart';
import 'package:talent_crm_app/domain/entities/contact_talent.dart';
import 'package:talent_crm_app/domain/entities/talent.dart';
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

  const fakeTalent = Talent(
    id: 1,
    name: 'John',
    description: 'Hello',
    city: 'POA',
    company: 'Company',
    website: 'site.com',
    contact: ContactTalent(
      email: 'john@email.com',
      phone: '9999',
    ),
  );

  test('should load talents successfully', () async {
    when(() => mockService.fetchTalents())
        .thenAnswer((_) async => [fakeTalent]);

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
