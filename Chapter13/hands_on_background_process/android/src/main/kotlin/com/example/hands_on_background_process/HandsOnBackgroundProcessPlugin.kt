package com.example.hands_on_background_process

import android.app.IntentService
import android.content.Context
import android.content.Intent
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import io.flutter.view.FlutterNativeView
import java.util.*

class HandsOnBackgroundProcessPlugin(
        private val context: Context
) : MethodChannel.MethodCallHandler{
    companion object {
        const val SHARED_PREFERENCES_KEY = "com.example.background_process"
        const val ARG_CALLBACK_KEY = "callback-handle"

        @JvmStatic
        fun registerWith(registrar: PluginRegistry.Registrar) {
            val channel = MethodChannel(registrar.messenger(), "com.example.handson/plugin_channel")
            val plugin = HandsOnBackgroundProcessPlugin(registrar.context())
            channel.setMethodCallHandler(plugin)
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result?) {
        val args = call.arguments() as? ArrayList<*>
        if (call.method == "initBackgroundProcess") {
            val callbackHandle = args?.get(0) as? Long ?: return // fail to get callback
            executeBackgroundIsolate(context, callbackHandle)
        }
    }

    private fun executeBackgroundIsolate(context: Context, callbackHandle: Long) {
        val preferences = context.getSharedPreferences(SHARED_PREFERENCES_KEY, IntentService.MODE_PRIVATE)
        preferences.edit().putLong(ARG_CALLBACK_KEY, callbackHandle).apply()

        startBackgroundService(context)
    }

    private fun startBackgroundService(context: Context) {
        val intent = Intent(context, BackgroundProcessService::class.java)
        context.startService(intent)
    }
}
