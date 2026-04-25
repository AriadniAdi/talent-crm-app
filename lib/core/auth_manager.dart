import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';

class AuthManager extends GetxController {
  final FirebaseAuth _auth;
  late final Rx<User?> user;

  AuthManager({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

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
        if (!user.emailVerified && user.providerData.any((p) => p.providerId == 'password')) {
          if (Get.currentRoute != AppRoutes.emailVerification) {
            Get.offAllNamed(AppRoutes.emailVerification);
          }
          return;
        }

        if (Get.currentRoute == AppRoutes.login ||
            Get.currentRoute == AppRoutes.register ||
            Get.currentRoute == AppRoutes.loginEmail ||
            Get.currentRoute == AppRoutes.emailVerification) {
          Get.offAllNamed(AppRoutes.home);
        }
      }
    }
  }

  bool get isAuthenticated => user.value != null;

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
