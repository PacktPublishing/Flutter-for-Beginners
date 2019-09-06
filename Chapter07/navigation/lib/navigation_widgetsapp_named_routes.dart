import 'package:flutter/material.dart';

class NavigatorNamedRoutesWidgetsApp extends StatefulWidget {
  @override
  _NavigatorNamedRoutesWidgetsAppState createState() =>
      _NavigatorNamedRoutesWidgetsAppState();
}

class _NavigatorNamedRoutesWidgetsAppState
    extends State<NavigatorNamedRoutesWidgetsApp> {
  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: Colors.blue,
      home: Builder(
        builder: (context) => _screen1(context),
      ),
      routes: {
        '/2': (context) => _screen1(context),
      },
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
              Navigator.of(context).pushNamed('/2');
            },
          )
        ],
      ),
    );
  }
}
