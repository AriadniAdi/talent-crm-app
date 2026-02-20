import 'package:get/get.dart';
import 'package:talent_crm_app/domain/entities/talent.dart';
import 'package:talent_crm_app/data/services/talent_service.dart';

class HomeController extends GetxController {
  final TalentService service;

  HomeController(this.service);

  final selectedIndex = 0.obs;
  final notificationsCount = 0.obs;

  final RxList<Talent> allEmployees = <Talent>[].obs;
  final RxList<Talent> recentEmployees = <Talent>[].obs;

  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();

  final RxString searchQuery = ''.obs;

  List<Talent> _allOriginal = [];

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

      final talents = await service.fetchTalents();

      _allOriginal = talents;

      allEmployees.assignAll(talents);
      recentEmployees.assignAll(talents.take(4).toList());
    } catch (e) {
      error.value = 'Falha ao carregar funcionários';
    } finally {
      isLoading.value = false;
    }
  }

  void search(String value) {
    searchQuery.value = value;

    if (value.isEmpty) {
      allEmployees.assignAll(_allOriginal);
      return;
    }

    final filtered = _allOriginal.where((talent) {
      return talent.name.toLowerCase().contains(value.toLowerCase());
    }).toList();

    allEmployees.assignAll(filtered);
  }
}
