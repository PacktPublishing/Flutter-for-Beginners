/**
 * Top-level functions and variables
 */

var globalNumber = 100;
final globalFinalNumber = 1000;

void printHello() {
  print("""Dart from global scope.
    This is a top-level number: $globalNumber
    This is a top-level final number: $globalFinalNumber
    """);
}

main() {
  // the most famous Dart top level function
  printHello(); // prints the default value

  globalNumber = 0;
  // globalFinalNumber = 0; // does not compile as this is a final variable

  printHello(); // prints the new value
}
