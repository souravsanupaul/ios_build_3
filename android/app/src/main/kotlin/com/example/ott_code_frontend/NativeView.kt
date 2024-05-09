package com.example.ott_code_frontend

import android.app.AlertDialog
import android.content.Context
import android.content.DialogInterface
import android.content.pm.ActivityInfo
import android.net.Uri
import android.support.v4.media.session.PlaybackStateCompat
import android.view.View
import android.widget.ImageView
import android.widget.PopupMenu
import android.widget.TextView
import com.google.android.exoplayer2.C
import com.google.android.exoplayer2.ExoPlayer
import com.google.android.exoplayer2.MediaItem
import com.google.android.exoplayer2.MediaItem.AdsConfiguration
import com.google.android.exoplayer2.PlaybackParameters
import com.google.android.exoplayer2.Player
import com.google.android.exoplayer2.ext.ima.ImaAdsLoader
import com.google.android.exoplayer2.source.DefaultMediaSourceFactory
import com.google.android.exoplayer2.source.MediaSourceFactory
import com.google.android.exoplayer2.source.ads.AdPlaybackState
import com.google.android.exoplayer2.source.ads.AdsLoader
import com.google.android.exoplayer2.trackselection.AdaptiveTrackSelection
import com.google.android.exoplayer2.trackselection.DefaultTrackSelector
import com.google.android.exoplayer2.trackselection.TrackSelectionOverrides
import com.google.android.exoplayer2.ui.AspectRatioFrameLayout
import com.google.android.exoplayer2.ui.PlayerView
import com.google.android.exoplayer2.upstream.DataSource
import com.google.android.exoplayer2.upstream.DefaultDataSourceFactory
import com.google.android.exoplayer2.util.MimeTypes
import com.google.android.exoplayer2.util.Util
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView


