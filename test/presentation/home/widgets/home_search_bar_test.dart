import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/usecases/get_recent_talent_usecase.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talents_usecase.dart';
import 'package:talent_crm_app/features/talent/usecases/search_talents_usecase.dart';

import 'package:talent_crm_app/features/home/presentation/widgets/home_search_bar.dart';

import '../../helpers/wrapper.dart';

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
  late TestHomeController controller;

  setUp(() {
    controller = TestHomeController();
    Get.put<HomeController>(controller);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('renders TextField with hint and search icon', (tester) async {
    await tester.pumpWidget(wrapper(const Scaffold(body: HomeSearchBar())));

    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Buscar funcionário...'), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('calls controller.search when typing', (tester) async {
    await tester.pumpWidget(wrapper(const Scaffold(body: HomeSearchBar())));

    await tester.enterText(find.byType(TextField), 'Adi');
    await tester.pump();

    expect(controller.calledValues, ['Adi']);
  });

  testWidgets('has horizontal padding of 16', (tester) async {
    await tester.pumpWidget(wrapper(const Scaffold(body: HomeSearchBar())));

    final padding = tester.widget<Padding>(find.byType(Padding).first);

    expect(padding.padding, const EdgeInsets.symmetric(horizontal: 16));
  });
}
