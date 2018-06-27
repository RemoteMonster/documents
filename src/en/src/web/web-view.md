Web - View
==========

Basic
-----

    <video id="remoteVideo" autoplay controls></video>
    <video id="localVideo" autoplay controls muted></video>

If you add the *Controls* attribute, you can add video controls.

For *Local Video*, you usually need to add the *muted* attribute to
eliminate the howling of your voice again.

Advanced
--------

    // Mute your own local video
    pauseLocalVideo(bool)
    // Mute the remote video
    pauseRemoteVideo(bool)
    // Mute the your own local audio and mic stream
    muteLocalAudio(bool)
    // Mute the remote audio stream
    muteRemoteAudio(bool)
