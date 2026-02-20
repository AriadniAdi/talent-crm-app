import 'package:get/get.dart';
import 'package:talent_crm_app/domain/entities/talent/talent.dart';
import 'package:talent_crm_app/domain/usecases/talent/get_recent_talent_usecase.dart';
import 'package:talent_crm_app/domain/usecases/talent/get_talent_usecase.dart';
import 'package:talent_crm_app/domain/usecases/talent/search_talents_usecase.dart';

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
  final RxnString error = RxnString();

  final RxString searchQuery = ''.obs;

  List<Talent> _allOriginal = const [];

  void changeTab(int index) => selectedIndex.value = index;

  void updateNotificationCount(int value) => notificationsCount.value = value;

  @override
  void onInit() {
    super.onInit();
    fetchEmployees();
  }

  Future<void> fetchEmployees() async {
    try {
      isLoading.value = true;
      error.value = null;

      final talents = await getTalentsUseCase();

      _allOriginal = talents;

      allEmployees.assignAll(talents);
      recentEmployees.assignAll(getRecentTalentsUseCase(talents, limit: 4));
    } catch (e) {
      error.value = 'Falha ao carregar funcionários';
    } finally {
      isLoading.value = false;
    }
  }

  void search(String value) {
    searchQuery.value = value;

    final filtered = searchTalentsUseCase(_allOriginal, value);
    allEmployees.assignAll(filtered);
  }
}