internal class NativeView(context: Context, id: Int, creationParams: Map<String?, Any?>?, messenger: BinaryMessenger,
                          mainActivity: com.example.ott_code_frontend.MainActivity) : PlatformView,
    MethodChannel.MethodCallHandler {
    private var qualityPopUp: PopupMenu?=null
    private var trackSelector: DefaultTrackSelector?=null
    var qualityList = ArrayList<Pair<String, TrackSelectionOverrides.Builder>>()
    private val playerView: PlayerView
    private var adsLoader: ImaAdsLoader? = null
    private var eventListener : AdsLoader.EventListener? = null
    var player: ExoPlayer? = null
    var contentUri : String? = null
    private val methodChannel: MethodChannel
    var speed = arrayOf("0.25x", "0.5x", "Normal", "1.5x", "2x")
    override fun getView(): View {
        return playerView
    }


    override fun dispose() {
        adsLoader!!.setPlayer(null)
        playerView.player = null
        player!!.release()
        player = null
        ActivityInfo.SCREEN_ORIENTATION_PORTRAIT
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "loadUrl" -> {
                contentUri = call.arguments.toString()

            }
            "pauseVideo" -> {
                player!!.pause()
            }
            "resumeVideo" -> {
            }
            else -> result.notImplemented()
        }
    }

    init {
        methodChannel = MethodChannel(messenger, "bms_video_player")
        methodChannel.setMethodCallHandler(this)
        playerView = PlayerView(context)
        adsLoader = ImaAdsLoader.Builder( /* context= */context).build()
        if (Util.SDK_INT > 23) {
            initializePlayer(id,mainActivity,creationParams,methodChannel)
        }

    }

    private fun sendBackButtonCallback() {
        methodChannel.invokeMethod("onBackButtonClicked", null)
    }

    private fun initializePlayer(id: Int, mainActivity: MainActivity, creationParams: Map<String?, Any?>?, methodChannel: MethodChannel) {
        val dataSourceFactory: DataSource.Factory = DefaultDataSourceFactory(playerView.context, Util.getUserAgent(playerView.context, "exo_demo"))
        val mediaSourceFactory: MediaSourceFactory = DefaultMediaSourceFactory(dataSourceFactory)
            .setAdsLoaderProvider { unusedAdTagUri: AdsConfiguration? -> adsLoader }
            .setAdViewProvider(playerView)

        trackSelector = DefaultTrackSelector(playerView.context, AdaptiveTrackSelection.Factory())

        player = ExoPlayer.Builder(playerView.context)
            .setMediaSourceFactory(mediaSourceFactory)
            .setTrackSelector(trackSelector!!)
            .build()
        player!!.preparePlayer(playerView, true, mainActivity, methodChannel)

        // XML IDS -----------------------------------------
        val rewBtn: ImageView = playerView.findViewById(R.id.rew)
        val farwordBtn: ImageView = playerView.findViewById(R.id.fwd)
        val backBtn: ImageView = playerView.findViewById(R.id.backExo)
        val speedBtn: ImageView = playerView.findViewById(R.id.exo_playback_speed)
        val speedTxt: TextView = playerView.findViewById(R.id.speed)
        val titleTextView: TextView = playerView.findViewById(R.id.titleMoviePlayer)
        val exo_quality: ImageView = playerView.findViewById(R.id.exo_quality)
        // XML IDS -----------------------------------------

        // Parse HLS streaming URL and ad tag URIs
        val url = creationParams as Map<String?, Any?>?
        val contentUri = Uri.parse(url?.get("videoURL") as String?)
        val contentTitle = url?.get("videoText") as String

        val adTagUri3 = Uri.parse("https://indimuse.in/api/v1/vmap/66137255fc07faf06984c4aa")



        val adMediaItem1 = MediaItem.Builder()
            .setUri(contentUri)
            .setMimeType(MimeTypes.APPLICATION_M3U8)
            .setAdTagUri(adTagUri3)
            .build()

        val contentMediaItem = MediaItem.Builder()
            .setUri(contentUri)
            .setMimeType(MimeTypes.APPLICATION_M3U8) // Adjust MIME type as per your content
            .build()


        playerView.player = player
        adsLoader!!.setPlayer(player)
        playerView.isControllerVisible
        playerView.setShowNextButton(false)
        playerView.setShowPreviousButton(false)
        playerView.showController()
        playerView.resizeMode = AspectRatioFrameLayout.RESIZE_MODE_FIT
        playerView.controllerHideOnTouch = false

        player!!.setMediaItem(adMediaItem1)
        player!!.prepare()
        player!!.playWhenReady = true

        player!!.addListener(object : Player.Listener {

            override fun onPlaybackStateChanged(playbackState: Int) {
                if (playbackState==Player.STATE_READY){
                    trackSelector?.generateQualityList()?.let {
                        qualityList = it
                        setUpQualityList()
                    }
                }
            }

//            override fun onIsPlayingChanged(isPlaying: Boolean) {
//                if (!isPlaying && player!!.currentMediaItem == adMediaItem1) {
//                    player!!.setMediaItem(adMediaItem2)
//                    player!!.prepare()
//                    player!!.playWhenReady = true
//                } else if (!isPlaying && player!!.currentMediaItem == adMediaItem2) {
//                    player!!.setMediaItem(contentMediaItem)
//                    player!!.prepare()
//                    player!!.playWhenReady = true
//                }
//            }
        })

        // Set up button click listeners
        rewBtn.setOnClickListener {
            val num: Long = player!!.getCurrentPosition() - 10000
            if (num < 0) {
                player!!.seekTo(0)
            } else {
                player!!.seekTo(player!!.getCurrentPosition() - 10000)
            }
        }

        farwordBtn.setOnClickListener {
            player!!.seekTo(player!!.getCurrentPosition() + 10000)
        }

        speedBtn.setOnClickListener {
            val builder = AlertDialog.Builder(playerView.context)
            builder.setTitle("Set Speed")
            builder.setItems(
                speed,
                DialogInterface.OnClickListener { dialog, which -> // the user clicked on colors[which]
                    if (which == 0) {
                        speedTxt.setVisibility(View.VISIBLE)
                        speedTxt.setText("0.25X")
                        val param = PlaybackParameters(0.5f)
                        player!!.setPlaybackParameters(param)
                    }
                    if (which == 1) {
                        speedTxt.setVisibility(View.VISIBLE)
                        speedTxt.setText("0.5X")
                        val param = PlaybackParameters(0.5f)
                        player!!.setPlaybackParameters(param)
                    }
                    if (which == 2) {
                        speedTxt.setVisibility(View.GONE)
                        val param = PlaybackParameters(1f)
                        player!!.setPlaybackParameters(param)
                    }
                    if (which == 3) {
                        speedTxt.setVisibility(View.VISIBLE)
                        speedTxt.setText("1.5X")
                        val param = PlaybackParameters(1.5f)
                        player!!.setPlaybackParameters(param)
                    }
                    if (which == 4) {
                        speedTxt.setVisibility(View.VISIBLE)
                        speedTxt.setText("2X")
                        val param = PlaybackParameters(2f)
                        player!!.setPlaybackParameters(param)
                    }
                })
            builder.show()
        }

        backBtn.setOnClickListener {
            sendBackButtonCallback()
        }

        titleTextView.text = contentTitle;

        exo_quality.setOnClickListener {
            qualityPopUp?.show()
        }
    }



    private fun setUpQualityList() {
        val exo_quality: ImageView = playerView.findViewById(R.id.exo_quality)
        qualityPopUp = PopupMenu(playerView.context, exo_quality)
        qualityList.let {
            for ((i, videoQuality) in it.withIndex()) {
                qualityPopUp?.menu?.add(0, i, 0, videoQuality.first)
            }
        }

        qualityPopUp?.setOnMenuItemClickListener { menuItem ->
            qualityList[menuItem.itemId].let {
                trackSelector!!.setParameters(
                    trackSelector!!.getParameters()
                        .buildUpon()
                        .setTrackSelectionOverrides(it.second.build())
                        .setTunnelingEnabled(true)
                        .build()
                )
            }
            true
        }
    }
}
