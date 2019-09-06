package com.example.hands_on_background_process

import android.app.*
import android.content.ContentValues.TAG
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.os.Build
import android.os.IBinder
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import androidx.core.app.ServiceCompat
import com.example.hands_on_background_process.HandsOnBackgroundProcessPlugin.Companion.ARG_CALLBACK_KEY
import com.example.hands_on_background_process.HandsOnBackgroundProcessPlugin.Companion.SHARED_PREFERENCES_KEY
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.view.FlutterCallbackInformation
import io.flutter.view.FlutterMain
import io.flutter.view.FlutterNativeView
import io.flutter.view.FlutterRunArguments
import java.lang.Thread.sleep
import java.util.concurrent.atomic.AtomicBoolean


class BackgroundProcessService : Service(), MethodChannel.MethodCallHandler {
    private var backgroundChannel: MethodChannel? = null

    override fun onCreate() {
        super.onCreate()

        createNotification()
        FlutterMain.ensureInitializationComplete(applicationContext, null)
        startBackgroundIsolate()
    }

    companion object {
        @JvmStatic
        private var sPluginRegistrantCallback: PluginRegistrantCallback? = null
        @JvmStatic
        private var sBackgroundFlutterView: FlutterNativeView? = null

        @JvmStatic
        fun setPluginRegistrant(callback: PluginRegistrantCallback) {
            sPluginRegistrantCallback = callback
        }

        @JvmStatic
        fun setBackgroundFlutterView(view: FlutterNativeView): Boolean {
            if (sBackgroundFlutterView != null && sBackgroundFlutterView !== view) {
                return false
            }
            sBackgroundFlutterView = view
            return true
        }
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int = START_STICKY

    override fun onBind(intent: Intent?): IBinder?  = null

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result?) {
        if (call.method == "backgroundIsolateInitialized") {
            backgroundChannel?.invokeMethod("calculate", null)
        } else if (call.method == "calculationFinished") {
            sBackgroundFlutterView?.destroy()
            sBackgroundFlutterView = null
            shutdownService()
        } else {
        } // 'calculate' method, also from this channel is handled by the dart isolate.
    }

    private fun shutdownService() {
        ServiceCompat.stopForeground(this, ServiceCompat.STOP_FOREGROUND_REMOVE)
        stopSelf()
    }

    private fun startBackgroundIsolate() {
        val preferences = applicationContext.getSharedPreferences(SHARED_PREFERENCES_KEY, MODE_PRIVATE)

        val path = FlutterMain.findAppBundlePath(applicationContext)
        val callbackHandle = preferences.getLong(ARG_CALLBACK_KEY, 0L)
        if (callbackHandle == 0L) return
        val callback = FlutterCallbackInformation.lookupCallbackInformation(callbackHandle)
                ?: return

        sBackgroundFlutterView = FlutterNativeView(this, true)
        val args = FlutterRunArguments()
        args.bundlePath = path
        args.entrypoint = callback.callbackName
        args.libraryPath = callback.callbackLibraryPath

        sBackgroundFlutterView?.runFromBundle(args)
        backgroundChannel = MethodChannel(sBackgroundFlutterView, "com.example.handson/background_channel")
        backgroundChannel?.setMethodCallHandler(this)

        sPluginRegistrantCallback?.registerWith(sBackgroundFlutterView?.pluginRegistry)
    }


    private fun createNotification() {
        val channelId =
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    createNotificationChannel("my_service", "My Background Service")
                } else {
                    // in earlier versions, channelId is not used
                    ""
                }
        val bBuilder = NotificationCompat.Builder(this, channelId)
                .setSmallIcon(android.R.drawable.stat_sys_warning)
                .setContentTitle("Background isolate running")
                .setContentText("...")
                .setAutoCancel(true)
                .setOngoing(true)
        val barNotif = bBuilder.build()
        this.startForeground(1, barNotif)
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun createNotificationChannel(channelId: String, channelName: String): String{
        val chan = NotificationChannel(channelId,
                channelName, NotificationManager.IMPORTANCE_NONE)
        chan.lightColor = Color.BLUE
        chan.lockscreenVisibility = Notification.VISIBILITY_PRIVATE
        val service = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        service.createNotificationChannel(chan)
        return channelId
    }


}