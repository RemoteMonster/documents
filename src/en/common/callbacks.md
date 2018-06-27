Callbacks
=========

Overview
--------

Only the simple code, *RemonCast* and *RemonCall,* can be used for
communication and broadcasting services. Occasionally, UI handling and
additional actions are required depending on your needs. Various
Callbacks can be used for more detailed development as shown below.

Broadcasting and communication have appropriate events and flows.
Knowing this will help you use *Callback*s. Please refer to the
following for the details.

{% page-ref page="../overview/flow.md" %}

{% page-ref page="channel.md" %}

Basics
------

### onInit(token)

*onInit ()* means the SDK is ready to use *RemoteMonster*\'s
broadcasting and communication infrastructure by successfully connecting
to the *RemoteMonster* server over the Internet. At this time, the
authentication information, *token*, is returned. In many cases, there
is no need for its use, and it is used for debugging.

{% tabs %} {% tab title="Web" %}

    const listener = {
      onInit(token) {
        // Do something
      }
    }

{% endtab %}

{% tab title="Android" %}

    remonCast.onInit(() -> {
        // Do something
    });

{% endtab %}

{% tab title="iOS" %}

    remonCast.onInit { (token) in
      // Do something
    }

{% endtab %} {% endtabs %}

### onCreate(channelId) - livecast

Only the caster uses this for the broadcasting service. At this time,
the broadcast which the caster creates with *createRoom* is normally
transmitted.

*onCreate* passes *channelId* as an argument. This is a unique
identifier of this room, where viewers will use this *channelId* for
connection and watch the broadcast.

{% tabs %} {% tab title="Web" %}

    const listener = {
      onCreate(channelId) {
        // Do something
      }
    }

    const cast = new Remon({ listener })
    cast.createCast()                          // Server generate chid

{% endtab %}

{% tab title="Android" %}

    remonCast.onCreate((channelId) -> {
        // Do something
    });

    remonCast.create();             // Server generate channelId

{% endtab %}

{% tab title="iOS" %}

    remonCast.onCreate { (channelId) in
      // Do something
    }

    remonCast.create()               // Server generate chid

{% endtab %} {% endtabs %}

### onJoin() - livecast

Only viewers use this in the broadcasting service. This will be called
when a viewer becomes able to watch media after he/she successfully
establishes a connection with *joinRoom*.

{% tabs %} {% tab title="Web" %}

    const listener = {
      onJoin(channelId) {
        // Do something
      }
    }

    const cast = new Remon({ listener })
    cast.joinCast('MY_CHANNEL_ID')                    // 'chid' is mandatory

{% endtab %}

{% tab title="Android" %}

    remonCast.onJoin(() ->
        // Do something
    });

    remonCast.join('MY_CHANNEL_ID');             // channelId is mandatory

{% endtab %}

{% tab title="iOS" %}

    remonCast.onJoin {
      // Do something
    }

    remonCast.join('MY_CHANNEL_ID')            // 'chid' is mandatory

{% endtab %} {% endtabs %}

### onConnect(channelId) - communication

This is used only for communication. This often behaves differently in
the following cases: the *Caller* who requests a call by actually
creating a channel, and the *Callee* that responds to the request by
accessing the created channel. In this case, the developer must manage
the caller-callee status.

The caller uses *connectChannel* to create a new channel and wait for
the other party to enter.

The *Callee* will connect to the channel that has already been created
by *connectChannel*. At this time, the *channelId* of the created
channel is required. If the connection is successful, *onConnect* will
be generated. It is recommended that the *Callee* use *onComplete*,
which occurs immediately.

{% tabs %} {% tab title="Web" %}

    const listener = {
      onConnect(channelId) {
        if (isCaller) {
          // Do something
        }
      }
    }

    const call = new Remon({ listener })
    call.connectCall()
    // Or
    call.connectCall('MY_CHANNEL_ID')

{% endtab %}

