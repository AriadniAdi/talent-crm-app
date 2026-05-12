import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/design/design.dart';
import 'package:talent_crm_app/core/errors/app_error_extension.dart';
import 'package:talent_crm_app/core/pages/base_page.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';
import 'package:talent_crm_app/core/widgets/error_state_widget.dart';
import 'package:talent_crm_app/features/account/entities/account.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';
import 'package:talent_crm_app/features/home/presentation/home_page.dart';
import 'package:talent_crm_app/features/voice/presentation/voices_page.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/home_bottom_bar.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/notifications_app_bar_icon.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/profile_avatar_button.dart';
import 'package:talent_crm_app/features/notifications/presentation/controller/notification_controller.dart';
import 'package:talent_crm_app/l10n/translate.dart';
import 'package:talent_crm_app/core/auth_manager.dart';

class HomeShell extends GetView<HomeController> {
  const HomeShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.screenError.value != null &&
            controller.allEmployees.isEmpty) {
          return ErrorStateWidget(
            message: controller.screenError.value!.message(context),
            onRetry: controller.fetchEmployees,
          );
        }

        if (controller.allEmployees.isEmpty) {
          return Center(
            child: Text(context.translate.noEmployeesFound),
          );
        }

        final notificationController = Get.find<NotificationController>();

        return BasePage(
          title: InkWell(
            key: const Key('homeLogoButton'),
            borderRadius: BorderRadius.circular(AppSpacing.sm),
            onTap: () {
              controller.changeTab(0);

              if (Get.currentRoute != AppRoutes.home) {
                Get.offAllNamed(AppRoutes.home);
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const TalentLogo(size: 26),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  context.translate.appTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          showBackButton: false,
          padding: EdgeInsets.zero,
          actions: [
            const NotificationsAppBarIcon(),
            const SizedBox(width: AppSpacing.sm),
            const ProfileAvatarButton(
              account: Account(id: 1),
            ),
            const SizedBox(width: AppSpacing.sm),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => Get.find<AuthManager>().signOut(),
            ),
          ],
          bottomNavigationBar: HomeBottomBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeTab,
            notificationCount: notificationController.unreadCount,
          ),
          child: _buildPage(context, controller.selectedIndex.value),
        );
      }),
    );
  }

  Widget _buildPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return Center(
            key: const Key('notificationsKey'),
            child: Text(context.translate.notifications));
      case 2:
        return _buildNotificationsList(context);
      case 3:
        return const VoicesPage();
      default:
        return const HomePage();
    }
  }

  Widget _buildNotificationsList(BuildContext context) {
    final notificationController = Get.find<NotificationController>();

    return Container(
      key: const Key('notificationsKey'),
      child: Obx(() {
        final notifications = notificationController.notifications;

        if (notifications.isEmpty) {
          return Center(
            child: Text(context.translate.notifications),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: notifications.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return ListTile(
              leading: Icon(
                notification.isRead
                    ? Icons.notifications_outlined
                    : Icons.notifications_active,
                color: notification.isRead ? Colors.grey : AppColors.primary,
              ),
              title: Text(
                notification.title,
                style: TextStyle(
                  fontWeight:
                      notification.isRead ? FontWeight.normal : FontWeight.bold,
                ),
              ),
              subtitle: Text(notification.message),
              trailing: Text(
                "${notification.timestamp.hour}:${notification.timestamp.minute.toString().padLeft(2, '0')}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: () => notificationController.markAsRead(notification.id),
            );
          },
        );
      }),
    );
  }
}
