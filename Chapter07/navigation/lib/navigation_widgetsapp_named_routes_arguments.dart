
import 'package:flutter/material.dart';

class NavigatorNamedRoutesArgumentsApp extends StatefulWidget {
  @override
  _NavigatorNamedRoutesArgumentsAppState createState() =>
      _NavigatorNamedRoutesArgumentsAppState();
}

class _NavigatorNamedRoutesArgumentsAppState
    extends State<NavigatorNamedRoutesArgumentsApp> {
  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: Colors.blue,      
      onGenerateRoute: (settings) {
        if(settings.name == '/') {
          return MaterialPageRoute(
            builder: (context) => _screen1(context)
          );
        } else if(settings.name == '/2') {
          return MaterialPageRoute(
            builder: (context) => _screen2(context, settings.arguments)
          );
        }
      },
    );
  }

  Widget _screen2(BuildContext context, String message) {
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
          ),
          Text(message),
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
              Navigator.of(context).pushNamed('/2', arguments: "Hello from screen 1");
            },
          )
        ],
      ),
    );
  }
}

