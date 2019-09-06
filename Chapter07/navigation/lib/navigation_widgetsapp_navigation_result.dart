
import 'package:flutter/material.dart';

class NavigatorResultApp extends StatefulWidget {
  @override
  _NavigatorResultAppState createState() =>
      _NavigatorResultAppState();
}

class _NavigatorResultAppState
    extends State<NavigatorResultApp> {

  String _message = "";

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: Colors.blue,      
      routes: {
        '/' : (context) => _screen1(context),
        '/2' : (context) => _screen2(context),
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
            child: Text("Back to Screen 1"),
            onPressed: () {
              Navigator.of(context).pop("Good bye from screen 2");
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
            onPressed: () async {
              final message = await Navigator.of(context).pushNamed('/2') ?? "Came from back button";
              setState(() {
                _message = message;
              }); 
            },
          ),
          Text(_message),
        ],
      ),
    );
  }
}

