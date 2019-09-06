/**
 * Arithmetic operators
 */
main() {
  var someNumber,
      otherNumber; // you can declare multiple variables on the same line
  var total;

  someNumber = 15;
  otherNumber = 2;

  total = someNumber + otherNumber; // Addition operator, total is 17
  print(total);

  total = someNumber - otherNumber; // Substraction operator, total is 13
  print(total);

  total = someNumber * otherNumber; // Multiplication operator, total is 30
  print(total);

  total = someNumber / otherNumber; // Division operator, total is 7.5
  print(total);

  total = someNumber ~/ otherNumber; // Integer division operator, total is 7
  print(total);

  total = someNumber % otherNumber; // Modulo operator, total is 1
  print(total);

  total = -someNumber; // Multiplication operator, total is -15
  print(total);
}
