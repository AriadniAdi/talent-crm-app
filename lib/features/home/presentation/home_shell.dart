import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:talent_crm_app/core/design/design.dart';
import 'package:talent_crm_app/core/widgets/base_page.dart';
import 'package:talent_crm_app/features/account/entities/account.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';
import 'package:talent_crm_app/features/home/presentation/home_page.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/notifications_app_bar_icon.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/profile_avatar_button.dart';
import 'package:talent_crm_app/l10n/translate.dart';

class HomeShell extends GetView<HomeController> {
  const HomeShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Obx(
        () => BasePage(
          title: Row(
            children: [
              const TalentLogo(size: 26),
              const SizedBox(width: AppSpacing.sm),
              Text(
                context.translate.appTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          showBackButton: false,
          padding: EdgeInsets.zero,
          actions: const [
            NotificationsAppBarIcon(),
            ProfileAvatarButton(
              account: Account(id: 1),
            ),
          ],
          child: _buildPage(context, controller.selectedIndex.value),
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return Center(child: Text(context.translate.teams));
      case 2:
        return Center(child: Text(context.translate.notifications));
      case 3:
        return Center(child: Text(context.translate.voiceNotes));
      default:
        return const HomePage();
    }
  }
}
