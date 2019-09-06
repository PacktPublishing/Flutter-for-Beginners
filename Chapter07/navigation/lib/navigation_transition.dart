import 'package:flutter/material.dart';

class NavigatorTransitionApp extends StatefulWidget {
  @override
  _NavigatorTransitionAppState createState() => _NavigatorTransitionAppState();
}

class _NavigatorTransitionAppState extends State<NavigatorTransitionApp> {
  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: Colors.blue,
      routes: {
        '/': (context) => _screen1(context),
        '/2': (context) => _screen2(context),
      },
      pageRouteBuilder: <Void>(RouteSettings settings, WidgetBuilder builder) {
        return PageRouteBuilder(
          transitionsBuilder:
              (BuildContext context, animation, secondaryAnimation, widget) {
            return new SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: widget,
            );
          },
          pageBuilder: (BuildContext context, _, __) => builder(context),
        );
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
            onPressed: () {
              Navigator.of(context).pushNamed('/2');
            },
          ),
        ],
      ),
    );
  }
}
