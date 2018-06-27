Config
======

Overview
--------

*RemoteMonster* takes the *config* values in advance before creating the
object.

Basics
------

The most basic things to do are specifying the *View* to be displayed on
the screen, *Service Id*, and *Key*.

### View

These settings are used for specifying the View to which the video will
be displayed.

{% tabs %} {% tab title="Web" %}

      <video id="remoteVideo" autoplay controls></video>
      <video id="localVideo" autoplay controls muted></video>
      <script>
        const config = {
          view: {
            remote: '#remoteVideo', local: '#localVideo'
          }
        }
      </script>

{% endtab %}

{% tab title="Android" %}

      Config config = new com.remotemonster.sdk.Config();
      config.setLocalView((SurfaceViewRenderer) findViewById(R.id.local_video_view));
      config.setRemoteView((SurfaceViewRenderer) findViewById(R.id.remote_video_view));

{% endtab %}

{% tab title="iOS" %}

    let myRemoteView:UIView! = UIView()
    let myLocalView:UIView! = UIView()
    let remonCall = RemonCall()
    remonCall.remoteView = myRemoteView
    remonCall.localView = myLocalView

{% endtab %} {% endtabs %}

At this time, the *config* settings must be specified with *Views*.
Please refer to the following.

{% page-ref page="../web/web-view.md" %}

{% page-ref page="../android/android-view.md" %}

{% page-ref page="../ios/ios-view.md" %}

### Service Id, Key

It is required to specify *Service Id* and *Key*.

{% tabs %} {% tab title="Web" %}

      const config = {
        credential: {
          serviceId: 'myServiceId', key: 'myKey'
        }
      }

{% endtab %}

{% tab title="Android" %}

      Config config = new com.remotemonster.sdk.Config();
      config.setServiceId("myServiceId");
      config.setKey("myKey");

{% endtab %}

{% tab title="iOS" %}

    let remonCall = RemonCall()
    remonCall.serviceId = "myServiceId"
    remonCall.serviceKey = "myServiceKey"

{% endtab %} {% endtabs %}

Media
-----

There are more options for audio and video available.

### Select Video, Audio

You can create a video broadcast / call or audio broadcast / call
content service by turning on and off the video.

{% tabs %} {% tab title="Web" %}

    // Audio Only
    const config = {
      media: {
        audio: true,
        video: false
      }
    }

    // Audio, Video
    const config = {
      media: {
        audio: true,
        video: true
      }
    }

{% endtab %}

{% tab title="Android" %}

    // Audio Only
    config.setVideoCall(false);

    // Audio, Video
    config.setVideoCall(true);

{% endtab %}

{% tab title="iOS" %}

    // Audio Only
    remonCall.onlyAudio = true

    // Audio, Video
    remonCall.onlyAudio = false             //default fasle

{% endtab %} {% endtabs %}

### Video Options

*width* and *height* determine the resolution of the video to be sent to
the other party. *width* and *height* is set to transmit at resolutions
up to 640 and 480, but this setting is not necessarily to be observed..
*WebRTC* basically maintains the quality by flexibly changing resolution
and framerate according to the network/terminal status. Although the
resolution may differ from the actual one, we try to match the ratio as
much as possible.

Browser supports video codecs *such as H.264, VP8, VP9, etc.*
*RemoteMonster* uses *H.264* as its default codec, and this setting can
be changed if necessary.

The *frameRate* entry determines how many frames per second to encode.
About *15 fps* is also appropriate for an ordinary video call.

*facingMode* determines which camera to use when the device has a front
camera and a rear camera. Currently *facingMode* does not work properly
in the mobile version of the Chrome browser.

{% tabs %} {% tab title="Web" %}

    const config = {
      media: {
        video: {
          width: {max: '640', min: '640'},
          height: {max: '480', min: '480'},
          codec: 'H264',                 // 'VP9', 'VP8', 'H264'
          frameRate: {max:15, min:15},
          facingMode: 'user'             // 'user', 'environment'
        }
      }
    }

{% endtab %}

{% tab title="Android" %}

    config.setVideoWidth(640);
    config.setVideoHeight(480);
    config.setVideoCodec("VP8");  // 'VP9', 'VP8', 'H264'
    config.setVideoFps(15);

{% endtab %}

{% tab title="iOS" %}

    let remonCall = RemonCall()

    remonCall.videoWidth = 640
    remonCall.videoHeight = 480
    remonCall.videoFps = 24
    remonCall.videoCodec = "H264"
    remonCall.useFrontCamera = true       // this is true by default, if this is false, use the rear camera.
    // Start local video capture automatically when it is ready to transmit a local video.
    // If you set this value to false, you must call startLocalVideoCapture () after the onComplete () call.
    remonCall.autoCaptureStart = true     // default true

{% endtab %} {% endtabs %}

### Audio Options

This is used to automatically detect the user\'s accessibility and
dynamically change to either the earpiece mode or the speakerphone mode.
Set the option to false if you want to disable this feature, or set the
option to true if you want to keep it.

{% tabs %} {% tab title="Web" %} N/A {% endtab %}

{% tab title="Android" %}

    config.setSpeakerPhone("auto"); // auto, true, false

{% endtab %}

{% tab title="iOS" %} N/A {% endtab %} {% endtabs %}

Debug
-----

You can set *SILENT, ERROR, WARN, INFO, DEBUG, and VERBOSE.* You can
also check more detailed logs as you go back.

{% tabs %} {% tab title="Web" %}

    const config = {
      dev:{
        logLevel: 'INFO'
      }
    }

{% endtab %}

{% tab title="Android" %}

    config.setLogLevel(Log.DEBUG);

{% endtab %}

{% tab title="iOS" %}

    let remonCast = RemonCast()
    remonCast.debugMode = true

{% endtab %} {% endtabs %}
