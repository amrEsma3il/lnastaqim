package com.example.lnastaqim

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "qr.lnastaqim/channel"
    private val EVENTS = "qr.lnastaqim/events"
    private var fullUrl: String? = null
    private var linksReceiver: BroadcastReceiver? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Setting up MethodChannel to communicate with Flutter
        MethodChannel(flutterEngine.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "initialLink") {
                fullUrl?.let {
                    result.success(it) // Send the whole URL to Flutter
                }
            }
        }

        // Setting up EventChannel to send events to Flutter
        EventChannel(flutterEngine.dartExecutor, EVENTS).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(args: Any?, events: EventChannel.EventSink) {
                    linksReceiver = createChangeReceiver(events)
                }

                override fun onCancel(args: Any?) {
                    linksReceiver = null
                }
            }
        )
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Capture the intent that started the app
        val intent = intent
        fullUrl = intent.data?.toString() // Get the full URL

        // Log the captured URL
        Log.d("DeepLink", "Initial Full URL: $fullUrl")

        // Check scheme and host before connecting to Flutter
        validateDeepLink(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)

        // Check the scheme and host before proceeding
        validateDeepLink(intent)
    }

    private fun validateDeepLink(intent: Intent) {
        if (intent.action == Intent.ACTION_VIEW) {
            val data = intent.data
            if (data != null) {
                // Check scheme
                val scheme = data.scheme
                val host = data.host
                val fullUrl = data.toString() // Capture the full URL as a string

                Log.d("DeepLink", "Scheme: $scheme, Host: $host, Full URL: $fullUrl")


                    // Sending the full URL to Flutter
                    val flutterChannel = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL)
                    flutterChannel.invokeMethod("navigateTo", fullUrl) // Send the full URL

            }
        }
    }

    // BroadcastReceiver to handle deep links while the app is already running
    private fun createChangeReceiver(events: EventChannel.EventSink): BroadcastReceiver? {
        return object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                val fullUrl = intent.data?.toString() // Capture the full URL as a string
                if (fullUrl != null) {
                    events.success(fullUrl)
                } else {
                    events.error("UNAVAILABLE", "Link unavailable", null)
                }
            }
        }
    }
}