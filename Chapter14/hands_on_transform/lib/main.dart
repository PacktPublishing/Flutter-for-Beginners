import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transformations Demo',
      home: Container(
        color: Colors.yellow,
        // comment current line and uncomment the below example
        // you want to run 
        child: Center(child: _rotationExample1()), // comment this
        // child: Center(child: _rotationExample2()), // uncomment this for 2nd rotation example
        // child: Center(child: _scaleExample1()),
        // child: Center(child: _scaleExample2),
        // child: Center(child: _translateExample1()),
        // child: Center(child: _translateExample2()),
        // child: Center(child: _composedTranformationExample1()),
        // child: Center(child: _composedTranformationExample2()),
      ),
    );
  }

  _rotationExample1() => Transform.rotate(
        angle: -45 * (math.pi / 180.0), // same as 315º clockwise
        child: RaisedButton(
          child: Text("Rotated button"),
          onPressed: () {},
        ),
      );
  _rotationExample2() => Transform(
        transform: Matrix4.rotationZ(-45 * (math.pi / 180.0)),
        alignment: Alignment.center,
        child: RaisedButton(
          child: Text("Rotated button"),
          onPressed: () {},
        ),
      );

  _scaleExample1() => Transform.scale(
        scale: 2.0, // 0.4 scaled down, 1.0 original and 2.0 scaled up
        child: RaisedButton(
          child: Text("scaled up"),
          onPressed: () {},
        ),
      );

  _scaleExample2() => Transform(
        transform: Matrix4.identity()..scale(2.0, 2.0),
        alignment: Alignment.center,
        child: RaisedButton(
          child: Text("scaled up"),
          onPressed: () {},
        ),
      );

  _translateExample1() => Transform.translate(
        offset: Offset(100, 300), // original position, center, ofset: (0,0)
        // translated to bottom, offset(x=100,y=300)
        child: RaisedButton(
          child: Text("translated to bottom"),
          onPressed: () {},
        ),
      );

  _translateExample2() => Transform(
        transform: Matrix4.translationValues(100, 300, 0),
        child: RaisedButton(
          child: Text("translated to bottom"),
          onPressed: () {},
        ),
      );

  _composedTranformationExample1() => Transform.translate(
        offset: Offset(70, 200),
        child: Transform.rotate(
          angle: -45 * (math.pi / 180.0),
          child: Transform.scale(
            scale: 2.0,
            child: RaisedButton(
              child: Text("multiple transformations"),
              onPressed: () {},
            ),
          ),
        ),
      );

  _composedTranformationExample2() => Transform(
        alignment: Alignment.center,
        transform: Matrix4.translationValues(70, 200, 0)
          ..rotateZ(-45 * (math.pi / 180.0))
          ..scale(2.0, 2.0),
        child: RaisedButton(
          child: Text("multiple transformations"),
          onPressed: () {},
        ),
      );
}
