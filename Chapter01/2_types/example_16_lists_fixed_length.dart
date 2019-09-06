/**
 * Fixed length lists
 */
main() {
  var someList = List(3);

  print(someList); // prints [null, null, null]

  someList[1] = 2;
  print(someList); // prints [null, 2, null]

  someList.add(1); // exception as it is a fixed length list
}