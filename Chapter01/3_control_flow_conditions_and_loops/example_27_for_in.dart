/**
 * for in
 */
void main() {
  var list = [1, 2, 3, 4];
  for (var number in list) {
    print('hello $number');
  }

  list.forEach((number) => print('hello $number'));
}
