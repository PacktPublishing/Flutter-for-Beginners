/**
 * switch-case vs if-else
 */

void main() {
  var yearsOfProgramming = 0;

  if (yearsOfProgramming == 0) {
    print("Do you want to be a Jedi?");
  } else if (yearsOfProgramming <= 3) {
    print("Youngling!");
  } else if (yearsOfProgramming <= 5) {
    print("Padawan!");
  } else if (yearsOfProgramming <= 10) {
    print("Jedi Knight!");
  } else {
    print("Jedi Master!");
  }
}
