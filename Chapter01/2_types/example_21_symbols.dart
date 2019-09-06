import 'dart:mirrors';

/**
 * Symbols
 */
main() {
  int someInt = 1;
  print(reflect(someInt).type.reflectedType.toString()); // prints: int
}
