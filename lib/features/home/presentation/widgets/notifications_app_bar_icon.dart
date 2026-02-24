import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:talent_crm_app/core/design/design.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';

class NotificationsAppBarIcon extends GetView<HomeController> {
  const NotificationsAppBarIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final count = controller.notificationsCount.value;

      return Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () => controller.changeTab(2),
          ),
          if (count > 0)
            Positioned(
              right: 10,
              top: 10,
              child: _Badge(count: count),
            ),
        ],
      );
    });
  }
}

class _Badge extends StatelessWidget {
  final int count;

  const _Badge({required this.count});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack,
          ),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: count > 0
          ? Container(
              key: ValueKey(count),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.badge,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.badge.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Center(
                child: Text(
                  count > 9 ? '9+' : '$count',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(
              key: ValueKey(0),
            ),
    );
  }
}
