/**
 *  bits operators
 */
main() {
    var value = 10;  // 00001010
    var mask  = 0;   // 00000000
    // bitwise operators
    print(value & mask);  // prints 0 (00000000)
    print(value | mask);  // prints 10 (00001010)
    print(value ^ mask);  // prints 10 (00001010)
    print(value << 1);    // (value << 1 = 00010100) then prints 20    
    print(value >> 1);    // (value << 1 = 00000101) then prints 5
    print(~value);        // (~value = 1111..1.11110101) then prints -11
}