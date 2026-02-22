import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:talent_crm_app/core/design/app_spacing.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';
import 'package:talent_crm_app/features/home/presentation/home_page.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/home_bottom_bar.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/notifications_app_bar_icon.dart';

class HomeShell extends GetView<HomeController> {
  const HomeShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 2,
            backgroundColor: Theme.of(context).colorScheme.surface,
            surfaceTintColor: Colors.transparent,
            centerTitle: false,
            titleSpacing: 16,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const TalentLogo(),
                    const SizedBox(
                      width: AppSpacing.md,
                    ),
                    Text(
                      'Talent CRM',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              const NotificationsAppBarIcon(),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  child: Text(
                    "A", //TODO: Futuramente virá a do usuário
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: _buildPage(context, controller.selectedIndex.value),
          ),
          bottomNavigationBar: HomeBottomBar(
            currentIndex: controller.selectedIndex.value,
            notificationCount: controller.notificationsCount.value,
            onTap: controller.changeTab,
          ),
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, int index) {
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
