/**
 * Functions mandatory parameters
 */
sayHello(String name, String additionalMessage) => "Hello $name. $additionalMessage";

void main() {
  var hello = sayHello("world", "Yeah"); //you need to provide both arguments to the function
  print(hello);
}
