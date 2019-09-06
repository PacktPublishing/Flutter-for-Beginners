/**
 * Number types
 */
main() {
  int simpleNumber = 100;
  print(simpleNumber);
  
  int hexNumber = 0x64; // same values as simpleNumber = 100
  print(hexNumber);

  double simpleFractional = 0.0001;
  print(simpleFractional);

  double expFractional = 1e-4; // same value as simpleFractional = 0.0001
  print(expFractional);

  // You can change the print format
  print(simpleNumber.toRadixString(16)); // prints the "hexadecimal" representation of 100(decimal).

  print(simpleFractional.toStringAsExponential()); // prints the "exponential" representation of 0.0001(fractional).

  
}
