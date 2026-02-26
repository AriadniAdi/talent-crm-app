import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:talent_crm_app/features/talent/presentation/controller/talent_controller.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talent_by_id_usecase.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talents_usecase.dart';

class TalentBinding extends Bindings {
  @override
  void dependencies() {
    final idParam = Get.parameters['id'];

    if (idParam == null) {
      throw Exception('Talent id not provided');
    }

    final id = int.tryParse(idParam);

    if (id == null) {
      throw ArgumentError('Invalid talent id');
    }

    // Domain
    Get.lazyPut<GetTalentsUseCase>(() => GetTalentsUseCase(Get.find()));
    Get.lazyPut<GetTalentByIdUseCase>(() => GetTalentByIdUseCase(Get.find()));

    // Presentation
    Get.lazyPut(() => TalentController(Get.find(), id));
  }
}
