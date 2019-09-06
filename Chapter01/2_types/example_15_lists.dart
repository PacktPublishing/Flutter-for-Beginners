/**
 * lists
 */
main() {
  var someList = [1, 2, 3]; // you can instantiate an empty list by using [] syntax

  print(someList[1]); // prints(2)

  var anotherList = [4, 5];
  anotherList.add(6);
  
  print(someList + anotherList); // prints [1, 2, 3, 4, 5, 6]

}
