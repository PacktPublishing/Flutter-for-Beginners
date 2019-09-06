/**
 * Classes example
 */
class Person {
    String fisrtName;
    String lastName;

    String getFullName() => "$fisrtName $lastName";
}

main() {
  Person somePerson = new Person();
  somePerson.fisrtName = "Clark";
  somePerson.lastName = "Kent";
  
  print(somePerson.getFullName());
}