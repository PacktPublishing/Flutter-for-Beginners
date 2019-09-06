import 'package:flutter/material.dart';

class NavigatorDirectlyApp extends StatefulWidget {
  @override
  _NavigatorDirectlyAppState createState() => _NavigatorDirectlyAppState();
}

class _NavigatorDirectlyAppState extends State<NavigatorDirectlyApp>
    with WidgetsBindingObserver {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<bool> didPopRoute() {
    return Future.value(_navigatorKey.currentState.pop());
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      child: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => _screen1(context));
        },
      ),
      textDirection: TextDirection.ltr,
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
