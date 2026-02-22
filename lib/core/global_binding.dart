import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:http/http.dart' as http;

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<http.Client>(http.Client(), permanent: true);
  }
}
