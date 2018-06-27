Communication
=============

Default Settings
----------------

Proceed with project setting before communicating.

{% page-ref page="../web/web-getting-start.md" %}

{% page-ref page="../android/android-getting-start.md" %}

{% page-ref page="../ios/ios-getting-start.md" %}

Development
-----------

The *RemonCall* class is used for communication functions. You can
create and connect a channel using the *connect ()* function of the
*RemonCall* class.

See below for the overall configuration and flow.

{% page-ref page="../overview/flow.md" %}

{% page-ref page="../overview/structure.md" %}

### View Registration

You need a view to see yourself or to see the other party with whom you
are talking on the phone. You can register a *Local View* to see
yourself and register a *Remote View* to see the other party.

{% tabs %} {% tab title="Web" %}

    <!-- local view -->
    <video id="localVideo" autoplay muted></video>
    <!-- remote view -->
    <video id="remoteVideo" autoplay></video>

{% endtab %}

{% tab title="Android" %}

    <!-- local view -->
    <com.remotemonster.sdk.PercentFrameLayout
        android:id="@+id/perFrameLocal"
        android:layout_width="match_parent"
        android:layout_height="match_parent">
        <org.webrtc.SurfaceViewRenderer
            android:id="@+id/surfRendererLocal"
            android:layout_width="match_parent"
            android:layout_height="match_parent" />
    </com.remotemonster.sdk.PercentFrameLayout>
    <!-- remote view -->
    <com.remotemonster.sdk.PercentFrameLayout
        android:id="@+id/perFrameRemote"
        android:layout_width="match_parent"
        android:layout_height="match_parent">
        <org.webrtc.SurfaceViewRenderer
            android:id="@+id/surfRendererRemote"
            android:layout_width="match_parent"
            android:layout_height="match_parent" />
    </com.remotemonster.sdk.PercentFrameLayout>

{% endtab %}

With *{% tab title="iOS" %} Interface Builder*, set your view. If you
have set up your preferences according to *iOS - Getting Started*, you
have already registered your *View*. If you have not done yet, please
refer to the following.

{% page-ref page="../ios/ios-getting-start.md" %} {% endtab %} {%
endtabs %}

Please refer to the following for the details.

{% page-ref page="../web/web-view.md" %}

{% page-ref page="../android/android-view.md" %}

{% page-ref page="../ios/ios-view.md" %}

### Making a call

If there is no channel corresponding to the *channelId* passed to the
*connectChannel ()* function, the channel is created and the other party
is waiting for connecting to the channel. At this time, when the other
party tries to connect with the *channelId*, the connection is
established successfully and the communication starts.

{% tabs %} {% tab title="Web" %}

    // <video id="localVideo" autoplay muted></video>
    // <video id="remoteVideo" autoplay></video>
    let myChid
    ​
    const config = {
      credential: {
        serviceId: 'MY_SERVICE_ID',
        key: 'MY_SERVICE_KEY'
      },
      view: {
        local: '#localVideo',
        remote: '#remoteVideo'
      }
    }
    ​
    const listener = {
      onConnect(channelId) {
        myChannelId = channelId
      },
      onComplete() {
        // Do something
      }
    }
    ​
    const caller = new Remon({ listener, config })
    caller.connectCall()

{% endtab %}

{% tab title="Android" %}

    caller = RemonCall.builder()
        .serviceId("MY_SERVICE_ID")
        .key("MY_SERVICE_KEY")
        .context(CallActivity.this)
        .localView(surfRendererLocal)
        .remoteView(surfRendererRemote)
        .build();
    ​
    caller.onConnect((channelId) -> {
        myChannelId = channelId  // Callee need chid from Caller for connect
    });
    ​
    caller.onComplete(() -> {
        // Caller-Callee connect each other. Do something
    });

    caller.connect();

{% endtab %}

{% tab title="iOS" %}

    let caller = RemonCall()

    caller.onConnect { (channelId) in
        let myChannelId = channelId          // Callee need channelId from Caller for connect
    }

    caller.onComplete {
        // Caller-Callee connect each other. Do something
    }

    caller.connect()

{% endtab %} {% endtabs %}

### Getting a call

Specify the *channelId* which the *connectChannel ()* function uses for
its connection. This makes the call connection simple.

