import 'package:get/get.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/usecases/get_recent_talent_usecase.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talents_usecase.dart';
import 'package:talent_crm_app/features/talent/usecases/search_talents_usecase.dart';
import 'package:talent_crm_app/features/notifications/presentation/controller/notification_controller.dart';
import 'package:talent_crm_app/l10n/translate.dart';

class HomeController extends GetxController {
  final GetTalentsUseCase getTalentsUseCase;
  final GetRecentTalentsUseCase getRecentTalentsUseCase;
  final SearchTalentsUseCase searchTalentsUseCase;

  HomeController(
    this.getTalentsUseCase, {
    GetRecentTalentsUseCase? getRecentTalentsUseCase,
    SearchTalentsUseCase? searchTalentsUseCase,
  })  : getRecentTalentsUseCase =
            getRecentTalentsUseCase ?? const GetRecentTalentsUseCase(),
        searchTalentsUseCase =
            searchTalentsUseCase ?? const SearchTalentsUseCase();

  final selectedIndex = 0.obs;

  final RxList<Talent> allEmployees = <Talent>[].obs;
  final RxList<Talent> recentEmployees = <Talent>[].obs;

  final RxBool isLoading = false.obs;
  final Rxn<AppError> screenError = Rxn<AppError>();

  final RxString searchQuery = ''.obs;

  List<Talent> _allOriginal = const [];

  void changeTab(int index) => selectedIndex.value = index;

  @override
  void onInit() {
    super.onInit();
    fetchEmployees();
  }

  Future<void> fetchEmployees() async {
    isLoading.value = true;
    screenError.value = null;

    final result = await getTalentsUseCase();

    result.when(
      success: (talents) {
        _allOriginal = talents;

        allEmployees.assignAll(talents);

        recentEmployees.assignAll(
          getRecentTalentsUseCase(talents, limit: 4),
        );

        final context = Get.context;
        if (context != null && context.mounted && Get.isRegistered<NotificationController>()) {
          final notificationController = Get.find<NotificationController>();
          notificationController.addNotification(
            context.translate.talentsUpdatedNotification,
            context.translate.talentsUpdatedNotification,
          );
        }
      },
      failure: (error) {
        screenError.value = error;
      },
    );

    isLoading.value = false;
  }

  void search(String value) {
    searchQuery.value = value;

    final filtered = searchTalentsUseCase(_allOriginal, value);
    allEmployees.assignAll(filtered);
  }
}
