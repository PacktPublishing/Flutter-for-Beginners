import 'package:flutter/material.dart';

/**
 * Pressing and holding on the whole container dispatch the longpress event
 */
class PressAndHoldWidgetExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PressAndHoldWidgetExampleState();
  }
}

class _PressAndHoldWidgetExampleState extends State<PressAndHoldWidgetExample> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          _counter++;
        });
      },
      child: Container(
        color: Colors.grey,
        child: Center(
          child: Text(
            "Long press count: $_counter",
            style: Theme.of(context).textTheme.display1,
          ),
        ),
      ),
    );
  }
}
