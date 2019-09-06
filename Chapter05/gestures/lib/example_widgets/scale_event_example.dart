import 'package:flutter/material.dart';

/**
 * Scale events are dispatched and behave like 2 drags at the same time
 */
class ScaleWidgetExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScaleWidgetExampleState();
  }
}

class _ScaleWidgetExampleState extends State<ScaleWidgetExample> {
  bool _resizing = false;
  double _scale = 1.0;
  int _scaleCount = 0;  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (ScaleStartDetails details) {
        setState(() {
         _scale = 1.0;
         _resizing = true; 
        });
      },
      onScaleUpdate: (ScaleUpdateDetails details) {
        setState(() {
         _scale = details.scale;
        });
      },
      onScaleEnd: (ScaleEndDetails details) {
        setState(() {          
          _resizing = false;
          _scaleCount++;
        });
      },
      child: Container(
        color: Colors.grey,
        child: Center(
          child: Transform.scale(
            scale: _scale,
            child: Text(
              _resizing? "RESIZING!" : "Scale count: $_scaleCount",
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),
      ),
    );
  }
}