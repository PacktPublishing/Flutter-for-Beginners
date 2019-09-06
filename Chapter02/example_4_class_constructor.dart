/**
 * Class constructor example
 */
class Person {
  String firstName;
  String lastName;

  Person(String firstName, String lastName) {
    this.firstName = firstName;
    this.lastName = lastName;
  }
  // the same as:
  // Person(this.firstName, this.lastName);

  Person.anonymous() {}

  String getFullName() => "$firstName $lastName";
}

main() {
  // Person somePerson = new Person(); would not compile as we defined mandatory parameters on constructor
  Person somePerson = new Person("Clark", "Kent");

  print(somePerson.getFullName());
}
