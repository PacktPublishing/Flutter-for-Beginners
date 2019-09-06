
main() {
  var a;

  try {
    a.doSomething();   
  } on NoSuchMethodError catch (e, s) {
    print("'a' variable does not have the doSomething() method:");
  } finally { // after all, we do something, failing or not
    print("end of the block");
  }
}