import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:talent_crm_app/presentation/home/controller/home_controller.dart';
import 'package:talent_crm_app/presentation/home/home_page.dart';
import 'package:talent_crm_app/presentation/home/widgets/home_bottom_bar.dart';

class HomeShell extends GetView<HomeController> {
  const HomeShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: Colors.pink,
          body: SafeArea(
            child: _buildPage(controller.selectedIndex.value),
          ),
          bottomNavigationBar: HomeBottomBar(
            currentIndex: controller.selectedIndex.value,
            notificationCount: 1, //TODO: controller.notificationCount.value,
            onTap: controller.changeTab,
          ),
        ));
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const Center(child: Text('Equipes'));
      case 2:
        return const Center(child: Text('Notificações'));
      case 3:
        return const Center(child: Text('Notas de Voz'));
      default:
        return const HomePage();
    }
  }
}
