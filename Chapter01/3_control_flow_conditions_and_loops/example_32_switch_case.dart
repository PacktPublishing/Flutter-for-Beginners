/**
 * switch-case
 */
void main() {
  var yearsOfProgramming = 11;

  switch (yearsOfProgramming) {
    case 0:
      print("Do you want to be a Jedi?");
      break;
    case 1:
    case 2:
    case 3:
      print("Youngling!");
      break;
    case 4:
    case 5:
      print("Padawan!");
      break;
    case 6:
    case 7:
    case 8:
    case 9:
    case 10:
      print("Jedi Knight!");
      break;
    default:
      print("Jedi Master!");
      break;
  }
}