{% tabs %} {% tab title="Web" %}

    // <video id="localVideo" autoplay muted></video>
    // <video id="remoteVideo" autoplay></video>
    const config = {
      credential: {
        serviceId: 'MY_SERVICE_ID',
        key: 'MY_SERVICE_KEY'
      },
      view: {
        local: '#localVideo',
        remote: '#remoteVideo'
      }
    }
    ​
    const listener = {
      onComplete() {
        // Do something
      }
    }
    ​
    const callee = new Remon({ listener, config })
    callee.connectCall('MY_CHANNEL_ID')

{% endtab %}

{% tab title="Android" %}

    callee = RemonCall.builder()
        .serviceId("MY_SERVICE_ID")
        .key("MY_SERVICE_KEY")
        .context(CallActivity.this)
        .localView(surfRendererLocal)
        .remoteView(surfRendererRemote)
        .build();

    callee.onComplete(() -> {
        // Caller-Callee connect each other. Do something
    });

    callee.connect("MY_CHANNEL_ID");

{% endtab %}

{% tab title="iOS" %}

    let callee = RemonCall()

    callee.onComplete {
        // Caller-Callee connect each other. Do something
    }

    callee.connect("MY_CHANNEL_ID")

{% endtab %} {% endtabs %}

### Callbacks

Callbacks are provided to assist in tracking various states during
development.

{% tabs %} {% tab title="Web" %}

    const listener = {
      onInit(token) {
        // Things to do when remon is initialized, such as UI processing, etc.
      },
    ​  
      onConnect(channelId) {
        // Wait or respond after call creation
      },
    ​
      onComplete() {
        // Start a call between the Caller and the Callee
      },
    ​  
      onClose() {
        // End the call

      }
    }

{% endtab %}

{% tab title="Android" %}

    remonCall = RemonCall.builder().build();

    remonCall.onInit((token) -> {
        // Things to do when remon is initialized, such as UI processing, etc.
    });
    ​
    remonCall.onConnect((channelId) -> {
        // Wait or respond after call creation
    });
    ​
    remonCall.onComplete(() -> {
        // Start a call between the Caller and the Callee
    });
    ​
    remonCall.onClose(() -> {
        // End the call
    });

{% endtab %}

{% tab title="iOS" %}

    let remonCall = RemonCall()

    remonCall.onInit { (token) in
        // Things to do when remon is initialized, such as UI processing, etc.
    }
    ​
    remonCall.onConnect { (channelId) in
        // If there is no pre-generated channel with the 'chid', wait until another user tries to connect with the 'chid'. 
    }
    ​
    remonCall.onComplete {
        // Start a call between the Caller and the Callee
    }
    ​
    remonCast.onClose {
        // End the call
    }

{% endtab %} {% endtabs %}

Please refer to the following for more information.

{% page-ref page="callbacks.md" %}

### Channel

For services such as Random Chat, you need a full channel list. Thus, a
full list of channels is provided.

{% tabs %} {% tab title="Web" %}

    const remonCall = new Remon()
    const calls = await remonCall.fetchCalls()

{% endtab %}

{% tab title="Android" %}

    remonCall = RemonCall.builder().build();

    remonCall.fetchCalls();
    remonCall.onFetch(calls -> {
        // Do something
    });

{% endtab %}

{% tab title="iOS" %}

    let remonCall = RemonCall()

    remonCall.fetchCalls { (error, results) in
        // Do something
    }

{% endtab %} {% endtabs %}

Please refer to the following for more information about channels.

{% page-ref page="channel.md" %}

### Termination

When all communication is finished, it is necessary to close the
*RemonCast* object with *close ()*. All communication resources and
media stream resources are released by *close ()*.

{% tabs %} {% tab title="Web" %}

    const remonCall = new Remon()
    remonCall.close()

{% endtab %}

{% tab title="Android" %}

    remonCall = RemonCall.builder().build();
    remonCall.close();

{% endtab %}

{% tab title="iOS" %}

    let remonCall = RemonCall()
    remonCall.close()

{% endtab %} {% endtabs %}

### Settings

If you need more detailed settings when creating or watching a
broadcast, please refer to the following.

{% page-ref page="config.md" %}
