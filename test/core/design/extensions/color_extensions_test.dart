import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/core/design/extensions/color_extensions.dart';

void main() {
  group('ColorHex extension', () {
    test('returns hex with leading hash by default', () {
      const color = Color(0xFF5E4AE3);

      final hex = color.toHex();

      expect(hex, '#5e4ae3');
    });

    test('returns hex without leading hash when specified', () {
      const color = Color(0xFF5E4AE3);

      final hex = color.toHex(leadingHash: false);

      expect(hex, '5e4ae3');
    });

    test('correctly converts black', () {
      const color = Color(0xFF000000);

      expect(color.toHex(), '#000000');
    });

    test('correctly converts white', () {
      const color = Color(0xFFFFFFFF);

      expect(color.toHex(), '#ffffff');
    });

    test('values are clamped between 0 and 255', () {
      const color = Color.fromRGBO(255, 255, 255, 1);

      expect(color.toHex(), '#ffffff');
    });
  });
}
