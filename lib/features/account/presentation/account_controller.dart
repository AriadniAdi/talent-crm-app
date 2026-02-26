import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AccountController extends GetxController {
  final String id;

  AccountController(this.id);

  @override
  void onInit() {
    super.onInit();
    loadTalent();
  }

  void loadTalent() {}
}
