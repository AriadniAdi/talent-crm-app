import 'package:get/get.dart';
import 'package:talent_crm_app/domain/entities/talent.dart';
import 'package:talent_crm_app/data/services/talent_service.dart';

class HomeController extends GetxController {
  final TalentService service;

  HomeController(this.service);

  final RxList<Talent> allEmployees = <Talent>[].obs;
  final RxList<Talent> recentEmployees = <Talent>[].obs;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEmployees();
  }

  Future<void> fetchEmployees() async {
    try {
      isLoading.value = true;

      final result = await service.fetchTalents();

      allEmployees.assignAll(result);
      recentEmployees.assignAll(result.take(4).toList());
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao carregar funcionários');
    } finally {
      isLoading.value = false;
    }
  }
}
