import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void backgroundCompute(args) {
  print('background compute callback');
  print('calculating fibonacci from a background process');

  int first = 0;
  int second = 1;
  for (var i = 2; i <= 50; i++) {
    var temp = second;
    second = first + second;
    first = temp;
    sleep(Duration(milliseconds: 200));
    print("first: $first, second: $second.");
  }

  print('finished calculating fibo');
}

void main() => runApp(
      MaterialApp(
        home: Center(
          child: RaisedButton(
            child: Text("Calculate fibo on compute isolate"),
            onPressed: () {             
              compute(backgroundCompute, null);
            },
          ),
        ),
        color: Colors.yellow,
      ),
    );
