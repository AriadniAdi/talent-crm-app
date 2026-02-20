import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/domain/entities/talent/talent.dart';
import 'package:talent_crm_app/domain/usecases/talent/get_recent_talent_usecase.dart';
import 'package:talent_crm_app/domain/usecases/talent/get_talent_usecase.dart';
import 'package:talent_crm_app/domain/usecases/talent/search_talents_usecase.dart';

import 'package:talent_crm_app/presentation/home/controller/home_controller.dart';
import 'package:talent_crm_app/presentation/home/widgets/home_search_bar.dart';

/// Controller simples apenas para teste
class TestHomeController extends GetxController implements HomeController {
  final calledValues = <String>[];

  @override
  void search(String value) {
    calledValues.add(value);
  }

  @override
  Future<void> fetchEmployees() async {}

  @override
  RxList<Talent> get allEmployees => throw UnimplementedError();

  @override
  void changeTab(int index) {}

  @override
  RxnString get error => throw UnimplementedError();

  @override
  GetRecentTalentsUseCase get getRecentTalentsUseCase =>
      throw UnimplementedError();

  @override
  GetTalentsUseCase get getTalentsUseCase => throw UnimplementedError();

  @override
  RxBool get isLoading => throw UnimplementedError();

  @override
  RxInt get notificationsCount => throw UnimplementedError();

  @override
  RxList<Talent> get recentEmployees => throw UnimplementedError();

  @override
  RxString get searchQuery => throw UnimplementedError();

  @override
  SearchTalentsUseCase get searchTalentsUseCase => throw UnimplementedError();

  @override
  RxInt get selectedIndex => throw UnimplementedError();

  @override
  void updateNotificationCount(int value) {}
}

void main() {
  Widget wrap(Widget child) => GetMaterialApp(home: Scaffold(body: child));

  late TestHomeController controller;

  setUp(() {
    Get.testMode = true;
    Get.reset();

    controller = TestHomeController();
    Get.put<HomeController>(controller);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('renders TextField with hint and search icon', (tester) async {
    await tester.pumpWidget(wrap(const HomeSearchBar()));

    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Buscar funcionário...'), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('calls controller.search when typing', (tester) async {
    await tester.pumpWidget(wrap(const HomeSearchBar()));

    await tester.enterText(find.byType(TextField), 'Adi');
    await tester.pump();

    expect(controller.calledValues, ['Adi']);
  });

  testWidgets('has horizontal padding of 16', (tester) async {
    await tester.pumpWidget(wrap(const HomeSearchBar()));

    final padding = tester.widget<Padding>(find.byType(Padding).first);

    expect(padding.padding, const EdgeInsets.symmetric(horizontal: 16));
  });
}
