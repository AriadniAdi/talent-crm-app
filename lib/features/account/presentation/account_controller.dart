import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';

class AccountController extends GetxController {
  final String? id;

  AccountController(this.id);

  final screenError = Rxn<AppError>();

  @override
  void onInit() {
    super.onInit();
    if (id == null) {
      screenError.value = InvalidRouteError();
      return;
    }
  }
}
