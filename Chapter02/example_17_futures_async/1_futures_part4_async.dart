import 'dart:async';

Future longRunningOperation() async {
  for (int i = 0; i < 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    print("index: $i");
  }  
}

main() async {
  print("start of long running operation");

  longRunningOperation();

  print("continuing main body");

  for (int i = 10; i < 15; i++) {  
    await Future.delayed(Duration(seconds: 1));
    print("index from main: $i");
  }

  print("end of main");
}
