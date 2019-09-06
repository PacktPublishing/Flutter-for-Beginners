import 'package:test/test.dart';
import 'package:unit_tests/calculator.dart';

void main() {
  Calculator calculator;

  setUp(() {
    calculator = Calculator();
  });
  group("sum tests", () {
    test('calculator sumTwoNumbers() sum the both numbers', () {
      expect(calculator.sumTwoNumbers(1, 2), 3);
    });
    test('calculator sumTwoNumbers() sum null as it was 0', () {
      expect(calculator.sumTwoNumbers(1, null), 1);
    });
  });
}
