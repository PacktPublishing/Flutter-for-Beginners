import 'package:flutter/material.dart';
import 'package:hands_on_background_process/hands_on_background_process.dart';

void main() => runApp(
      MaterialApp(
        home: Center(
          child: RaisedButton(
            child: Text("Calculate fibo on background"),
            onPressed: () {
              print("click");
              HandsOnBackgroundProcess.calculateInBackgroundProcess();
            },
          ),
        ),
        color: Colors.yellow,
      ),
    );
