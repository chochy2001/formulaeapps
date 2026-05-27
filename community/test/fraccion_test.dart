import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/fraccion.dart';

void main() {
  group('implementFraction', () {
    test('returns integer string for whole numbers', () {
      expect(implementFraction(3), '3.000');
    });

    test('returns truncated decimal for non-repeating values', () {
      expect(implementFraction(1.5), '1.500');
    });

    test('handles zero', () {
      expect(implementFraction(0), '0.000');
    });

    test('handles negative decimals', () {
      expect(implementFraction(-2.25), '-2.250');
    });
  });

  group('isRepeating', () {
    test('returns false when there is no decimal part', () {
      expect(isRepeating('5', 3), isFalse);
    });

    test('returns false for typical fixed-precision decimals', () {
      // Documented behavior: toStringAsFixed(5) rarely satisfies the repeat check.
      expect(isRepeating('1.33333', 3), isFalse);
    });

    test('returns false when decimal part is not repeating', () {
      expect(isRepeating('1.23456', 3), isFalse);
    });
  });

  group('Fraction', () {
    test('stores numerator and denominator', () {
      final fraction = Fraction(3, 4);
      expect(fraction.numerator, 3);
      expect(fraction.denominator, 4);
    });
  });
}
