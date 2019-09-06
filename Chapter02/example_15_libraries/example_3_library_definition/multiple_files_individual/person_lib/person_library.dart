/**
 * Person libary definition
 */
export 'programmer.dart';
export 'student.dart';

class Person {
  String firstName;
  String lastName;
  final PersonType type;

  Person({this.firstName, this.lastName, this.type});

  String toString() => "($type): $firstName $lastName";
}

enum PersonType { student, employee }