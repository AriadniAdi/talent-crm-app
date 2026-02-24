import 'package:flutter/material.dart';
import 'package:talent_crm_app/core/design/design.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/employee/home_section_employees.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/l10n/app_localizations.dart';

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
          title: AppLocalizations.of(context)!.recentEmployee,
          employees: recent,
        ),
        const SizedBox(height: AppSpacing.xl),
        HomeSectionEmployees(
          title: AppLocalizations.of(context)!.allEmployees,
          employees: all,
        ),
      ],
    );
  }
}
