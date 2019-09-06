/**
 * Functions default parameter values
 */
sayHello(String name, [String additionalMessage = "Wellcome to Dart Functions!" ]) => "Hello $name. $additionalMessage";

void main() {
  print(sayHello('my friend')); // prints: Hello my friend. Wellcome to Dart Functions!
}
