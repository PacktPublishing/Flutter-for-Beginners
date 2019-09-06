import 'package:flutter/material.dart';
import 'package:hands_on_animations/animation_animated_widget.dart';
import 'package:hands_on_animations/animation_builder.dart';
import 'package:hands_on_animations/composed_animations.dart';
import 'package:hands_on_animations/custom_tween_animations.dart';
import 'package:hands_on_animations/rotation_animations.dart';
import 'package:hands_on_animations/scale_animations.dart';
import 'package:hands_on_animations/translate_animations.dart';

void main() => runApp(AnimationsApp());

class AnimationsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Animations Demo",
      // comment the following line and uncomment the 
      // below example you want to run 
      home: RotationAnimations(), // comment this
      // home: ScaleAnimations(), // uncomment this for scale examples
      // home: TranslateAnimations(),
      // home: ComposedAnimations(),
      // home: AnimationBuilderAnimations(),
      // home: AnimatedWidgetAnimations(),
    );
  }  
}

