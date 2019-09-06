/**
 * abstract classes example
 */
abstract class Person {
  String firstName;
  String lastName;

  Person(this.firstName, this.lastName);

  String get fullName;
}

class Student extends Person {
  String nickName;

  Student(String firstName, String lastName, this.nickName)
      : super(firstName, lastName);

  @override
  String get fullName => "$firstName $lastName";

  @override
  String toString() => "$fullName, also known as $nickName";
}

main() {
  Person student = new Student("Clark", "Kent", "Kal-El"); // works as we are instantiating the subtype
   
   // Person p = new Person(); 
   // abstract classes cannot be instantiated

  print(student); 
}
