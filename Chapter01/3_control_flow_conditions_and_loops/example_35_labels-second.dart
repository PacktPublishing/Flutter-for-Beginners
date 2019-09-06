/**
 * labels
 */
void main() {
  var avengers = ["Iron man", "Hulk", "Capitain America"];

  for (var i = 0; i < avengers.length; i++) {
    switch (avengers[i]) {
      case "Iron man":
        print("Sometimes you gotta run before you can walk.");
        break;
      case "Capitain America":
        print("I can do this all day.");
        break;
      case "Hulk":
        print("Smaaaaaaaaaash!");
        break;
    }
  }
}
