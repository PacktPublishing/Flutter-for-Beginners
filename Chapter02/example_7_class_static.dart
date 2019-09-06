/**
 * Class static members example
 */
class Person {
  static String personLabel = "Person name:";

  String firstName;
  String lastName;

  String get fullName => "$personLabel $firstName $lastName";
  
  Person(this.firstName, this.lastName);

  static void printsPerson(Person person) {
    print("$personLabel ${person.firstName} ${person.lastName}");
  }
}

main() {
  Person somePerson = Person("clark", "kent");
  Person anotherPerson  = Person("peter", "parker");

  print(somePerson.fullName); // prints Person name: clark kent
  print(anotherPerson.fullName); // prints Person name: peter parker

  Person.personLabel = "name:";

  print(somePerson.fullName); // prints name: clark kent
  print(anotherPerson.fullName); // prints name: peter park

  Person.printsPerson(somePerson); // prints name: clark kent
  Person.printsPerson(anotherPerson); // prints name: peter park
}
