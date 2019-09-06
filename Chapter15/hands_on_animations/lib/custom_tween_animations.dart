import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

const _toRadians = (math.pi / 180.0);

class CustomTweenAnimations extends StatefulWidget {
  @override
  _CustomTweenAnimationsState createState() => _CustomTweenAnimationsState();
}

class _CustomTweenAnimationsState extends State<CustomTweenAnimations>
    with SingleTickerProviderStateMixin {
  ButtonTransformation _buttonTransformation = ButtonTransformation.none;

  AnimationController _animation;

  @override
  void initState() {
    super.initState();

    _animation = createCustomTweenAnimation();
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
    return Transform(
      transform: Matrix4.translationValues(
        _buttonTransformation.offset.dx,
        _buttonTransformation.offset.dy,
        0,
      )
        ..rotateZ(_buttonTransformation.angle * _toRadians)
        ..scale(_buttonTransformation.scale, _buttonTransformation.scale),
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
    );
  }

  createCustomTweenAnimation() {
    var controller = AnimationController(
      vsync: this,
      debugLabel: "animations demo",
      duration: Duration(seconds: 3),
    );

    var animation = controller.drive(CustomTween(
        begin: ButtonTransformation.none,
        end: ButtonTransformation(
          angle: 360.0,
          offset: Offset(70, 200),
          scale: 2.0,
        )));

    animation.addListener(() {
      setState(() {
        _buttonTransformation = animation.value;
      });
    });

    return controller;
  }
}

class ButtonTransformation {
  final double scale;
  final double angle;
  final Offset offset;

  ButtonTransformation({this.scale, this.angle, this.offset});

  ButtonTransformation operator -(ButtonTransformation other) =>
      ButtonTransformation(
        scale: scale - other.scale,
        angle: angle - other.angle,
        offset: offset - other.offset,
      );

  ButtonTransformation operator +(ButtonTransformation other) =>
      ButtonTransformation(
        scale: scale + other.scale,
        angle: angle + other.angle,
        offset: offset + other.offset,
      );

  ButtonTransformation operator *(double t) => ButtonTransformation(
        scale: scale * t,
        angle: angle * t,
        offset: offset * t,
      );

  static ButtonTransformation get none => ButtonTransformation(
        scale: 1.0,
        angle: 0.0,
        offset: Offset.zero,
      );
}

class CustomTween extends Tween<ButtonTransformation> {
  CustomTween({ButtonTransformation begin, ButtonTransformation end})
      : super(
          begin: begin,
          end: end,
        );

  @override
  lerp(double t) {
    return super.lerp(t);
  }
}
