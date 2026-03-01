import 'package:flutter/material.dart';
import 'package:talent_crm_app/main.dart';
import '../deep_link/deep_link_service.dart';

class AppBootstrapper extends StatefulWidget {
  final DeepLinkService? deepLinkService;
  const AppBootstrapper({super.key, this.deepLinkService});

  @override
  State<AppBootstrapper> createState() => _AppBootstrapperState();
}

class _AppBootstrapperState extends State<AppBootstrapper> {
  late final DeepLinkService _service;

  @override
  void initState() {
    super.initState();

    _service = widget.deepLinkService ?? DeepLinkService();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _service.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
}
