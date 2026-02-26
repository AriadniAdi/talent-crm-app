import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:talent_crm_app/features/account/presentation/account_controller.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    final id = Get.parameters['id'];

    if (id == null) {
      throw Exception('AccountBinding requires an id parameter');
    }

    Get.lazyPut(() => AccountController(id));
  }
}
