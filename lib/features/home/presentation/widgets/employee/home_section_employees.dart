import 'package:flutter/material.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/employee/employee_card.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';

import '../../../../../core/design/design.dart';

class HomeSectionEmployees extends StatelessWidget {
  final String title;
  final List<Talent> employees;

  const HomeSectionEmployees({
    super.key,
    required this.title,
    required this.employees,
  });

  @override
  Widget build(BuildContext context) {
    if (employees.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          itemCount: employees.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
          itemBuilder: (context, index) {
            final employee = employees[index];

            return EmployeeCard(employee: employee);
          },
        ),
      ],
    );
  }
}
