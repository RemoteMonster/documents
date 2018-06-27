Error Code
==========

Overview
--------

The *RemoteMonster* APIs have two major exceptions: *Fail* and *Error*.

### Fail

*Fail* refers to an exception that mainly occurs during communication.
*Fail* occurs when the communication connection is not established, when
the connection is disconnected, or when the connection is unstable. You
can receive Fail events with the *onStateChange* callback method.

### Error

*Error* refers to an exception in a broader area, including *Fail*. You
will receive an Error code through the *onError* callback method.

#### InvalidParameterError

-   When a parameter given for *new Remon* is invalid

    -   If there is no *Key, Service Id, Local View, Remote View*, or if
        there is no *config* or *Callback*, or if the parameter is too
        long

-   An incorrect value is given at connectChannel (if the length is less
    than 1 or too long(100 or more))

-   `Unsupport``edPlatformError`

    -   If the Browser does not support

    -   If the Version does not support

#### InitFailedError

-   There is an error when returning a RESTful API

    -   500 Error

-   The signaling server is not operating

    -   Since the web server is running, it delivers the wrong page

-   The web server is not operating

    -   400 Error

-   There is a problem with the *Web Socket* and *RESTful* host

-   If an error occurs during the *Web Socket* startup

#### WebSocketError: websocket communication errors

-   Send Error

-   Receive Error

#### ConnectChannelFailedError

-   There is no channel information in the return of *create / connect*.

-   The server will automatically switch to *onCreateChannel* if there
    is an attempt to connect when the *channel* expires or when there is
    no channel.

#### BusyChannelError

-   The channel is already in use

#### UserMediaDeviceError

-   The media has not been imported, especially Camera (even though
    *Video* is turned on))

-   The *Video Capture* has not been imported.

#### ICE(Failed)Error

-   A *peerConnection* cannot be created

-   The SDP already exists, but its own SDP is created additionally

-   *There is an ICE*/*SDP* parsing or addition failure
