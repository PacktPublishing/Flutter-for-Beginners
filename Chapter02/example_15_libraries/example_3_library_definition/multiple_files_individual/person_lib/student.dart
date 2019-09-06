/**
 * student part of person libary definition
 */
import 'person_library.dart';

class Student extends Person {
  Student({firstName, lastName})
      : super(
          firstName: firstName,
          lastName: lastName,
          type: PersonType.student,
        );
}
