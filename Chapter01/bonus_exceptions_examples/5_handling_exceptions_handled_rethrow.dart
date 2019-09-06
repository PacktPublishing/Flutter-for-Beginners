
main() {
  var a;

  try {
    a.doSomething();   
  } on NoSuchMethodError catch (e, s) {
    print("'a' variable does not have the doSomething() method:");
    rethrow; // we give up handling and rethrow
  }
}