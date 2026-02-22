import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:talent_crm_app/core/design/app_spacing.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';
import 'package:talent_crm_app/features/home/presentation/home_page.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/home_bottom_bar.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/notifications_app_bar_icon.dart';

class HomeShell extends GetView<HomeController> {
  const HomeShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 2,
            backgroundColor: Theme.of(context).colorScheme.surface,
            surfaceTintColor: Colors.transparent,
            centerTitle: false,
            titleSpacing: 16,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const TalentLogo(),
                    const SizedBox(
                      width: AppSpacing.md,
                    ),
                    Text(
                      'Talent CRM',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              const NotificationsAppBarIcon(),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  child: Text(
                    "A", //TODO: Futuramente virá a do usuário
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: _buildPage(context, controller.selectedIndex.value),
          ),
          bottomNavigationBar: HomeBottomBar(
            currentIndex: controller.selectedIndex.value,
            notificationCount: controller.notificationsCount.value,
            onTap: controller.changeTab,
          ),
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const Center(child: Text('Equipes'));
      case 2:
        return const Center(child: Text('Notificações'));
      case 3:
        return const Center(child: Text('Notas de Voz'));
      default:
        return const HomePage();
    }
  }
}

class TalentLogo extends StatelessWidget {
  const TalentLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF4A90E2),
            Color(0xFF1E5FAF),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: CustomPaint(
        painter: _NetworkPainter(),
      ),
    );
  }
}

class _NetworkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final paintDot = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final p1 = Offset(size.width * 0.3, size.height * 0.3);
    final p2 = Offset(size.width * 0.7, size.height * 0.3);
    final p3 = Offset(size.width * 0.5, size.height * 0.7);

    // Linhas
    canvas.drawLine(p1, p2, paintLine);
    canvas.drawLine(p2, p3, paintLine);
    canvas.drawLine(p3, p1, paintLine);

    // Pontos
    canvas.drawCircle(p1, 3, paintDot);
    canvas.drawCircle(p2, 3, paintDot);
    canvas.drawCircle(p3, 3, paintDot);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
