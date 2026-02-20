import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';
import 'home_content.dart';

class HomeContentView extends GetView<HomeController> {
  const HomeContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (controller.error.value != null && controller.allEmployees.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 40, color: Colors.red),
              const SizedBox(height: 12),
              Text(controller.error.value!),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: controller.fetchEmployees,
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        );
      }

      if (controller.allEmployees.isEmpty) {
        return const Center(
          child: Text('Nenhum funcionário encontrado'),
        );
      }

      return HomeContent(
        recent: controller.recentEmployees,
        all: controller.allEmployees,
      );
    });
  }
}
