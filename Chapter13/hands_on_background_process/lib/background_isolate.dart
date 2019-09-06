import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void backgroundIsolateMain() {
  print('background isolate entry point running');
  const backgroundchannel =
      MethodChannel('com.example.handson/background_channel');
  WidgetsFlutterBinding.ensureInitialized();

  backgroundchannel.setMethodCallHandler((MethodCall call) async {
    if (call.method == 'calculate') {
      print('calculating fibonacci from a background process');

      int first = 0;
      int second = 1;
      for (var i = 2; i <= 50; i++) {
        var temp = second;
        second = first + second;
        first = temp;
        sleep(Duration(milliseconds: 500));
        print("first: $first, second: $second.");
      }

      print('finished calculating fibo');
      backgroundchannel.invokeMethod("calculationFinished");      
    }
  });
  backgroundchannel.invokeMethod("backgroundIsolateInitialized");
}
