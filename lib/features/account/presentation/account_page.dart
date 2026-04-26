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
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.xxl),
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileSection(context),
            const SizedBox(height: AppSpacing.xl),
            _buildPreferencesSection(context, colors),
            const SizedBox(height: AppSpacing.xxl),
          ],
        );
      }),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colors.outline.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: colors.primaryContainer,
                child: Text(
                  controller.currentUser.value?.name.isNotEmpty == true
                      ? controller.currentUser.value!.name[0].toUpperCase()
                      : "A",
                  style: TextStyle(
                    color: colors.onPrimaryContainer,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _copy(context, pt: 'Editar Perfil', en: 'Edit Profile', es: 'Editar Perfil'),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    if (controller.currentUser.value?.email != null)
                      Text(
                        controller.currentUser.value!.email,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          _buildTextField(
            context,
            controller: controller.nameController,
            label: _copy(context, pt: 'Nome Completo', en: 'Full Name', es: 'Nombre Completo'),
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: AppSpacing.md),
          _buildTextField(
            context,
            controller: controller.phoneController,
            label: _copy(context, pt: 'Telefone', en: 'Phone', es: 'Teléfono'),
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: AppSpacing.md),
          _buildTextField(
            context,
            controller: controller.bioController,
            label: _copy(context, pt: 'Bio', en: 'Bio', es: 'Bio'),
            icon: Icons.info_outline_rounded,
            maxLines: 4,
            hint: _copy(context, pt: 'Conte-nos um pouco sobre você...', en: 'Tell us about yourself...', es: 'Cuéntanos sobre ti...'),
          ),
          const SizedBox(height: AppSpacing.xl),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: controller.isSaving.value ? null : controller.saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: colors.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: controller.isSaving.value
                  ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: colors.onPrimary,
                      ),
                    )
                  : Text(
                      _copy(context, pt: 'Salvar Alterações', en: 'Save Changes', es: 'Guardar Cambios'),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? hint,
  }) {
    final colors = Theme.of(context).colorScheme;

    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: maxLines == 1
            ? Icon(icon, color: colors.primary.withOpacity(0.7))
            : Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: Icon(icon, color: colors.primary.withOpacity(0.7)),
              ),
        filled: true,
        fillColor: colors.surfaceContainerHighest.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colors.outline.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colors.outline.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.all(AppSpacing.lg),
      ),
    );
  }

  Widget _buildPreferencesSection(BuildContext context, ColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          _copy(
            context,
            pt: 'Preferências',
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
              color: colors.outline.withOpacity(0.14),
            ),
          ),
          child: ListTile(
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
              controller.localeService.languageName(controller.currentLocale.value),
            ),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => _openLanguageSelector(context),
          ),
        ),
      ],
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
                        pt: 'A mudança é aplicada na hora.',
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
                                  : colors.outline.withOpacity(0.14),
                            ),
                          ),
                          tileColor: isSelected
                              ? colors.primary.withOpacity(0.08)
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
