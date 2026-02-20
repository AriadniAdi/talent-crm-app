import 'package:flutter/material.dart';
import 'package:talent_crm_app/domain/entities/talent.dart';

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
        /// Section Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),

        const SizedBox(height: 12),

        /// Employees List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: employees.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final employee = employees[index];

            return _EmployeeCard(employee: employee);
          },
        ),
      ],
    );
  }
}

class _EmployeeCard extends StatelessWidget {
  final Talent employee;

  const _EmployeeCard({required this.employee});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          /// Avatar
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(employee.avatarUrl),
          ),

          const SizedBox(width: 12),

          /// Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),

          /// Action
          TextButton(
            onPressed: () {},
            child: const Text('Ver Perfil'),
          ),
        ],
      ),
    );
  }
}
