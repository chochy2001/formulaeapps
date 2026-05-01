import 'dart:math';

class Fraction {
  num numerator;
  num denominator;

  Fraction(this.numerator, this.denominator);
}

bool isRepeating(String decimalString, int tolerance) {
  List<String> parts = decimalString.split(".");
  if (parts.length < 2) {
    return false; // No hay parte decimal.
  }
  String decimalPart = parts[1];

  // Considera solo los primeros dígitos después del punto decimal.
  String fractionPart = decimalPart.length > tolerance
      ? decimalPart.substring(0, tolerance)
      : decimalPart;

  return decimalPart.replaceAll(fractionPart, "") == "";
}

String truncateNonRepeatingDecimal(num decimal, int tolerance) {
  return decimal.toStringAsFixed(tolerance);
}

Fraction? repeatingDecimalToFraction(num decimal, int tolerance) {
  int wholePart = decimal.floor();
  String decimalString = decimal.toStringAsFixed(5);

  if (!isRepeating(decimalString, tolerance)) {
    return null;
  }

  num numerator =
      (decimal * pow(10, tolerance)).round() - wholePart * pow(10, tolerance);
  num denominator = pow(10, tolerance) - 1;

  return Fraction(numerator + wholePart * denominator, denominator);
}

//Usar esta funcion para usarla en la App
String implementFraction(num decimal) {
  int tolerance =
      3; // Número de dígitos que se consideran para detectar la repetición.

  try {
    Fraction? fraction = repeatingDecimalToFraction(decimal, tolerance);

    if (fraction != null) {
      if (fraction.denominator == 1) {
        return '${fraction.numerator}';
      } else {
        return '${fraction.numerator}/${fraction.denominator}';
      }
    } else {
      return truncateNonRepeatingDecimal(decimal, tolerance);
    }
  } catch (e) {
    return e.toString();
  }
}
