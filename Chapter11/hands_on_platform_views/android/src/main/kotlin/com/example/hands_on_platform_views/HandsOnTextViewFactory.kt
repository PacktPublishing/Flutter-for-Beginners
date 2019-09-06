package com.example.hands_on_platform_views

import android.content.Context

import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class HandsOnTextViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, id: Int, args: Any): PlatformView {
        val params = args as Map<String, Any>

        val text = if (params.containsKey("text")) {
            params["text"] as String? ?: ""
        } else ""

        return HandsOnTextView(context, text)
    }
}