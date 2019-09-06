import 'package:meta/meta.dart';

/**
 * Anonymous Functions
 */
void main() {
  var list = [1, 2, 3, 4];
  list.forEach((number) => print(
      'hello $number')); // our anonymous function receives an item but doesn't specify a type,
// and just prints the value received by parameter.
}
