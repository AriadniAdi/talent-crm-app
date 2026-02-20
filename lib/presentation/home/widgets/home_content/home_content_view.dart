import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/presentation/home/controller/home_controller.dart';
import 'home_content.dart';

class HomeContentView extends GetView<HomeController> {
  const HomeContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return HomeContent(
        recent: controller.recentEmployees,
        all: controller.allEmployees,
      );
    });
  }
}
