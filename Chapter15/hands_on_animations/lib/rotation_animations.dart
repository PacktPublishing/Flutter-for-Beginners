import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

const _toRadians = (math.pi / 180.0);

class RotationAnimations extends StatefulWidget {
  @override
  _RotationAnimationsState createState() => _RotationAnimationsState();
}

class _RotationAnimationsState extends State<RotationAnimations> with SingleTickerProviderStateMixin {
  double _angle = 0.0;
  AnimationController _animation;

  @override
  void initState() {
    super.initState();

    // _animation = createBounceInRotationAnimation();
    _animation = createRotationAnimation();
    _animation.forward();
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey,
        child: Center(
          child: _rotationAnimationButton(),
        ),
      );
  }

  _rotationAnimationButton() {
    return Transform.rotate(
      angle: _angle,
      child: RaisedButton(
        child: Text("Rotated button"),
        onPressed: () {
          if (_animation.status == AnimationStatus.completed) {
            _animation.reset();
            _animation.forward();
          }
        },
      ),
    );
  }

  createRotationAnimation() {
    var animation = AnimationController(
      vsync: this,
      debugLabel: "animations demo",
      duration: Duration(seconds: 3),
    );

    animation.addListener(() {
      setState(() {
        _angle = (animation.value * 360.0) * _toRadians;
      });
    });

    return animation;
  }

  createBounceInRotationAnimation() {
    var controller = AnimationController(
      vsync: this,
      debugLabel: "animations demo",
      duration: Duration(seconds: 3),
    );

    var animation = controller.drive(CurveTween(
      curve: Curves.bounceIn,
    ));

    animation.addListener(() {
      setState(() {
        _angle = (animation.value * 360.0) * _toRadians;
      });
    });

    return controller;
  }
}
