package com.example.hands_on_platform_views

import android.content.Context
import android.view.View
import android.widget.TextView

import io.flutter.plugin.platform.PlatformView

class HandsOnTextView internal constructor(context: Context, text: String) : PlatformView {
    private val textView: TextView = TextView(context)

    init {
        textView.text = text
    }

    override fun getView(): View {
        return textView
    }

    override fun dispose() {}
}