{% tab title="Android" %}

    remonCall.onConnect((channelId) -> {
        // Do something
    });

    remonCall.connect();
    // Or
    remonCall.connect("MY_CHANNEL_ID");

{% endtab %}

{% tab title="iOS" %}

    remonCall.onConnect { (channelId) in
         // Do something
    }

    remonCast.connect()
    // Or
    remonCast.connect("MY_CHANNEL_ID")

{% endtab %} {% endtabs %}

### onComplete() - communication

This is used for communication only. This will be called when media
transfer becomes possible after the connection between the *Caller* and
the *Callee* is successfully established.

{% tabs %} {% tab title="Web" %}

    const listener = {
      onComplete() {
        // Do something
      }
    }

{% endtab %}

{% tab title="Android" %}

    remonCall.onComplete(() -> {
        // Do something
    });

{% endtab %}

{% tab title="iOS" %}

    remonCall.onComplte {
        // Do something
    }

{% endtab %} {% endtabs %}

### onClose()

This is called when the user explicitly calls the *close ()* function or
when the other party calls the *close ()* function. This is also called
to terminate the connection when it is difficult to keep the connection
due to a network error. The resources used by *Remon* have already been
released.

{% tabs %} {% tab title="Web" %}

    const listener = {
      onClose() {
        // Do something
      }
    }

    const remon = new Remon({ listener })
    remon.close()

{% endtab %}

{% tab title="Android" %}

    remonCast.onClose(() -> {
        // Do something
    });

    remonCast.close();

{% endtab %}

{% tab title="iOS" %}

    remonCast.onClose {
        // Do something
    }

    remonCast.close()

{% endtab %} {% endtabs %}

### onError(error)

This is called when an error occurs while *Remon* is running.

{% tabs %} {% tab title="Web" %}

    const listener = {
      onError(error) {
        // Do something
      }
    }

{% endtab %}

{% tab title="Android" %}

    remonCast.onError((error) -> {
        // Do something
    });

{% endtab %}

{% tab title="iOS" %}

    remonCast.onError { (error) in
        // Do something
    }

{% endtab %} {% endtabs %}

Please refer to the following for the details.

{% page-ref page="error-code.md" %}

Advanced
--------

### onStateChange(state)

The method is used to handle all state changes in the following process:
creating the first *Remon* object, creating a room, connecting to the
room successfully, terminating the broadcasting and communication
service. The *RemonState Enum* object tells the state changes. This is
not generally used and is useful for debugging.

*RemonState* has the following states:

  Values     Description                    Remarks   
  ---------- ------------------------------ --------- --
  INIT       Initiate                                 
  WAIT       Create a Channel                         
  CONNECT    Channel, connect to the room             
  COMPLETE   Connection complete                      
  FAIL       Failed                                   
  CLOSE      End                                      

{% tabs %} {% tab title="Web" %}

    const listener = {
      onStateChange(state) {
        // Do something
      }
    }

{% endtab %}

{% tab title="Android" %} N/A {% endtab %}

{% tab title="iOS" %} N/A {% endtab %} {% endtabs %}

### onStat(report)

This is used for receiving a report of the communication/ broadcasting
status. Each *report* comes in every *statInterval* interval that you
have set when you create *remon*. Since it shows the media quality
according to the network situation, it is useful for guiding the user
through the handling of *loading a UI*.

{% tabs %} {% tab title="Web" %}

    const listener = {
      onStat(result) {
        // Do something
      }
    }

{% endtab %}

{% tab title="Android" %}

    remonCast.onStat((result) -> {
        // Do something
    });

{% endtab %}

{% tab title="iOS" %}

    let remonCall = RemonCall()
    remoCall.onRemonStatReport{ (result) in 
        let rating = result.getRttRating()
        // Do something
    }

{% endtab %} {% endtabs %}

Please refer to the following for the details.

{% page-ref page="stat-report.md" %}
