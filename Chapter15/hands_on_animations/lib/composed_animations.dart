import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

const _toRadians = (math.pi / 180.0);

class ComposedAnimations extends StatefulWidget {
  @override
  _ComposedAnimationsState createState() => _ComposedAnimationsState();
}

class _ComposedAnimationsState extends State<ComposedAnimations>
    with SingleTickerProviderStateMixin {
  Offset _offset = Offset.zero;
  double _scale = 1.0;
  double _angle = 0.0;

  AnimationController _animation;

  @override
  void initState() {
    super.initState();

    _animation = createComposedAnimation();
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
        child: _composedAnimationButton(),
      ),
    );
  }

  _composedAnimationButton() {
    return Transform.translate(
      offset: _offset,
      child: Transform.rotate(
        angle: _angle * _toRadians,
        child: Transform.scale(
          scale: _scale,
          child: RaisedButton(
            child: Text("multiple animation"),
            onPressed: () {
              if (_animation.status == AnimationStatus.completed) {
                _animation.reverse();
              } else if (_animation.status == AnimationStatus.dismissed) {
                _animation.forward();
              }
            },
          ),
        ),
      ),
    );
  }

  createComposedAnimation() {
    var animation = AnimationController(
      vsync: this,
      debugLabel: "animations demo",
      duration: Duration(seconds: 3),
    );

    animation.addListener(() {
      setState(() {
        _offset = Offset(animation.value * 70, animation.value * 200);
        _scale = 1.0 + animation.value;
        _angle = 360 * animation.value;
      });
    });

    return animation;
  }
}
