import 'package:get/get.dart';
import 'package:talent_crm_app/features/voice/presentation/controller/voice_controller.dart';

class VoicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VoiceController());
  }
}
