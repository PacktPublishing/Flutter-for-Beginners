import 'dart:ui';
import 'package:flutter/services.dart';

import 'background_isolate.dart';

const pluginChannel = MethodChannel('com.example.handson/plugin_channel');

class HandsOnBackgroundProcess {
  static void calculateInBackgroundProcess() async {
    final callbackHandle = PluginUtilities.getCallbackHandle(backgroundIsolateMain);

    await pluginChannel.invokeMethod("initBackgroundProcess", [callbackHandle.toRawHandle()]);    
  }
}
