/**
 * importing the person_lib.dart
 */
import 'a.dart' as libraryA;
import 'b.dart' as libraryB;
void main() {

  libraryA.Person personA = libraryA.Person("Clark", "Kent");

  print("Person A: ${personA.fullName}");

  libraryB.Person personB = libraryB.Person(); // 'b' Perosn does not have any field  
  print("Person B: ${personB}");
}