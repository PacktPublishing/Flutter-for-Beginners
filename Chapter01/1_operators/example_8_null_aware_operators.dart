/**
 * Dart null-safe expression
 */
main() {
    var yeahDartIsGreat = "Obviously!";
    var dartIsGreat = yeahDartIsGreat ?? "I don't know";
    print(dartIsGreat); // prints Obviously!    
}