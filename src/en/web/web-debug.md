Web - Debug Inside
==================

WebRTC Internals
----------------

*webrtc-internals* is a great tool to tackle the issues that arise from
the *WebRTC* service. If you are unfamiliar with this tool, you can run
*webrtc-internals* by open a WebRTC session from your Chrome browser,
opening another tab, and typing *chrome://webrtc-internals/* in the URL
bar.

*webrtc-internals* can store *stats* information about ongoing
communication sessions in a large JSON file, and you can use it to look
at the details as follows:

Please refer to the following for its creation.

{% embed
data="{\"url\":\"https://testrtc.com/webrtc-internals-documentation/\",\"type\":\"link\",\"title\":\"The
Missing chrome://webrtc-internals Documentation •
testRTC\",\"description\":\"There's a wealth of information tucked into
the chrome://webrtc-internals tab, but there was up until recently very
little documentation about it. So we set out to solve that, and with the
assistance of Philipp Hancke wrote a series of articles on what you can
find in webrtc-internals and how to make use of it.
The...\",\"icon\":{\"type\":\"icon\",\"url\":\"https://testrtc.com/wp-content/uploads/2015/11/cropped-testRTC\_logo\_512x512-192x192.png\",\"width\":192,\"height\":192,\"aspectRatio\":1},\"thumbnail\":{\"type\":\"thumbnail\",\"url\":\"https://testrtc.com/wp-content/uploads/2016/12/201612-getstats.jpg\",\"width\":799,\"height\":420,\"aspectRatio\":0.5256570713391739}}"
%}

getUserMedia Requests
---------------------

The *constraints* passed through *getUserMedia* are recorded. The
detailed information is not available, and the brief information is
available.

RTCPeerConnection
-----------------

This is the most important interface to check the actual internal
information.

### Overview

From testRTC, Copyright 2018 testRTC

From testRTC, Copyright 2018 testRTC

1.  It tells you how RTCPeerConnection is set, which STUN and TURN
    servers are used, and how its options are set.

2.  The left-hand side shows a trace of *PeerConnection* object calls.
    That is, the methods of the *PeerConnection* object are listed in
    the order in which they are called, including its arguments (e.g.
    *createOffer*) and its callback events (e.g. *onicecandidate*). This
    is so powerful that it can be useful to check where and why ICE
    failures happen and to decide where you need to install a TURN
    server.

3.  It shows the statistics received from the *Stats Tables: getStats()*
    method.

4.  It shows graphs indicating the values of *getStats().* The
    *webrtc-internals* statistics are actually a bit different from the
    current standards because they follow the internal format of the
    Chrome browser. However, these statistics are not much different and
    become more close to the standards gradually.

### Get stats through the code

If you want to check statistics through the code/console rather than
*webrtc-internals*, you can do the following

    RTCPeerConnection.getStats(function(stats) { console.log(stats.result()); )};

The array values of the *RTCStatsReport* object consists of many
key-value pairs, as shown below

    RTCPeerConnection.getStats(function(stats) {
     var report = stats.result()[0];
     report.names().forEach(function(name) {
         console.log(name, report.stat(name));
     });
    )}

One of the important principles of reading these Report objects is that
the *key* name ending with an *Id* usually points to the *id* attribute
of another report object. Therefore, the structure shows that almost all
report objects are linked together. In addition, remember that most
values are represented as strings.

The most important attribute of *RTCStatsReport* is the *type* of each
*report*. Here are some of the important ones.

-   googTrack

-   googLibjingleSession

-   googCertificate

-   googComponent

-   googCandidatePair

-   localCandidate

-   remoteCandidate

-   ssrc

-   VideoBWE

Let\'s look at these reports one by one.

### googCertificate report

