main() {
 var maxInt = 9007199254740992; // max int in Dart to Javascript
 // ‭00100000000000000000000000000000000000000000000000000000‬
 print(maxInt); // prints 9007199254740992

 print(maxInt*2); 
 // prints 18014398509481984, but see below
 
 BigInt bigInt = BigInt.from(maxInt);
 print(bigInt * BigInt.from(2)); 
 // will not overflow also, prints 18014398509481984
}