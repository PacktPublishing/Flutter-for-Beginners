/**
 * Classes example
 */
class Person {
    String fisrtName;
    String lastName;

    String getFullName() => "$fisrtName $lastName";
}

main() {
  Person somePerson = new Person()
    ..fisrtName = "Clark"
    ..lastName = "Kent";
  
  print(somePerson.getFullName());
}