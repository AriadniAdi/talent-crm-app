import 'package:get/get.dart';
import 'package:talent_crm_app/domain/entities/talent/talent.dart';
import 'package:talent_crm_app/domain/usecases/talent/get_talent_usecase.dart';

class TalentController extends GetxController {
  final GetTalentsUseCase getTalentsUseCase;

  TalentController(this.getTalentsUseCase);

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

      final result = await getTalentsUseCase();
      talents.value = result;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
