
main() {
  var a;

  try {
    a.doSomething();   
  } on NoSuchMethodError catch (e, s) { //  handled catching the reason
    print("'a' variable does not have the doSomething() method:");
    print("exception: $e");
    print("stack trace: $s");
  }
}