/**
 * Class inheritance example
 */
class Person {
  String firstName;
  String lastName;

  Person(this.firstName, this.lastName);

  String get fullName => "$firstName $lastName";
}

class Student extends Person {
  String nickName;

  Student(String firstName, String lastName, this.nickName)
      : super(firstName, lastName);

  @override
  String toString() => "$fullName, also known as $nickName";
}

main() {
  Student student = new Student("Clark", "Kent", "Kal-El");

  print(student); // same as calling student.toString()
  // prints Clark Kent, also known as Kal-El

  print("This is a student: $student"); 
  // will also call the toString() of student implicitly
}