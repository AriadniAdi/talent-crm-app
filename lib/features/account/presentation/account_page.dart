import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/design/design.dart';
import 'package:talent_crm_app/core/locale/app_locale_service.dart';
import 'package:talent_crm_app/core/pages/base_page.dart';
import 'package:talent_crm_app/features/account/presentation/account_controller.dart';

class AccountPage extends GetView<AccountController> {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BasePage(
      key: const Key('account-page'),
      title: Text(_copy(context, pt: 'Conta', en: 'Account', es: 'Cuenta')),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _copy(
              context,
              pt: 'Preferencias',
              en: 'Preferences',
              es: 'Preferencias',
            ),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: colors.outline.withValues(alpha: 0.14),
              ),
            ),
            child: Obx(() {
              final selectedLocale = controller.currentLocale.value;

              return ListTile(
                key: const Key('language-selector-tile'),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                leading: Icon(
                  Icons.language_rounded,
                  color: colors.primary,
                ),
                title: Text(
                  _copy(
                    context,
                    pt: 'Idioma',
                    en: 'Language',
                    es: 'Idioma',
                  ),
                ),
                subtitle: Text(
                  controller.localeService.languageName(selectedLocale),
                ),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => _openLanguageSelector(context),
              );
            }),
          ),
        ],
      ),
    );
  }

  Future<void> _openLanguageSelector(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: Obx(() {
                final selectedCode = controller.currentLocale.value.languageCode;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      _copy(
                        context,
                        pt: 'Escolha o idioma do app',
                        en: 'Choose the app language',
                        es: 'Elige el idioma de la app',
                      ),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      _copy(
                        context,
                        pt: 'A mudanca e aplicada na hora.',
                        en: 'The change is applied immediately.',
                        es: 'El cambio se aplica al instante.',
                      ),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    ...AppLocaleService.supportedOptions.map((option) {
                      final isSelected =
                          option.locale.languageCode == selectedCode;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: ListTile(
                          key: Key(
                            'language-option-${option.locale.languageCode}',
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: BorderSide(
                              color: isSelected
                                  ? colors.primary
                                  : colors.outline.withValues(alpha: 0.14),
                            ),
                          ),
                          tileColor: isSelected
                              ? colors.primary.withValues(alpha: 0.08)
                              : colors.surface,
                          title: Text(option.nativeLabel),
                          trailing: isSelected
                              ? Icon(
                                  Icons.check_circle_rounded,
                                  color: colors.primary,
                                )
                              : null,
                          onTap: () async {
                            await controller.changeLocale(option.locale);

                            if (sheetContext.mounted) {
                              Navigator.of(sheetContext).pop();
                            }
                          },
                        ),
                      );
                    }),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }

  String _copy(
    BuildContext context, {
    required String pt,
    required String en,
    required String es,
  }) {
    switch (Localizations.localeOf(context).languageCode) {
      case 'en':
        return en;
      case 'es':
        return es;
      default:
        return pt;
    }
  }
}
