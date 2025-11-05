import 'package:cred_assignment_by_shubham_puhal/core/extensions/string_to_color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test HexColorExtension', () {
    test('should convert 6-digit hex code to Color correctly', () {
      const hex = '#FF0000';
      final color = hex.toColor();
      expect(color, const Color(0xFFFF0000));
    });

    test('should convert 8-digit hex code (including alpha) correctly', () {
      const hex = '#80FF0000';
      final color = hex.toColor();
      expect(color, const Color(0x80FF0000));
    });

    test('should handle hex code without #', () {
      const hex = '00FF00';
      final color = hex.toColor();
      expect(color, const Color(0xFF00FF00));
    });

    test('should prefix FF for 6-digit hex without alpha', () {
      const hex = '#0000FF';
      final color = hex.toColor();
      expect(color, const Color(0xFF0000FF));
    });
  });
}
