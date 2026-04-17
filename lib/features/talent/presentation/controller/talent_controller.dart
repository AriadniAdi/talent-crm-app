import 'package:get/get.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talent_by_id_usecase.dart';

class TalentController extends GetxController {
  final int id;
  final GetTalentByIdUseCase getTalentByIdUseCase;

  TalentController(this.getTalentByIdUseCase, this.id);

  final isLoading = false.obs;
  Rxn<AppError> screenError = Rxn<AppError>();
  final talent = Rxn<Talent>();

  @override
  void onInit() {
    super.onInit();
    fetchTalent();
  }

  Future<void> fetchTalent() async {
    isLoading.value = true;
    screenError.value = null;

    final result = await getTalentByIdUseCase(id);

    result.when(success: (data) {
      talent.value = data;
    }, failure: (error) {
      screenError.value = error;
    });

    isLoading.value = false;
  }
}
