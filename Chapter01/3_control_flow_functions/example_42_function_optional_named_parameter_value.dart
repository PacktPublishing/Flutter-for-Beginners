/**
 * Functions optional named parameters
 */
sayHello(String name, {String additionalMessage}) => "Hello $name. $additionalMessage";

void main() {
  print(sayHello('my friend')); // it stills optional, prints: Hello my friend. null
  print(sayHello('my friend', additionalMessage: "How are you?")); // prints: Hello my friend. How are you?
}
