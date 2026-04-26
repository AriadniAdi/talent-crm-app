import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/design/design.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/locale/app_locale_service.dart';
import 'package:talent_crm_app/core/pages/base_page.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/core/widgets/error_state_widget.dart';
import 'package:talent_crm_app/features/account/presentation/account_controller.dart';
import 'package:talent_crm_app/features/auth/entities/user_model.dart';

class AccountPage extends GetView<AccountController> {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BasePage(
      key: const Key('account-page'),
      title: Text(_copy(context, pt: 'Conta', en: 'Account', es: 'Cuenta')),
      child: Obx(() {
        if (controller.isLoading.value &&
            controller.currentUser.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final error = controller.screenError.value;
        if (error != null && controller.currentUser.value == null) {
          return ErrorStateWidget(
            message: _errorMessage(context, error),
            onRetry: controller.loadProfile,
          );
        }

        final user = controller.currentUser.value;
        if (user == null) {
          return ErrorStateWidget(
            message: _copy(
              context,
              pt: 'Não foi possível carregar seus dados.',
              en: 'We could not load your data.',
              es: 'No pudimos cargar tus datos.',
            ),
            onRetry: controller.loadProfile,
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SectionTitle(
                text: _copy(
                  context,
                  pt: 'Perfil',
                  en: 'Profile',
                  es: 'Perfil',
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Container(
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: colors.outline.withValues(alpha: 0.14),
                  ),
                ),
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor:
                              colors.primary.withValues(alpha: 0.1),
                          child: Text(
                            _initials(user.name),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: colors.primary,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user.email,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _ProfileInfoRow(
                      label: _copy(
                        context,
                        pt: 'Telefone',
                        en: 'Phone',
                        es: 'Teléfono',
                      ),
                      value: _displayValue(
                        user.phone,
                        context,
                        fallbackPt: 'Sem telefone cadastrado',
                        fallbackEn: 'No phone number added',
                        fallbackEs: 'Sin teléfono registrado',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _ProfileInfoRow(
                      label: _copy(
                        context,
                        pt: 'Bio',
                        en: 'Bio',
                        es: 'Bio',
                      ),
                      value: _displayValue(
                        user.bio,
                        context,
                        fallbackPt: 'Nenhuma bio adicionada ainda',
                        fallbackEn: 'No bio added yet',
                        fallbackEs: 'Aún no hay bio agregada',
                      ),
                      maxLines: 5,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Obx(
                      () => AppPrimaryButton(
                        label: _copy(
                          context,
                          pt: 'Editar perfil',
                          en: 'Edit profile',
                          es: 'Editar perfil',
                        ),
                        isLoading: controller.isSaving.value,
                        onPressed: () => _openProfileEditor(context, user),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
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
      }),
    );
  }

  Future<void> _openProfileEditor(BuildContext context, UserModel user) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) {
        return _ProfileEditorSheet(
          controller: controller,
          user: user,
        );
      },
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
                final selectedCode =
                    controller.currentLocale.value.languageCode;

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

  String _displayValue(
    String? value,
    BuildContext context, {
    required String fallbackPt,
    required String fallbackEn,
    required String fallbackEs,
  }) {
    final text = value?.trim();
    if (text == null || text.isEmpty) {
      return _copy(
        context,
        pt: fallbackPt,
        en: fallbackEn,
        es: fallbackEs,
      );
    }

    return text;
  }

  String _initials(String name) {
    final parts =
        name.trim().split(RegExp(r'\s+')).where((item) => item.isNotEmpty);
    final initials = parts.take(2).map((part) => part[0]).join();
    return initials.isEmpty ? '?' : initials.toUpperCase();
  }

  String _errorMessage(BuildContext context, AppError error) {
    return switch (error) {
      NotFoundError() => _copy(
          context,
          pt: 'Perfil não encontrado.',
          en: 'Profile not found.',
          es: 'Perfil no encontrado.',
        ),
      InvalidRouteError() => _copy(
          context,
          pt: 'A rota da conta está inválida.',
          en: 'The account route is invalid.',
          es: 'La ruta de la cuenta no es válida.',
        ),
      _ => _copy(
          context,
          pt: 'Não foi possível carregar este perfil.',
          en: 'We could not load this profile.',
          es: 'No pudimos cargar este perfil.',
        ),
    };
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

class _ProfileEditorSheet extends StatefulWidget {
  final AccountController controller;
  final UserModel user;

  const _ProfileEditorSheet({
    required this.controller,
    required this.user,
  });

  @override
  State<_ProfileEditorSheet> createState() => _ProfileEditorSheetState();
}

class _ProfileEditorSheetState extends State<_ProfileEditorSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _phoneController = TextEditingController(text: widget.user.phone ?? '');
    _bioController = TextEditingController(text: widget.user.bio ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 8, 20, 20 + bottomInset),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _copy(
                context,
                pt: 'Editar perfil',
                en: 'Edit profile',
                es: 'Editar perfil',
              ),
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _copy(
                context,
                pt: 'Atualize seu nome, telefone e bio.',
                en: 'Update your name, phone number and bio.',
                es: 'Actualiza tu nombre, teléfono y bio.',
              ),
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _SheetField(
              label: _copy(
                context,
                pt: 'Nome',
                en: 'Name',
                es: 'Nombre',
              ),
              controller: _nameController,
              hintText: _copy(
                context,
                pt: 'Seu nome',
                en: 'Your name',
                es: 'Tu nombre',
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _SheetField(
              label: _copy(
                context,
                pt: 'Telefone',
                en: 'Phone',
                es: 'Teléfono',
              ),
              controller: _phoneController,
              hintText: _copy(
                context,
                pt: 'Ex: (11) 98888-7777',
                en: 'e.g. +55 11 98888-7777',
                es: 'p. ej. +55 11 98888-7777',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: AppSpacing.md),
            _SheetField(
              label: _copy(
                context,
                pt: 'Bio',
                en: 'Bio',
                es: 'Bio',
              ),
              controller: _bioController,
              hintText: _copy(
                context,
                pt: 'Conte um pouco sobre você',
                en: 'Tell us a little about yourself',
                es: 'Cuéntanos un poco sobre ti',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: AppSpacing.lg),
            Obx(
              () => AppPrimaryButton(
                label: _copy(
                  context,
                  pt: 'Salvar alterações',
                  en: 'Save changes',
                  es: 'Guardar cambios',
                ),
                isLoading: widget.controller.isSaving.value,
                onPressed: _submit,
              ),
            ),
            const SizedBox(height: 8),
            Obx(
              () => TextButton(
                onPressed: widget.controller.isSaving.value
                    ? null
                    : () => Navigator.of(context).pop(),
                child: Text(
                  _copy(
                    context,
                    pt: 'Cancelar',
                    en: 'Cancel',
                    es: 'Cancelar',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final context = this.context;
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      _showMessage(
        context,
        _copy(
          context,
          pt: 'O nome não pode ficar vazio.',
          en: 'Name cannot be empty.',
          es: 'El nombre no puede estar vacío.',
        ),
      );
      return;
    }

    final result = await widget.controller.saveProfile(
      name: name,
      phone: _phoneController.text,
      bio: _bioController.text,
    );

    result.when(
      success: (_) {
        if (!mounted) {
          return;
        }

        final messenger = ScaffoldMessenger.of(context);
        Navigator.of(context).pop();
        messenger.showSnackBar(
          SnackBar(
            content: Text(
              _copy(
                context,
                pt: 'Perfil atualizado.',
                en: 'Profile updated.',
                es: 'Perfil actualizado.',
              ),
            ),
          ),
        );
      },
      failure: (error) {
        _showMessage(context, _sheetErrorMessage(context, error));
      },
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  String _sheetErrorMessage(BuildContext context, AppError error) {
    return switch (error) {
      NotFoundError() => _copy(
          context,
          pt: 'Não foi possível encontrar o perfil.',
          en: 'Could not find the profile.',
          es: 'No se pudo encontrar el perfil.',
        ),
      _ => _copy(
          context,
          pt: 'Não foi possível salvar as alterações.',
          en: 'We could not save the changes.',
          es: 'No pudimos guardar los cambios.',
        ),
    };
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

class _SheetField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final int maxLines;

  const _SheetField({
    required this.label,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          minLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: colors.surface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(
                color: colors.outline.withValues(alpha: 0.16),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(
                color: colors.outline.withValues(alpha: 0.16),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(
                color: colors.primary.withValues(alpha: 0.35),
                width: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final int maxLines;

  const _ProfileInfoRow({
    required this.label,
    required this.value,
    this.maxLines = 2,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.35,
                ),
          ),
        ],
      ),
    );
  }
}
