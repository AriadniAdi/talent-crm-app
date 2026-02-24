import 'package:flutter/material.dart';
import 'package:talent_crm_app/core/design/design.dart';

class HomeBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onPressed;

  const HomeBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withValues(alpha: 0.85),
            theme.colorScheme.primaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.22),
            blurRadius: 24,
            spreadRadius: 0,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          /// 🔹 Background decoration (linhas tech)
          Positioned.fill(
            child: CustomPaint(
              painter: DottedBackgroundPainter(
                dotColor: theme.colorScheme.onPrimary,
              ),
            ),
          ),

          /// 🔹 Conteúdo
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      theme.colorScheme.surface.withValues(alpha: 0.9),
                  foregroundColor: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: onPressed,
                child: Text(buttonText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
