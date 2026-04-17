import 'package:get/get.dart';

class LoginController extends GetxController {
  final isLoading = false.obs;

  Future<void> continueWithEmail() async {
    isLoading.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 350));
    isLoading.value = false;
  }
}
