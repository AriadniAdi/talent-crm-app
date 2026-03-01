import 'package:flutter/material.dart';
import 'package:talent_crm_app/main.dart';
import '../deep_link/deep_link_service.dart';

class AppBootstrapper extends StatefulWidget {
  const AppBootstrapper({super.key});

  @override
  State<AppBootstrapper> createState() => _AppBootstrapperState();
}

class _AppBootstrapperState extends State<AppBootstrapper> {
  final DeepLinkService _deepLinkService = DeepLinkService();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _deepLinkService.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
}
