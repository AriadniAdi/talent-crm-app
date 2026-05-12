import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/features/notifications/entities/notification_entity.dart';
import 'package:uuid/uuid.dart';

class NotificationController extends GetxController {
  final RxList<NotificationEntity> notifications = <NotificationEntity>[].obs;

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  void addNotification(String title, String message) {
    final notification = NotificationEntity(
      id: const Uuid().v4(),
      title: title,
      message: message,
      timestamp: DateTime.now(),
    );

    notifications.insert(0, notification);

    // Only show snackbar if not in a test environment and context is available
    if (!Get.testMode && Get.context != null) {
      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white.withValues(alpha: 0.9),
        colorText: Colors.black,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 3),
        boxShadows: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      );
    }
  }

  void markAsRead(String id) {
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      notifications[index] = notifications[index].copyWith(isRead: true);
    }
  }

  void markAllAsRead() {
    for (var i = 0; i < notifications.length; i++) {
      if (!notifications[i].isRead) {
        notifications[i] = notifications[i].copyWith(isRead: true);
      }
    }
  }

  void clearAll() {
    notifications.clear();
  }
}
