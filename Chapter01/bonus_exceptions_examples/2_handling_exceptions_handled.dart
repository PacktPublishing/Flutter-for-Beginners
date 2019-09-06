
main() {
  var a;

  try {
    a.doSomething();   // will throw a exception  
  } on NoSuchMethodError {   // but now it is handled
    print("'a' variable does not have the doSomething() method ");
  }
}