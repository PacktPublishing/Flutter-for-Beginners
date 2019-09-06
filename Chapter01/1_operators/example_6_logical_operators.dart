/** 
 * type checking operators
 */
main() {
    num numberA = 1;
    num numberB = 2;

    print(numberA > 1);                 // prints false
    print(!(numberA > 1));              // prints true
    print(numberA > 1 || numberB > 1);  // prints true
    print(numberA > 1 && numberB > 1);  // prints false 
}