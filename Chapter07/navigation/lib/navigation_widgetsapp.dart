import 'package:flutter/material.dart';

class NavigatorWidgetsApp extends StatefulWidget {
  @override
  _NavigatorWidgetsAppState createState() => _NavigatorWidgetsAppState();
}

class _NavigatorWidgetsAppState extends State<NavigatorWidgetsApp> {
  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: Colors.blue,
      home: Builder(
        builder: (context) => _screen1(context),
      ),
      pageRouteBuilder: <Void>(RouteSettings settings, WidgetBuilder builder) {
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }

  Widget _screen2(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Screen 2"),
          RaisedButton(
            child: Text("Go to Screen 1"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  Widget _screen1(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Screen 1"),
          RaisedButton(
            child: Text("Go to Screen 2"),
            onPressed: () {
              print("CLICK");
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return _screen2(context);
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
