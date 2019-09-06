import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

const _toRadians = (math.pi / 180.0);

class AnimationBuilderAnimations extends StatefulWidget {
  @override
  _AnimationBuilderAnimationsState createState() =>
      _AnimationBuilderAnimationsState();
}

class _AnimationBuilderAnimationsState extends State<AnimationBuilderAnimations>
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
        child: ButtonTransition(
          animation: _animation,
          child: RaisedButton(
            child: Text("AnimatedBuilder animation"),
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

class ButtonTransition extends StatelessWidget {
  final Animation<ButtonTransformation> _animation;
  final RaisedButton child;

  const ButtonTransition({
    Key key,
    @required Animation<ButtonTransformation> animation,
    this.child,
  })  : _animation = animation,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: child,
      builder: (context, child) => Transform(
            transform: Matrix4.translationValues(
              _animation.value.offset.dx,
              _animation.value.offset.dy,
              0,
            )
              ..rotateZ(_animation.value.angle * _toRadians)
              ..scale(_animation.value.scale, _animation.value.scale),
            child: child,
          ),
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
