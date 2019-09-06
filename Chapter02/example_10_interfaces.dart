/**
 * interfaces example
 */
abstract class Person {
  String firstName;
  String lastName;

  Person(this.firstName, this.lastName);

  String get fullName;
}

class Student implements Person {
  String nickName;

  @override
  String firstName;

  @override
  String lastName;

  Student(this.firstName, this.lastName, this.nickName);

  @override
  String get fullName => "$firstName $lastName";

  @override
  String toString() => "$fullName, also known as $nickName";
}

main() {
  Person student = new Student("Clark", "Kent", "Kal-El");   

  print(student); 
}
