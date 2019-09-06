/**
 * Runes
 */
main() {
  String dollarSymbol = '\u0024'; 

  print(dollarSymbol); // prints the dollar($) symbol

  print(dollarSymbol.codeUnits); // prints 36, the 16-bit code unit(0x0024) in decimal representation

  print(dollarSymbol.runes); // prints 36, the 32-bit code unit(0x0024) in decimal representation

  String astonishedFace = '\u{1f632}'; 

  print(astonishedFace); // prints the 😲 face

  print(astonishedFace.codeUnits); // prints [55357, 56882], the 16-bit code units of the astonished face emoticon

  print(astonishedFace.runes); // prints (128562), the single 32-bit code unit of the astonished face emoticon

}
