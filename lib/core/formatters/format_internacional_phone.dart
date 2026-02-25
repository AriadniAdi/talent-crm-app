String formatInternationalPhone(String input) {
  if (input.isEmpty) return '';

  final extMatch = RegExp(r'[xX]\s?(\d+)').firstMatch(input);
  final extension = extMatch?.group(1);

  // remove extensão do número base
  String base = input.replaceAll(RegExp(r'[xX]\s?\d+'), '').trim();

  // remove espaços duplicados
  base = base.replaceAll(RegExp(r'\s+'), ' ');

  if (extension != null) {
    return '$base • ext. $extension';
  }

  return base;
}
