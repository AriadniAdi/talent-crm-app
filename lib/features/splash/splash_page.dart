import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/design/design.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';
import 'package:talent_crm_app/l10n/translate.dart';

class SplashPage extends StatefulWidget {
  final Duration delay;
  final bool enableNavigation;
  final AppLinks? appLinks;

  const SplashPage({
    super.key,
    this.delay = const Duration(seconds: 2),
    this.enableNavigation = true,
    this.appLinks,
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _controller.forward();

    if (widget.enableNavigation) {
      _handleNavigation();
    }
  }

  Future<void> _handleNavigation() async {
    final links = widget.appLinks ?? AppLinks();
    final initialUri = await links.getInitialAppLink();

    if (initialUri != null &&
        initialUri.host == 'talent' &&
        initialUri.queryParameters['id'] != null) {
      final id = initialUri.queryParameters['id']!;
      Get.offNamed(
        AppRoutes.talent,
        parameters: {'id': id},
      );
      return;
    }

    Get.offNamed(AppRoutes.home);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TalentLogo(
                size: 180,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                context.translate.appTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
