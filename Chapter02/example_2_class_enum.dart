/**
 * Classes enum example
 */
class Person {
    String fisrtName;
    String lastName;
    PersonType type;

    String getFullName() => "$fisrtName $lastName";
}

enum PersonType {
  student, employee
}

main() {
  print(PersonType.values); // prints [PersonType.student, PersonType.employee]

  Person somePerson = new Person();
  somePerson.type = PersonType.employee;
  
  print(somePerson.type); // prints PersonType.employee
  print(somePerson.type.index); // prints 1  
}