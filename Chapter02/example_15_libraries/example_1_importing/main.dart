/**
 * importing the person_lib.dart
 */
import 'person_lib.dart';
// import 'person_lib.dart' show Person, Student;
// import 'person_lib.dart' hide Employee;

void main() {

  Person person = Person("Clark", "Kent");
  Person student = Student("Clark", "Kent");

  print("Person: ${person.fullName}, type: ${person.type}");
  print("Student: ${student.fullName}, type: ${student.type}");
}