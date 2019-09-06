
main() {
  var a; // here we didn’t initialized var so its type is the special dynamic
  a = 1; // now a is a int
  a = "a"; // and now a String
  print(a is int); // prints false
  print(a is String); // prints true
  print(a is dynamic); // prints true
  print(a.runtimeType); // prints String
}
