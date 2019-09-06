import 'package:flutter/material.dart';

/**
 * Tapping on the whole container dispatch the tap event
 */
class TapWidgetExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TapWidgetExampleState();
  }
}

class _TapWidgetExampleState extends State<TapWidgetExample> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _counter++;
        });
      },
      child: Container(
        color: Colors.grey,
        child: Center(
          child: Text(
            "Tap count: $_counter",
            style: Theme.of(context).textTheme.display1,
          ),
        ),
      ),
    );
  }
}
