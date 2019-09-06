import 'dart:io';

void longRunningOperation() {
  for (int i = 0; i < 5; i++) {
    sleep(Duration(seconds: 1));
    print("index: $i");
  }
}

main() {
  print("start of long running operation");

  longRunningOperation();

  print("continuing main body");

  for (int i = 10; i < 15; i++) {  
    sleep(Duration(seconds: 1));
    print("index from main: $i");
  }

  print("end of main");
}
