import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:talent_crm_app/core/design/design.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/l10n/translate.dart';

class EmployeeCard extends StatelessWidget {
  final Talent employee;
  final VoidCallback? onViewProfile;

  const EmployeeCard({super.key, required this.employee, this.onViewProfile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.md),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: AppSpacing.xl,
            backgroundImage: NetworkImage(employee.avatarUrl),
          ),
          const SizedBox(
            width: AppSpacing.md,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
              ],
            ),
          ),
          TextButton(
            onPressed: onViewProfile ??
                () => Get.toNamed(
                      AppRoutes.talent,
                      parameters: {
                        'id': employee.id.toString(),
                      },
                    ),
            child: Text(context.translate.viewProfile),
          ),
        ],
      ),
    );
  }
}
