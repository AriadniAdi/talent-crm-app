import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';

import 'package:talent_crm_app/features/home/presentation/widgets/notifications_app_bar_icon.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/usecases/get_recent_talent_usecase.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talents_usecase.dart';
import 'package:talent_crm_app/features/talent/usecases/search_talents_usecase.dart';

import '../../../helpers/wrapper.dart';

class FakeHomeController extends GetxController implements HomeController {
  @override
  final RxInt notificationsCount = 0.obs;

  int? tappedIndex;

  @override
  void changeTab(int index) {
    tappedIndex = index;
  }

  @override
  RxList<Talent> get allEmployees => throw UnimplementedError();

  @override
  Future<void> fetchEmployees() {
    throw UnimplementedError();
  }

  @override
  GetRecentTalentsUseCase get getRecentTalentsUseCase =>
      throw UnimplementedError();

  @override
  GetTalentsUseCase get getTalentsUseCase => throw UnimplementedError();

  @override
  RxBool get isLoading => throw UnimplementedError();

  @override
  RxList<Talent> get recentEmployees => throw UnimplementedError();

  @override
  void search(String value) {}

  @override
  RxString get searchQuery => throw UnimplementedError();

  @override
  SearchTalentsUseCase get searchTalentsUseCase => throw UnimplementedError();

  @override
  RxInt get selectedIndex => throw UnimplementedError();

  @override
  void updateNotificationCount(int value) {}

  @override
  Rxn<AppError> get screenError => throw UnimplementedError();

  @override
  int get totalTalentsCount => throw UnimplementedError();
}

void main() {
  late FakeHomeController controller;

  setUp(() {
    controller = FakeHomeController();
    Get.put<HomeController>(controller);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('renders notification icon', (tester) async {
    await tester.pumpWidget(
      wrapper(
        const NotificationsAppBarIcon(),
      ),
    );

    expect(find.byIcon(Icons.notifications_none), findsOneWidget);
  });

  testWidgets('does not show badge when count = 0', (tester) async {
    controller.notificationsCount.value = 0;

    await tester.pumpWidget(
      wrapper(
        const NotificationsAppBarIcon(),
      ),
    );
    await tester.pump();

    expect(find.textContaining(RegExp(r'\d')), findsNothing);
  });

  testWidgets('shows badge when count > 0', (tester) async {
    controller.notificationsCount.value = 3;

    await tester.pumpWidget(
      wrapper(
        const NotificationsAppBarIcon(),
      ),
    );

    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('shows 9+ when count > 9', (tester) async {
    controller.notificationsCount.value = 15;

    await tester.pumpWidget(
      wrapper(
        const NotificationsAppBarIcon(),
      ),
    );

    await tester.pump();

    expect(find.text('9+'), findsOneWidget);
  });

  testWidgets('calls changeTab(2) when tapped', (tester) async {
    await tester.pumpWidget(
      wrapper(
        const NotificationsAppBarIcon(),
      ),
    );

    await tester.tap(find.byType(IconButton));
    await tester.pump();

    expect(controller.tappedIndex, 1);
  });

  testWidgets('updates reactively when count changes', (tester) async {
    controller.notificationsCount.value = 1;

    await tester.pumpWidget(
      wrapper(
        const NotificationsAppBarIcon(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('1'), findsOneWidget);

    controller.notificationsCount.value = 5;
    await tester.pumpAndSettle();

    expect(find.text('5'), findsOneWidget);
  });
}
