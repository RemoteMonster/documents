# Web - View

## Basic

```markup
<video id="remoteVideo" autoplay controls></video>
<video id="localVideo" autoplay controls muted></video>
```

Controls 속성을 추가할 경우 영상에서 제어 컨트롤을 추가할 수 있습니다.

Local Video의 경우 보통 muted 속성을 추가하여 자기 음성이 다시 자기에게 들리는 하울링 현상을 없애야 합니다.

## Advanced

```javascript
// 자신의 영상을 mute하기
pauseLocalVideo(bool)
// 원격의 영상을 mute하기
pauseRemoteVideo(bool)
// 자신의 음성을 mute하기
muteLocalAudio(bool)
// 원격의 영상을 mute하기
muteRemoteAudio(bool)
```

