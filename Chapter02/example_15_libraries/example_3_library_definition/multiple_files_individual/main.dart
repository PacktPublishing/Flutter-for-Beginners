/**
 * This is another library.
 * It does not define anything but the main function and
 * uses the person_lib/programmer and student libraries.
 */

import 'person_lib/person_library.dart';

main() {
  // we can access the Programmer and Student class as they are exported from the person_library
  Programmer programmer = Programmer(firstName: "Dean", lastName: "Pugh");
  Student student = Student(firstName: "Dilo", lastName: "Pugh");

  print(programmer);
  print(student);
}
