import 'package:flutter/material.dart';
import 'package:talent_crm_app/domain/entities/talent/talent.dart';
import 'package:talent_crm_app/presentation/home/widgets/employee/employee_card.dart';

class HomeContent extends StatelessWidget {
  final List<Talent> recent;
  final List<Talent> all;

  const HomeContent({
    super.key,
    required this.recent,
    required this.all,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeSectionEmployees(
          title: 'Funcionários Recentes',
          employees: recent,
        ),
        const SizedBox(height: 24),
        HomeSectionEmployees(
          title: 'Todos os Funcionários',
          employees: all,
        ),
      ],
    );
  }
}
