import 'package:meta/meta.dart';

/**
 * Functions required named parameters
 */
sayHello(String name, {@required String additionalMessage}) =>
    "Hello $name. $additionalMessage";

void main() {
  var hello = sayHello('my friend',
      additionalMessage:
          "How are you?"); // not specifying the parameter name will result in
// a hint on the editor, or by running dartanalyzer
// manually on console
  print(hello);
}
