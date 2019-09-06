/**
 * programmer part of person libary definition
 */
import 'person_library.dart';

class Programmer extends Person {
  Programmer({firstName, lastName})
      : super(
          firstName: firstName,
          lastName: lastName,
          type: PersonType.employee,
        );
}
