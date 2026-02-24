import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/core/design/painters/dotted_background_painter.dart';

void main() {
  group('DottedBackgroundPainter', () {
    test('shouldRepaint returns false', () {
      final painter1 =
          DottedBackgroundPainter(dotColor: const Color(0xFF000000));
      final painter2 =
          DottedBackgroundPainter(dotColor: const Color(0xFFFFFFFF));

      expect(painter1.shouldRepaint(painter2), false);
    });
  });

  test('paint does not throw', () {
    final painter = DottedBackgroundPainter(dotColor: const Color(0xFF000000));

    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    const size = Size(200, 200);

    expect(() => painter.paint(canvas, size), returnsNormally);
  });
}
