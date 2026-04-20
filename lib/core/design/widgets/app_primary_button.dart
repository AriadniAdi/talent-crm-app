import 'package:flutter/material.dart';

/// Botão primário padrão do projeto.
///
/// Encapsula o padrão recorrente de [ElevatedButton] com altura fixa de 58px
/// e suporte nativo a estado de carregamento via [CircularProgressIndicator].
///
/// Uso básico:
/// ```dart
/// AppPrimaryButton(
///   label: 'Entrar',
///   onPressed: _handleLogin,
/// )
/// ```
///
/// Com estado de carregamento:
/// ```dart
/// AppPrimaryButton(
///   label: 'Entrar',
///   isLoading: controller.isLoading,
///   onPressed: controller.signIn,
/// )
/// ```
class AppPrimaryButton extends StatelessWidget {
  /// Texto exibido no botão quando não está carregando.
  final String label;

  /// Callback chamado ao pressionar o botão.
  /// Quando [isLoading] é `true`, o botão é desabilitado independente deste valor.
  final VoidCallback? onPressed;

  /// Quando `true`, exibe um [CircularProgressIndicator] e desabilita o botão.
  final bool isLoading;

  /// Altura do botão. Padrão: 58.
  final double height;

  /// Estilo opcional para sobrescrever o estilo padrão do tema.
  /// Útil para variantes (ex: botão invertido sobre banners coloridos).
  final ButtonStyle? style;

  /// Chave semântica para testes.
  final Key? buttonKey;

  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.height = 58,
    this.style,
    this.buttonKey,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        key: buttonKey,
        style: style,
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(label),
      ),
    );
  }
}
