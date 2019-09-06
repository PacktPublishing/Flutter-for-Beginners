/**
 * This is another library.
 * It does not define anything but the main function and
 * uses the single_file library.
 */
import 'single_file.dart';

main() {
  Programmer programmer = Programmer(firstName: "Dean", lastName: "Pugh");

  // we cannot access the _type property as it is private to the single_file library
  // programmer._type = PersonType.employee; 

  print(programmer);
}
