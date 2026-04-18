import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';

class AuthManager extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final Rx<User?> user;

  @override
  void onInit() {
    super.onInit();
    user = Rx<User?>(_auth.currentUser);
    user.bindStream(_auth.authStateChanges());
    ever(user, _handleAuthChanged);
  }

  void _handleAuthChanged(User? user) {
    if (Get.currentRoute != AppRoutes.splash) {
      if (user == null) {
        Get.offAllNamed(AppRoutes.login);
      } else {
        if (Get.currentRoute == AppRoutes.login || 
            Get.currentRoute == AppRoutes.register || 
            Get.currentRoute == '/loginEmail') {
          Get.offAllNamed(AppRoutes.home);
        }
      }
    }
  }

  bool get isAuthenticated => user.value != null;
}