The *googCertificate report* contains information about the *DTLS
certificate* used by the local side and used for the certificate itself.
You can find out more about this in the [RTCCertificateStats
dictionary](https://w3c.github.io/webrtc-stats/#certificatestats-dict).

### googComponent report

The *googComponent* report acts as an adhesive between the certificate
statistics and the connection. That is, it contains a link to the
currently active candidate pair.

### googCandidatePair report

A *googCandidatePair* report covers a pair of ICE Candidates. This
report provides the following information:

-   The total number of packets and bytes sent and received (*bytesSent,
    bytesReceived, packetsSent; packetsReceived* is missing for unknown
    reason). By default, these are raw UDP or TCP bytes, including RTP
    headers.

-   The *googActiveConnection* entry tells you whether the connection is
    currently active. Most of the time, you\'ll only be interested in
    the statistics of the active candidate pair. You can find more
    information about this
    [here](https://w3c.github.io/webrtc-stats/#transportstats-dict).

-   The number of STUN requests sent and responses received
    (*requestsSent, responsesReceived, requestsReceived,
    responsesSent*). That is, the *count* indicates the number of
    incoming / outgoing STUN requests used in the ICE process.

-   You can the round trip time of the last STUN request with *googRtt*.
    This is different from *googRtt* in *ssrc report*.

-   *localCandidateId* and *remoteCandidateId* indicate the *id*s of the
    *localCandidate* and *remoteCandidate* objects.

-   *googTransportType* specifies the transfer type. It will usually be
    *udp* in most cases, but it can be *TURN over TCP* when a TURN
    server is used. When [ICE-TCP](https://webrtcglossary.com/ice-tcp/)
    is used, it will be set to *tcp*.

### localCandidate, remoteCandidate report

The *localCandidate* and *remoteCandidate* report allow you to check the
ip address, port number and type of the candidate.

### Ssrc report

The *ssrc* report is one of the most important ones. There is one for
each audio or video track sent and received via the *peerconnection*.
The standard separately defines it as
[*MediaStreamTrackStats*](https://w3c.github.io/webrtc-stats/#mststats-dict)
and
[*RTPStreamStats*](https://w3c.github.io/webrtc-stats/#streamstats-dict).
This report is affected by whether the media type is audio or video,
whether it is sent or received. Let\'s start with the common values.

-   *mediaType*: tells whether the media type is audio or video.

-   ssrc: indicates a unique value such as whether media is sent or
    received.

-   *googTrackId*: indicates the id of the track to which these
    statistics applies. This can also be found in the local or remote
    media stream tracks in SDP. In principle, anything with an *Id* at
    the end should point to a different report, but this is an
    exception.

-   *googRtt*: indicates the *round-trip time*, which is measured from
    *RTCP*.

-   *transportId*: indicates the component used to transmit this RTP
    stream. When Bundle is used, the same value will be assigned to both
    audio and video streams.

-   *googCodecName*: specifies the name of the codec: *opus, VP8, VP9,
    ​​H264,* etc. You can also check the codec implementation with
    *codecImplementationName stat*.

-   *bytesSent, bytesReceived, packetsSent, packetsReceived* (depends on
    whether the *ssrc* indicates sending or receiving): allow you to
    calculate *bitrates*. Since these numbers are cumulative, you must
    make the appropriate calculations with the time taken since the
    previous measurements made with *getStats*. The
    [sample](http://w3c.github.io/webrtc-pc/#example) code in the
    standard is quite nice, but keep in mind that you might end up with
    negative rates because Chrome sometimes resets these counter values.

-   *packetsLost*: indicates the number of lost packets. It is collected
    via RTCP for the sender and locally collected for the receiver. This
    is one of the most important values ​​indicating call quality.

-   

### Voice

-   For audio tracks, there are *audioInputLevel* and *audioOutputLevel*
    (these are called
    [audioLevel](https://w3c.github.io/webrtc-stats/#dom-rtcmediastreamtrackstats-audiolevel)
    in the standard). These values tell whether an audio signal comes
    from the microphone or the speaker. These are used to detect the
    Chrome [Audio Processing
    Bugs](https://bugs.chromium.org/p/webrtc/issues/detail?id=4799).

-   *googJitterReceived* and *googJitterBufferReceived*: provide
    information about the [amount of jitter
    received](https://webrtcglossary.com/jitter/) and the [jitter buffer
    state](https://webrtcglossary.com/jitter-buffer/).

### Video

-   *googNacksSent*: information about the number of
    [NACK](https://webrtcglossary.com/nack/) packets

-   *googPLIsSent*: information about the number of
    [PLI](https://webrtcglossary.com/pli/) packets

-   *googFIRsSent*: Information about the number of
    [FIR](https://webrtcglossary.com/fir/) packets

-   The above information helps you understand the impact of *packet
    loss* on video quality.

-   *googFrameWidthInput, googFrameHeightInput, googFrameRateInput*:
    indicate the input frame size and rate.

-   *googFrameWidthSent, googFrameHeightSent, googFrameRateSent*:
    indicate the frame size and rate sent over the physical network.

-   *googFrameWidthReceived, googFrameHeightReceived*: indicate the
    received frame size.

-   *googFrameRateReceived, googFrameRateDecoded, googFrameRateOutput*:
    indicate the frame rate received.

-   On the video encoder side, you can see the difference between these
    values ​​and see why the resolution of the image is lowered.
    Typically, this is usually caused by insufficient CPU or bandwidth.

-   The lowered frame rate can be observed by comparing
    *googFrameRateInput* and *googFrameRateSent*. In addition, you can
    see if the lowered resolution is caused by the CPU
    (*googCpuLimitedResolution* is *true*) or insufficient bandwidth
    (*googBandwidthLimitedResolution* is *true*) Information. Whenever
    any of these conditions changes, the *googAdaptionChanges* counter
    will be incremented.

-   We have artificially caused packet loss. On the response side,
    Chrome tries to lower the resolution at t = 184, where
    *googFrameWidthSent* and *googFrameWidthInput* become different. At
    t = 186, you can see that the input frame rate changes from *30fps*
    to near *zero (0)*.

### VideoBWE report

The *VideoBWE* report contains the bandwidth estimate. The following
information can be found in the report.

-   *googAvailableReceiveBandwidth*: The bandwidth available for the
    video data being received.

-   *googAvailableSendBandwidth*: The available bandwidth for the video
    data being transmitted.

-   *googTargetEncBitrate*: The target bitrate of the video encoder.
    This tries to maximize the use of available bandwidth.

-   *googActualEncBitrate*: The actual bitrate coming out of the video
    encoder. This should match the target bitrate.

-   *googTransmitBitrate*: The actual bitrate of transmission. If this
    is significantly different from *googActualEncBitrate*, this is
    probably due to [*forward error
    correction*](https://webrtcglossary.com/fec/).

-   *googRetransmitBitrate*: This allows measuring the bitrate of
    retransmission if RTX is used. This is useful for measuring packet
    loss.

-   *googBucketDelay*: A measure of Google\'s \"leaky bucket\" strategy
    associated with large frames. It does not matter much.
