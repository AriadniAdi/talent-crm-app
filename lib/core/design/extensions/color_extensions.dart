import 'package:flutter/material.dart';

extension ColorHex on Color {
  String toHex({bool leadingHash = true}) {
    final r = (this.r * 255).round().clamp(0, 255);
    final g = (this.g * 255).round().clamp(0, 255);
    final b = (this.b * 255).round().clamp(0, 255);

    final hex = '${r.toRadixString(16).padLeft(2, '0')}'
        '${g.toRadixString(16).padLeft(2, '0')}'
        '${b.toRadixString(16).padLeft(2, '0')}';

    return leadingHash ? '#$hex' : hex;
  }
}
