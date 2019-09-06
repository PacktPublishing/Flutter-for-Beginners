/**
 * if else statement
 */
main() {
  var isItABug = "It’s a bug.";

  // doesn't compile with error: Conditions must have a static type of 'bool'.
  if (isItABug) {
    print("It’s a bug.");
  } else {
    print("It’s not a bug. It’s an undocumented feature!");
  }

  // This works as it evaluates the expression and isItABug is not null
  if (isItABug != null) {
    print("It’s a bug.");
  } else {
    print("It’s not a bug. It’s an undocumented feature!");
  }
}
