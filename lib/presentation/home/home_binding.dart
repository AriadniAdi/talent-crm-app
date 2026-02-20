import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:talent_crm_app/data/services/talent_service.dart';
import 'package:talent_crm_app/presentation/home/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => http.Client());
    Get.lazyPut(() => TalentService(Get.find()));
    Get.lazyPut(() => HomeController(Get.find()));
  }
}
