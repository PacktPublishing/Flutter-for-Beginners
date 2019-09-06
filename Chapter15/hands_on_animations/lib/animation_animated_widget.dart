import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

const _toRadians = (math.pi / 180.0);

class AnimatedWidgetAnimations extends StatefulWidget {
  @override
  _AnimatedWidgetAnimationsState createState() =>
      _AnimatedWidgetAnimationsState();
}

class _AnimatedWidgetAnimationsState extends State<AnimatedWidgetAnimations>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<ButtonTransformation> _animation;

  @override
  void initState() {
    super.initState();

    _animation = createAnimation();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Center(
        child: AnimatedButton(
          animation: _animation,
          button: RaisedButton(
            child: Text("AnimatedWidget animation"),
            onPressed: () {
              if (_controller.status == AnimationStatus.completed) {
                _controller.reverse();
              } else if (_controller.status == AnimationStatus.dismissed) {
                _controller.forward();
              }
            },
          ),
        ),
      ),
    );
  }

  createAnimation() {
    _controller = AnimationController(
      vsync: this,
      debugLabel: "animations demo",
      duration: Duration(seconds: 3),
    );

    return _controller.drive(CustomTween(
        begin: ButtonTransformation.none,
        end: ButtonTransformation(
          angle: 360.0,
          offset: Offset(70, 200),
          scale: 2.0,
        )));
  }
}

class AnimatedButton extends AnimatedWidget {
  final RaisedButton button;

  const AnimatedButton({
    Key key,
    @required Listenable animation,
    this.button,
  }) : super(
          key: key,
          listenable: animation,
        );

  @override
  Widget build(BuildContext context) {
    Animation<ButtonTransformation> animation = listenable;
    return Transform(
      transform: Matrix4.translationValues(
        animation.value.offset.dx,
        animation.value.offset.dy,
        0,
      )
        ..rotateZ(animation.value.angle * _toRadians)
        ..scale(animation.value.scale, animation.value.scale),
      child: button,
    );
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
