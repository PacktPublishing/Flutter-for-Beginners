/**
 * Functions optional parameter
 */
sayHello(String name, [String additionalMessage]) => "Hello $name. $additionalMessage";

void main() {
  print(sayHello('my friend')); // prints: Hello my friend. null
  print(sayHello('my friend', "How are you?")); // prints: Hello my friend. How are you?
}
