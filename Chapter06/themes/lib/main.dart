import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// comment the following line and uncomment the 
// below example you want to run 

// void main() => runApp(MyAppDefaultTheme()); // default theme
// void main() => runApp(MyAppCustomTheme());
void main() => runApp(MaterialAppDefaultTheme());
// void main() => runApp(PlatformSpecificWidgets());

class MyAppDefaultTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Text(
          "Simple Text",
          textDirection: TextDirection.ltr,
          style: Theme.of(context).textTheme.display1,
        ),
      ),
    );
  }
}

class MyAppCustomTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Theme(
          data: Theme.of(context).copyWith(
            textTheme: Theme.of(context).textTheme.copyWith(
                  display1: TextStyle(
                    color: Colors.yellow,
                  ),
                ),
          ),
          child: Builder(
            builder: (context) => Text(
                  "Simple Text",
                  textDirection: TextDirection.ltr,
                  style: Theme.of(context).textTheme.display1,
                ),
          ),
        ),
      ),
    );
  }
}

class MaterialAppDefaultTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        color: Colors.white,
        child: Center(
          child: Text(
            "Simple Text",
            // textDirection: TextDirection.ltr, don't need, materialapp does the job
          ),
        ),
      ),
    );
  }
}

class PlatformSpecificWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? MaterialApp(
            theme: ThemeData(primaryColor: Colors.grey),
            home: Material( // note the material specific widget
              color: Colors.white,
              child: Center(
                child: Text(
                  "Simple Text",
                ),
              ),
            ),
          )
        : CupertinoApp(
            theme: CupertinoThemeData(
              primaryColor: CupertinoColors.lightBackgroundGray,
            ),
            home: Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  "Simple Text",
                ),
              ),
            ),
          );
  }
}
