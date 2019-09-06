package com.example.hands_on_platform_views

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class HandsOnPlatformViewsPlugin{
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      registrar
            .platformViewRegistry()
            .registerViewFactory(
                    "com.example.handson/textview", HandsOnTextViewFactory());
    }
  }
}
