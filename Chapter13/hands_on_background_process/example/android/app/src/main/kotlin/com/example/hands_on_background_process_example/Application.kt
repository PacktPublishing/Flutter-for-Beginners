package com.example.hands_on_background_process_example

import android.util.Log
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant
import com.example.hands_on_background_process.BackgroundProcessService

class Application: FlutterApplication(), PluginRegistry.PluginRegistrantCallback  {

    override fun onCreate() {
        super.onCreate()
        Log.w("BACKGROUND", "application")
        BackgroundProcessService.setPluginRegistrant(this)
    }

    override fun registerWith(registry: PluginRegistry?) {
        GeneratedPluginRegistrant.registerWith(registry)
    }
}