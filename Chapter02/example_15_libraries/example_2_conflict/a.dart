/**
 * this is a Dart library
 */
class Person {
  String firstName;
  String lastName;

  Person([this.firstName, this.lastName]);

  String get fullName => "$firstName $lastName";
}