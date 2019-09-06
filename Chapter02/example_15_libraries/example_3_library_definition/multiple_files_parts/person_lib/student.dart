/**
 * student part of person libary definition
 */

part of person;

class Student extends Person {
  Student({firstName, lastName})
      : super(firstName: firstName, lastName: lastName) {
    _type = PersonType.student;
  }
}