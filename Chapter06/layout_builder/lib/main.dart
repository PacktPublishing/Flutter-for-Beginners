import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 500) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.green,
                    child: Center(child: Text("1")),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.blue,
                    child: Center(child: Text("2")),
                  ),
                ),
              ],
            );
          }
          return Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.yellow,
                  child: Center(child: Text("1")),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.purple,
                  child: Center(child: Text("2")),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
