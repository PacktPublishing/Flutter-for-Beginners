/**
 * The BigInt type
 */

// this example does not compiles on DartPad, see below
main() {
 var maxInt = 9223372036854775807; // max int in Dart VM 
 // ‭0111111111111111111111111111111111111111111111111111111111111111‬
 print(maxInt); // 9223372036854775807
 
 print(maxInt*2); 
 // number overflow becomes negative, as it already have almost all the bits as '1'
 
 BigInt bigInt = BigInt.from(maxInt);
 print(bigInt * BigInt.from(2)); 
 // will not overflow, instead print the wanted value: 18446744073709551614 
}