import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/features/notifications/presentation/controller/notification_controller.dart';

import 'package:talent_crm_app/features/home/presentation/widgets/notifications_app_bar_icon.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/usecases/get_recent_talent_usecase.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talents_usecase.dart';
import 'package:talent_crm_app/features/talent/usecases/search_talents_usecase.dart';

import '../../../helpers/wrapper.dart';

class FakeHomeController extends GetxController implements HomeController {
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
  Rxn<AppError> get screenError => throw UnimplementedError();
}

void main() {
  late FakeHomeController controller;
  late NotificationController notificationController;

  setUp(() {
    controller = FakeHomeController();
    notificationController = NotificationController();
    Get.put<HomeController>(controller);
    Get.put<NotificationController>(notificationController);
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
    await tester.pumpWidget(
      wrapper(
        const NotificationsAppBarIcon(),
      ),
    );
    await tester.pump();

    expect(find.textContaining(RegExp(r'\d')), findsNothing);
  });

  testWidgets('shows badge when count > 0', (tester) async {
    notificationController.addNotification('title', 'message');

    await tester.pumpWidget(
      wrapper(
        const NotificationsAppBarIcon(),
      ),
    );

    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('shows 9+ when count > 9', (tester) async {
    for (var i = 0; i < 15; i++) {
      notificationController.addNotification('title $i', 'message $i');
    }

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

    expect(controller.tappedIndex, 2);
  });

  testWidgets('updates reactively when count changes', (tester) async {
    await tester.pumpWidget(
      wrapper(
        const NotificationsAppBarIcon(),
      ),
    );

    notificationController.addNotification('title 1', 'message 1');
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    notificationController.addNotification('title 2', 'message 2');
    await tester.pump();
    expect(find.text('2'), findsOneWidget);
  });
}
