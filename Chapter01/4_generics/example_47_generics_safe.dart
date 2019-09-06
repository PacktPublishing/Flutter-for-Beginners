/**
 * Generics safe
 */
main() {
  List<String> avengerNames = ["Hulk", "Captain America"];
  avengerNames
      .add(1); // Now, add() function expects an 'int' so this doesn't compile
  print("Avenger names: $avengerNames");
}
