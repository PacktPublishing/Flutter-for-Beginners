import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(CupertinoAppDefaultTheme());
// void main() => runApp(CupertinoAppCustomTheme());
// void main() => runApp(MyAppCustomTheme());

class CupertinoAppDefaultTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: Container(
        color: CupertinoColors.white,
        child: Center(
          child: Text(
            "Simple Text",
          ),
        ),
      ),
    );
  }
}

class CupertinoAppCustomTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoTheme.of(context).copyWith(
        textTheme: CupertinoTheme.of(context).textTheme.copyWith(
              textStyle: TextStyle(
                color: Colors.red,
              ),
            ),
      ),
      home: Container(
        color: CupertinoColors.lightBackgroundGray,
        child: Center(
          child: Builder(
            builder: (context) => Text(
                  "Simple Text",
                  textDirection: TextDirection.ltr,
                ),
          ),
        ),
      ),
    );
  }
}

class MyAppCustomTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.lightBackgroundGray,
      child: Center(
        child: CupertinoTheme(
          data: CupertinoTheme.of(context).copyWith(
            textTheme: CupertinoTheme.of(context).textTheme.copyWith(
                  textStyle: TextStyle(
                    color: Colors.red,
                  ),
                ),
          ),
          child: Builder(
            builder: (context) => Text(
                  "Simple Text",
                  textDirection: TextDirection.ltr,
                  style: CupertinoTheme.of(context).textTheme.textStyle,
                ),
          ),
        ),
      ),
    );
  }
}

