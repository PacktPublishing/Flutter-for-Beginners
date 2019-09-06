import 'package:flutter/material.dart';
import 'package:hands_on_platform_views/hands_on_platform_views.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        alignment: Alignment.center,
        color: Colors.red,
        child: SizedBox(
          height: 100,
          child: HandsOnTextView(
            text: "Text from Platform view",
          ),
        ),
      ),
    );
  }
}
