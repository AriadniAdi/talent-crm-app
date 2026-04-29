import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';
import 'package:talent_crm_app/features/account/entities/account.dart';

import '../../../../core/design/design.dart';

class ProfileAvatarButton extends StatelessWidget {
  final Account account;

  const ProfileAvatarButton({
    super.key,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.xl),
        onTap: () => Get.toNamed(AppRoutes.account),
        child: CircleAvatar(
          radius: 18,
          backgroundColor: colors.primaryContainer,
          child: Text(
            "A",
            style: TextStyle(
              color: colors.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
