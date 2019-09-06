/**
 * Dart null-safe assignment operators
 */
main() {
    var dartIsGreat = null;

    dartIsGreat ??=  "Yeah!"; // Will assign Yeah! to dartIsGreat because it is currently null
    print(dartIsGreat); // prints Yeah!

    dartIsGreat ??=  "Nope"; // Will remain “Yeah!”
    print(dartIsGreat); // prints Yeah!
}