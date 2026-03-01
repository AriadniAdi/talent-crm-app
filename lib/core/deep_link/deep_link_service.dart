import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import '../../core/routes/app_routes.dart';

class DeepLinkService {
  final AppLinks _appLinks = AppLinks();

  void init() {
    _listen();
    _handleInitial();
  }

  void _listen() {
    _appLinks.uriLinkStream.listen((uri) {
      _handle(uri);
    });
  }

  Future<void> _handleInitial() async {
    final uri = await _appLinks.getInitialAppLink();
    if (uri != null) {
      _handle(uri);
    }
  }

  void _handle(Uri uri) {
    if (uri.scheme == 'talentcrm' && uri.host == 'talent') {
      final id = uri.queryParameters['id'];

      if (id != null) {
        Get.offAllNamed(
          AppRoutes.talent,
          parameters: {'id': id},
        );
      }
    }
  }
}
