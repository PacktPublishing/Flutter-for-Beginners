/**
 * This is another library.
 * It does not define anything but the main function and
 * uses the person_lib/person_library library.
 */

import 'person_lib/person_library.dart';

main() {
  // we can access the Programmer class as it is part of the person_library
  Programmer programmer = Programmer(firstName: "Dean", lastName: "Pugh");

  // again, we cannot access the _type property as it is private to the person library
  // programmer._type = PersonType.employee;

  print(programmer);
}
