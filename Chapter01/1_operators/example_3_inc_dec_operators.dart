/** 
 * infix prefix and postfix increment and decrement
 */
main() {
  var number = 10;

  print(number++); // prints 10 then number becomes 11
  print(++number); // number becomes 12 then prints it

  print(number--); // prints 12 then number becomes 11
  print(11 + --number); // number becomes 10 then prints 10
}
