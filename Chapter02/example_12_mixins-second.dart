/**
 * mixins example
 */
class Person {
  String firstName;
  String lastName;


  Person({this.firstName, this.lastName});

  String get fullName => "$firstName $lastName";
}

// Mixins limited by the 'on' keyword requires the target class to
// have an no arguments constructor. 
// At the moment this book is being written, the mixin syntax is new and may have changed when you are reading it
class Developer extends Person {
  Developer({firstName, lastName})
      : super(firstName: firstName, lastName: lastName);
}

mixin ProgrammingSkills on Developer {
  coding() {
    print("writing code...");
  }
}

mixin ManagementSkills on Developer {
  manage() {
    print("managing project...");
  }
}

// this code does not compile as ProgrammingSkills is a mixin and not a class
// class AdvancedProgrammingSkills extends ProgrammingSkills {
//   makingCoffe() {
//     print("making coffe...");
//   }
// }

class SeniorDeveloper extends Developer
    with ProgrammingSkills, ManagementSkills {
  SeniorDeveloper({String firstName, String lastName})
      : super(firstName: firstName, lastName: lastName);
}

class JuniorDeveloper extends Developer with ProgrammingSkills {}

main() {
  var p = new SeniorDeveloper(firstName: "clark", lastName: "kent");
  p.coding();
}
