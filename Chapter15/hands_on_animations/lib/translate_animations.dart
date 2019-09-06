import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TranslateAnimations extends StatefulWidget {
  @override
  _TranslateAnimationsState createState() => _TranslateAnimationsState();
}

class _TranslateAnimationsState extends State<TranslateAnimations>
    with SingleTickerProviderStateMixin {
  Offset _offset = Offset.zero;
  AnimationController _animation;

  @override
  void initState() {
    super.initState();

    _animation = createTranslateAnimation();
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
        child: _translateAnimationButton(),
      ),
    );
  }

  _translateAnimationButton() {
    return Transform.translate(
      offset: _offset,
      child: RaisedButton(
        child: Text("Moved button"),
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

  createTranslateAnimation() {
    var controller = AnimationController(
      vsync: this,
      debugLabel: "animations demo",
      duration: Duration(seconds: 2),
    );

    var animation = controller.drive(Tween<Offset>(
      begin: Offset.zero,
      end: Offset(70, 200),
    ));

    animation.addListener(() {
      setState(() {
        _offset = animation.value;
      });
    });

    return controller;
  }
}
