/** 
 * type checking operators
 */
main() {
    num number = 3;

    print(number is int);      // prints 3
    print(number is! String);  // prints true
    print(number is String);   // prints false
    print(number is double);   // prints false
    print(number is int);      // prints true
    print(number is num);      // prints true

    print(number as int);      // prints 3
}