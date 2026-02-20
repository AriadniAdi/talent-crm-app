import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:talent_crm_app/data/services/talent_service.dart';
import 'package:talent_crm_app/domain/entities/talent.dart';

class TalentController extends GetxController {
  final TalentService service;

  TalentController(this.service);

  final isLoading = false.obs;
  final talents = <Talent>[].obs;
  final error = RxnString();

  @override
  void onInit() {
    fetchTalents();
    super.onInit();
  }

  Future<void> fetchTalents() async {
    try {
      isLoading.value = true;
      error.value = null;

      final models = await service.fetchTalents();
      talents.value = models.map((m) => m.toEntity()).toList();
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
