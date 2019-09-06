import 'package:flutter/material.dart';
import 'package:gestures/example_widgets/doubletap_event_example.dart';
import 'package:gestures/example_widgets/drag_event_example.dart';
import 'package:gestures/example_widgets/pan_event_example.dart';
import 'package:gestures/example_widgets/press_and_hold_event_example.dart';
import 'package:gestures/example_widgets/scale_event_example.dart';
import 'package:gestures/example_widgets/tap_event_example.dart';

void main() => runApp(MyApp());

/// Uncomment the desired example to see how each one works
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: TapWidgetExample(),
      // home: DoubleTapWidgetExample(),
      // home: PressAndHoldWidgetExample(),
      // home: VerticalDragWidgetExample(),
      // home: HorizontalDragWidgetExample(),
      // home: PanWidgetExample(),
      home: ScaleWidgetExample(),
    );
  }
}
