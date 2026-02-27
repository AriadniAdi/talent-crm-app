import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:talent_crm_app/core/errors/app_error_extension.dart';
import 'package:talent_crm_app/core/widgets/error_state_widget.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/home_content/home_content.dart';
import 'package:talent_crm_app/l10n/translate.dart';

class HomeStateView extends GetView<HomeController> {
  const HomeStateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.screenError.value != null &&
          controller.allEmployees.isEmpty) {
        return ErrorStateWidget(
          message: controller.screenError.value!.message(context),
          onRetry: controller.fetchEmployees,
        );
      }

      if (controller.allEmployees.isEmpty) {
        return Center(
          child: Text(context.translate.noEmployeesFound),
        );
      }

      return HomeContent(
        recent: controller.recentEmployees,
        all: controller.allEmployees,
      );
    });
  }
}
