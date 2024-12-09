package com.example.lnastaqim

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.Bundle
import androidx.annotation.NonNull
import androidx.core.app.NotificationCompat
import androidx.media.session.MediaButtonReceiver
import android.support.v4.media.session.MediaSessionCompat
import android.support.v4.media.session.PlaybackStateCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "qr.lnastaqim/channel"
    private val EVENTS = "qr.lnastaqim/events"
    private var fullUrl: String? = null
    private var linksReceiver: BroadcastReceiver? = null
    private lateinit var mediaSession: MediaSessionCompat
    private lateinit var notificationManager: NotificationManager

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // MethodChannel to communicate with Flutter
        MethodChannel(flutterEngine.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "initialLink" -> {
                    fullUrl?.let {
                        result.success(it) // Send the URL to Flutter
                    }
                }
                "playMedia" -> {
                    // Implement Play media functionality here
                    showMediaNotification("Media Title", "Media Artist", isPlaying = true)
                    result.success("Media playing started.")
                }
                "pauseMedia" -> {
                    // Implement Pause media functionality here
                    showMediaNotification("Media Title", "Media Artist", isPlaying = false)
                    result.success("Media paused.")
                }
                "skipNext" -> {
                    // Handle Skip to next media
                    result.success("Skipped to next media.")
                }
                "skipPrevious" -> {
                    // Handle Skip to previous media
                    result.success("Skipped to previous media.")
                }
                else -> result.notImplemented()
            }
        }

        // EventChannel for streaming events to Flutter
        EventChannel(flutterEngine.dartExecutor, EVENTS).setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(args: Any?, events: EventChannel.EventSink) {
                linksReceiver = createChangeReceiver(events)
            }

            override fun onCancel(args: Any?) {
                linksReceiver = null
            }
        })
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Initialize Media Session
        initMediaSession()

        // Capture the intent that started the app
        val intent = intent
        fullUrl = intent.data?.toString() // Get the full URL

        // Log the captured URL
        println("Initial Full URL: $fullUrl")

        // Handle deep link validation
        validateDeepLink(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        validateDeepLink(intent)
    }

    private fun validateDeepLink(intent: Intent) {
        if (intent.action == Intent.ACTION_VIEW) {
            val data = intent.data
            data?.let {
                val scheme = it.scheme
                val host = it.host
                val fullUrl = it.toString()

                // Send the full URL to Flutter using MethodChannel
                val flutterChannel = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL)
                flutterChannel.invokeMethod("navigateTo", fullUrl)
            }
        }
    }

    private fun initMediaSession() {
        mediaSession = MediaSessionCompat(this, "MediaSession").apply {
            setFlags(MediaSessionCompat.FLAG_HANDLES_MEDIA_BUTTONS or MediaSessionCompat.FLAG_HANDLES_TRANSPORT_CONTROLS)
            setPlaybackState(
                PlaybackStateCompat.Builder()
                    .setActions(
                        PlaybackStateCompat.ACTION_PLAY or PlaybackStateCompat.ACTION_PAUSE or
                                PlaybackStateCompat.ACTION_SKIP_TO_NEXT or PlaybackStateCompat.ACTION_SKIP_TO_PREVIOUS
                    )
                    .setState(PlaybackStateCompat.STATE_PAUSED, 0, 1.0f)
                    .build()
            )
            isActive = true
        }

        createNotificationChannel()
        showMediaNotification("Media Title", "Media Artist", isPlaying = false)
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channelId = "MEDIA_CHANNEL_ID"
            val channelName = "Media Playback"
            val channelDescription = "Controls for media playback"
            val importance = NotificationManager.IMPORTANCE_LOW

            val channel = NotificationChannel(channelId, channelName, importance).apply {
                description = channelDescription
            }

            notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            val existingChannel = notificationManager.getNotificationChannel(channelId)
            if (existingChannel == null) {
                notificationManager.createNotificationChannel(channel)
            }
        }
    }

    private fun showMediaNotification(title: String, artist: String, isPlaying: Boolean) {
        val playPauseIcon = if (isPlaying) android.R.drawable.ic_media_pause else android.R.drawable.ic_media_play
        val playPauseAction = if (isPlaying) PlaybackStateCompat.ACTION_PAUSE else PlaybackStateCompat.ACTION_PLAY

        val notification = NotificationCompat.Builder(this, "MEDIA_CHANNEL_ID")
            .setContentTitle(title)
            .setContentText(artist)
            .setSmallIcon(android.R.drawable.ic_media_play)
            .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
            .addAction(
                NotificationCompat.Action(
                    android.R.drawable.ic_media_previous,
                    "Previous",
                    MediaButtonReceiver.buildMediaButtonPendingIntent(
                        this,
                        PlaybackStateCompat.ACTION_SKIP_TO_PREVIOUS
                    )
                )
            )
            .addAction(
                NotificationCompat.Action(
                    playPauseIcon,
                    if (isPlaying) "Pause" else "Play",
                    MediaButtonReceiver.buildMediaButtonPendingIntent(this, playPauseAction)
                )
            )
            .addAction(
                NotificationCompat.Action(
                    android.R.drawable.ic_media_next,
                    "Next",
                    MediaButtonReceiver.buildMediaButtonPendingIntent(
                        this,
                        PlaybackStateCompat.ACTION_SKIP_TO_NEXT
                    )
                )
            )
            .setStyle(
                androidx.media.app.NotificationCompat.MediaStyle()
                    .setMediaSession(mediaSession.sessionToken)
                    .setShowActionsInCompactView(0, 1, 2)
            )
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .build()

        notificationManager.notify(1, notification)
    }

    private fun createChangeReceiver(events: EventChannel.EventSink): BroadcastReceiver? {
        return object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                val fullUrl = intent.data?.toString()
                if (fullUrl != null) {
                    events.success(fullUrl)
                } else {
                    events.error("UNAVAILABLE", "Link unavailable", null)
                }
            }
        }
    }
}
