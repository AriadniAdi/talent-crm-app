import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/design/design.dart';

class BasePage extends StatelessWidget {
  final String? title;
  final Widget child;
  final Widget? bottomNavigationBar;

  final bool showBackButton;
  final bool showAppBar;
  final List<Widget>? actions;
  final EdgeInsets? padding;

  const BasePage({
    super.key,
    this.title,
    required this.child,
    this.showBackButton = true,
    this.showAppBar = true,
    this.actions,
    this.padding,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: title,
              centerTitle: false,
              elevation: 0,
              backgroundColor: colors.surface,
              foregroundColor: colors.onSurface,
              leading: showBackButton
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new),
                      onPressed: () => Get.back(),
                    )
                  : null,
              actions: actions,
            )
          : null,
      body: Padding(
        padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
        child: child,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
