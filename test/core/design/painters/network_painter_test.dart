import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/core/design/painters/network_painter.dart';

void main() {
  group('NetworkPainter', () {
    test('shouldRepaint returns false', () {
      final painter1 = NetworkPainter(color: Colors.red);
      final painter2 = NetworkPainter(color: Colors.blue);

      expect(painter1.shouldRepaint(painter2), false);
    });

    test('paint does not throw for normal size', () {
      final painter = NetworkPainter(color: Colors.white);

      final recorder = PictureRecorder();
      final canvas = Canvas(recorder);
      const size = Size(200, 200);

      expect(() => painter.paint(canvas, size), returnsNormally);
    });

    test('paint does not throw for small size', () {
      final painter = NetworkPainter(color: Colors.white);

      final recorder = PictureRecorder();
      final canvas = Canvas(recorder);
      const size = Size(10, 10);

      expect(() => painter.paint(canvas, size), returnsNormally);
    });

    test('color is stored correctly', () {
      final painter = NetworkPainter(color: Colors.green);

      expect(painter.color, Colors.green);
    });
  });
}
