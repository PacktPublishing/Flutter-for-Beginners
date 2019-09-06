/**
 * Class accessors example
 */
class Person {
  String firstName;
  String lastName;

  Person(this.firstName, this.lastName);

  Person.anonymous() {}

  String get fullName => "$firstName $lastName";
  
  String get initials => "${firstName[0]}. ${lastName[0]}.";
  
  // uncomment this if you wanna test the setter
  // set fullName(String fullName) {
  //   var parts = fullName.split(" ");
  //   this.firstName = parts.first;
  //   this.lastName = parts.last;
  // }
}

main() {
  Person somePerson = Person("clark", "kent");

  print(somePerson.fullName);
  print(somePerson.initials);

  // somePerson.fullName = "peter parker"; // compile error / uncomment the fullName setter above if you want
}
