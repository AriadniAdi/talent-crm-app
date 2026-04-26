import 'package:get/get.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/usecases/get_recent_talent_usecase.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talents_usecase.dart';
import 'package:talent_crm_app/features/talent/usecases/search_talents_usecase.dart';

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
  final notificationsCount = 0.obs;

  final RxList<Talent> allEmployees = <Talent>[].obs;
  final RxList<Talent> recentEmployees = <Talent>[].obs;

  final RxBool isLoading = false.obs;
  final Rxn<AppError> screenError = Rxn<AppError>();

  final RxString searchQuery = ''.obs;

  List<Talent> _allOriginal = const [];
  final RxInt _totalTalentsCount = 0.obs;

  int get totalTalentsCount => _totalTalentsCount.value;

  void changeTab(int index) => selectedIndex.value = index;

  void updateNotificationCount(int value) => notificationsCount.value = value;

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
        _totalTalentsCount.value = talents.length;

        allEmployees.assignAll(talents);

        recentEmployees.assignAll(
          getRecentTalentsUseCase(talents, limit: 4),
        );
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
