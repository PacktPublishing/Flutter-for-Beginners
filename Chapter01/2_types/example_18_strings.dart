/**
 * Strings
 */
main() {
  String a = 'This is a String\n'; // single quotes
  String b = "This is also a String\n"; // double quotes
  
  String c = """
      This is also
      a String\n
      """; // triple quotes to easy multiline

  String d = "This" +
      ' is also a ' +
      " String\n"; // You can concatenate strings by using the + symbol
  
  String e =
      "This" ' is also a ' " String\n"; // Or without it, just by putting adjacents
  
  // other string operators

  print(a*2); // prints: This is a String
              //         This is a String
          
  print(a[0]); // prints T
    

}
