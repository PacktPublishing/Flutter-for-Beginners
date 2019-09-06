import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HandsOnTextView extends StatelessWidget {
  final String text;

  const HandsOnTextView({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.android
        ? AndroidView(
            viewType: 'com.example.handson/textview',
            creationParams: {
              'text': text
            },
            creationParamsCodec: StandardMessageCodec(),
          )
        : UiKitView(
            viewType: 'com.example.handson/textview',
            creationParams: {
              'text': text
            },
            creationParamsCodec: StandardMessageCodec(),
          );
  }
}
