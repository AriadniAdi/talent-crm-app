import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';

import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/usecases/get_recent_talent_usecase.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talents_usecase.dart';
import 'package:talent_crm_app/features/talent/usecases/search_talents_usecase.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/home_content/home_content_view.dart';

import '../../../helpers/wrapper.dart';

class MockGetTalentsUseCase extends Mock implements GetTalentsUseCase {}

void main() {
  late MockGetTalentsUseCase mockUseCase;
  late HomeController controller;

  final talents = [
    const Talent(
      id: 1,
      name: 'John Doe',
      description: 'Dev',
      city: 'POA',
      company: 'Tech',
      website: 'site.com',
      contact: ContactTalent(email: 'john@mail.com', phone: '9999'),
    ),
    const Talent(
      id: 2,
      name: 'Adi Machado',
      description: 'Flutter',
      city: 'POA',
      company: 'Mobile',
      website: 'adi.dev',
      contact: ContactTalent(email: 'adi@mail.com', phone: '8888'),
    ),
  ];

  setUp(() {
    mockUseCase = MockGetTalentsUseCase();

    when(() => mockUseCase()).thenAnswer((_) async => Success([]));

    controller = HomeController(
      mockUseCase,
      getRecentTalentsUseCase: const GetRecentTalentsUseCase(),
      searchTalentsUseCase: const SearchTalentsUseCase(),
    );

    Get.put<HomeController>(controller);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('shows loading when isLoading is true', (tester) async {
    when(() => mockUseCase()).thenAnswer((_) async => Success([]));

    controller.isLoading.value = true;

    await tester.pumpWidget(wrapper(const HomeContentView()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Nenhum funcionário encontrado'), findsNothing);
  });

  testWidgets(
    'shows error UI when error != null and allEmployees is empty and retry calls fetchEmployees',
    (tester) async {
      when(() => mockUseCase()).thenAnswer((_) async => Failure(ServerError()));

      controller.isLoading.value = false;
      controller.screenError.value = ServerError();
      controller.allEmployees.clear();

      await tester.pumpWidget(wrapper(const HomeContentView()));

      expect(find.textContaining('Tentar'), findsOneWidget);

      await tester.tap(find.textContaining('Tentar'));
      await tester.pump();

      verify(() => mockUseCase()).called(2);
    },
  );

  testWidgets('shows empty message when allEmployees is empty and no error',
      (tester) async {
    when(() => mockUseCase()).thenAnswer((_) async => Failure(ServerError()));

    controller.isLoading.value = false;
    controller.screenError.value = null;
    controller.allEmployees.clear();

    await tester.pumpWidget(wrapper(const HomeContentView()));

    expect(find.text('Nenhum funcionário encontrado'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Tentar novamente'), findsNothing);
  });

  testWidgets('renders HomeContent when there are employees', (tester) async {
    when(() => mockUseCase()).thenAnswer((_) async => Success(talents));

    controller.isLoading.value = false;
    controller.screenError.value = null;

    controller.allEmployees.assignAll(talents);
    controller.recentEmployees.assignAll(talents.take(1).toList());

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(wrapper(const HomeContentView()));
    });

    expect(find.text('Funcionários Recentes'), findsOneWidget);
    expect(find.text('Todos os Funcionários'), findsOneWidget);
  });
}
