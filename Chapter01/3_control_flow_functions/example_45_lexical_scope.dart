/**
 * Lexical scope
 */
globalFunction() {
  print("global/top-level function");
}

simpleFunction() {
  print("simple function");
  globalFunction() {
    print("Not really global");
  }

  globalFunction();
}

main() {
  simpleFunction();

  globalFunction();
}
