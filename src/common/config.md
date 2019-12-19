# Config/RemonConfig

## Overview

RemoteMonster는 RemonCall, RemonCast객체에 직접 설정 정보를 지정할 수 있습니다. 이러한 설정 정보들을 별도의 객체에 생성해 두고, RemonCall, RemonCast 객체 생성 후 해당 설정 값을 사용하고자 하는 경우 혹은 다른 화면에서 설정값을 지정한 뒤 방송,통신 화면으로 전달하는 경우에 `config`값을 사용할 수 있습니다.

RemonCall, RemonCast 의 connect\(\) 메쏘드 호출 시 config 정보를 함께 전달하게 되면, RemonCall, RemonCast 내부의 설정이 아닌 config 의 설정을 사용해 연결이 이루어집니다.

Android,Web 환경은 Config, iOS의 경우 RemonConfig 객체를 사용합니다.

## Basics

가장 기본적으로 화면이 보일 View와 Service Id, Key를 지정하는 것이 필요합니다. 

### View

영상이 표출될 View를 지정하는 설정으로 뷰가 지정되지 않으면 영상이 보이지 않습니다. \(iOS의 경우 View는 RemonConfig 에서 제공하지 않으므로, RemonCall, RemonCast 객체에 직접 지정해야 합니다.\)

{% tabs %}
{% tab title="Web" %}
```markup
<video id="remoteVideo" autoplay controls></video>
<video id="localVideo" autoplay controls muted></video>
<script>
  const config = {
    view: {
      remote: '#remoteVideo', local: '#localVideo'
    }
  }
</script>
```
{% endtab %}

{% tab title="Android - Java" %}
```java
Config config = new com.remotemonster.sdk.Config();
config.setLocalView((SurfaceViewRenderer) findViewById(R.id.local_video_view));
config.setRemoteView((SurfaceViewRenderer) findViewById(R.id.remote_video_view));
```
{% endtab %}

{% tab title="Android - Kotlin" %}
```kotlin
Config config = com.remotemonster.sdk.Config()
config.localView = ((SurfaceViewRenderer) findViewById(R.id.local_video_view))
config.remoteView = ((SurfaceViewRenderer) findViewById(R.id.remote_video_view))
```
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
let myRemoteView:UIView! = UIView()
let myLocalView:UIView! = UIView()
let remonCall = RemonCall()
remonCall.remoteView = myRemoteView
remonCall.localView = myLocalView
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
UIView *myRemoteView = [UIView new];
UIView *myLocalView = [UIView new];
RemonCall *remonCall = [[RemonCall alloc] init];
remonCall.remoteView = myRemoteView
remonCall.localView = myLocalView
```
{% endtab %}
{% endtabs %}

### Service Id, Key

Service Id, Key를 지정 하는 단계로 필수 입니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const config = {
  credential: {
    serviceId: 'myServiceId', key: 'myKey'
  }
}
```
{% endtab %}

{% tab title="Android - Java" %}
```java
Config config = new com.remotemonster.sdk.Config();
config.setServiceId("myServiceId");
config.setKey("myKey");
```
{% endtab %}

{% tab title="Android - Kotlin" %}
```kotlin
var config = com.remotemoster.sdk.Config()
config.serviceId = "serviceId"
config.key = "serviceKey"
```
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
let remonCall = RemonCall()
remonCall.serviceId = "myServiceId"
remonCall.serviceKey = "myServiceKey"
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
RemonCall *remonCall = [[RemonCall alloc] init];
remonCall.serviceId = @"myServiceId"
remonCall.serviceKey = @"myServiceKey"
```
{% endtab %}
{% endtabs %}

## Meta

사용자의 UID, 프로퍼티 등 서비스에 필요한 meta 데이터를 설정 할 수 있습니다. 안드로이드의 경우 HashMap 객체를 전달할 수 있으며, iOS 는 String 데이터만 지원합니다.

{% tabs %}
{% tab title="Web" %}
N/A
{% endtab %}

{% tab title="Android - Java" %}
```java
HashMap<String, Object> meta = new HashMap<>();
meta.put("uid", "lucas1234");

Config config = new com.remotemonster.sdk.Config();
config.setMeta( meta );
```
{% endtab %}

{% tab title="Android - Kotlin" %}
```kotlin
var meta = hashMapOf<String, Object>()
meta.put("uid", "myUid")

var config = com.remotemoster.sdk.Config()
config.meta = meta
```
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
let config:RemonConfig = RemonConfig()
config.userMeta = "string"
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```text
RemonConfig *config = [RemonConfig new];
config.userMeta = @"string";
```
{% endtab %}
{% endtabs %}

## Media

음성과 영상에 대한 보다 다양한 옵션이 제공됩니다.

각 플렛폼별 추가적인 설정은 아래를 참고하세요.

{% page-ref page="../web/web-view.md" %}

{% page-ref page="../android/android-media.md" %}

{% page-ref page="../ios/ios-media.md" %}

### Select Video, Audio

비디오를 키고 끔으로써 영상방송/통화 혹은 음성방송/통화 컨텐츠 서비스를 만들 수 있습니다.

{% tabs %}
{% tab title="Web" %}
```javascript
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
```
{% endtab %}

{% tab title="Android - Java" %}
```java
// Audio Only
config.setVideoCall(false);

// Audio, Video
config.setVideoCall(true);
```
{% endtab %}

{% tab title="Android - Kotlin" %}
```kotlin
// Audio Only
config.videoCall = false

// Audio, Video
config.videoCall = true
```
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
// Audio Only
remonCall.onlyAudio = true

// Audio, Video
remonCall.onlyAudio = false             //default fasle
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
// Audio Only
remonCall.onlyAudio = YES;

// Audio, Video
remonCall.onlyAudio = NO;             //default fasle
```
{% endtab %}
{% endtabs %}

### Video Options

`width`와 `height`는 상대편에게 보낼 영상의 해상도를 결정하는 것입니다. 최대 640, 480의 해상도로 보낼 것을 설정하였지만 이것이 꼭 지켜지는 것은 아닙니다. WebRTC는 기본적으로 네트워크나 단말의 상태에 따라 해상도와 `framerate`등을 유연하게 변화시키면서 품질을 유지하고 있기 때문입니다. 해상도가 실제와 차이가 날 수는 있지만 ratio는 최대한 맞추기 위해 노력합니다.

Browser는 H.264와 VP8, VP9등의 영상 코덱을 지원하고 있습니다. RemoteMonster는 H.264를 기본 코덱으로 사용하고 있으며 변경이 필요하다면 이 설정으로 변경할 수 있습니다.

`frameRate`항목은 1초에 몇번의 프레임으로 인코딩할 지를 결정합니다. 일반적인 영상통화에서는 15정도도 적당합니다.

`facingMode`는 기기의 앞과 뒤에 카메라가 있을 때 어떤 쪽의 카메라를 사용할 것인지를 결정하는 것입니다. 현재 모바일 버전의 크롬 브라우저에서는 `facingMode`가 제대로 동작하지 않습니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const config = {
  media: {
    video: {
      width: {max: '640', min: '640'},
      height: {max: '480', min: '480'},
      codec: 'H264',                 // 'VP9', 'VP8', 'H264'
      frameRate: {max:15, min:15},
      facingMode: 'user',             // 'user', 'environment'
      maxBandwidth: '3000'
    }
  }
}
```
{% endtab %}

{% tab title="Android - Java" %}
```java
config.setVideoWidth(640);
config.setVideoHeight(480);
config.setVideoCodec("VP8");  // 'VP9', 'VP8', 'H264'
config.setVideoFps(15);
```
{% endtab %}

{% tab title="Android - Kotlin" %}
```kotlin
config.videoWidth = 640
config.videoHeight = 480
config.videoCodec = "VP8"  // 'VP9', 'VP8', 'H264'
config.videoFps = 15
```
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
let remonCall = RemonCall()

remonCall.videoWidth = 640
remonCall.videoHeight = 480
remonCall.videoFps = 24
remonCall.videoCodec = "H264"
remonCall.useFrontCamera = true       // default true, 만약 false 라면 후면 카메라를 사용합니다.

// 로컬 비디오 전송 준비가 완료 되면 자동으로 로컬 비디오 캡쳐를 시작 합니다.
// 만약 이 값을 false로 설정 한다면 onComplete() 호출 이후에 startLocalVideoCapture()를 호출 하여야 합니다.
remonCall.autoCaptureStart = true     // default true
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
RemonCall *remonCall = [[RemonCall alloc] init];
​
remonCall.videoWidth = 640;
remonCall.videoHeight = 480;
remonCall.videoFps = 24;
remonCall.videoCodec = @"H264";
remonCall.useFrontCamera = YES;       // this is true by default, if this is false, use the rear camera.
// Start local video capture automatically when it is ready to transmit a local video.
// If you set this value to false, you must call startLocalVideoCapture() after the onComplete() call.
remonCall.autoCaptureStart = YES;     // default true
```
{% endtab %}
{% endtabs %}

### 오디오 타입 : Voice, Music 타입

오디오 관련 작동방식을 설정 할 수 있습니다. Voice 타입은 주변 소음을 제거하고 음성을 전달하는데 초점이 맞추어져 있으며 통화에 적합합니다. Music 타입은 모든 소리를 가공 없이 전달하는데 중점이 있습니다.

{% tabs %}
{% tab title="Web" %}
```text
let config = {
    media: {},
    rtc: {audioType: "music"}
};
```

기본 오디오 타입은 **VOICE** 입니다.
{% endtab %}

{% tab title="Android - Java" %}
```java
config.setAudioType( AudioType.VOICE );
```

 Builder에서 AudioType은 `AudioType.MUSIC`, `AudioType.VOICE` 두가지가 있습니다.

`RemonCall`의 default AudioType은 **VOICE**이며, `RemonCast`의 default는 **MUSIC**입니다.
{% endtab %}

{% tab title="Android - Kotlin" %}
```kotlin
config.audioType = AudioType.VOICE
```

Builder에서 AudioType은 `AudioType.MUSIC`, `AudioType.VOICE` 두가지가 있습니다.

`RemonCall`의 default AudioType은 **VOICE**이며, `RemonCast`의 default는 **MUSIC**입니다.
{% endtab %}

{% tab title="iOS - Swift" %}
iOS는 동적으로 해당기능을 제공하지 않으며 다음과 같이 설정하여야 합니다.

![](../.gitbook/assets/remonsettings%20%281%29.png)

`RemonSettings.plist` 파일을 프로젝트에 추가하고, AudioType 값을 원하는 모드로 변경해 주세요.
{% endtab %}

{% tab title="iOS - ObjC" %}
iOS는 동적으로 해당기능을 제공하지 않으며 다음과 같이 설정하여야 합니다.

![](../.gitbook/assets/remonsettings%20%281%29.png)

`RemonSettings.plist` 파일을 프로젝트에 추가하고, AudioType 값을 원하는 모드로 변경해 주세요.
{% endtab %}
{% endtabs %}

## Debug

`SILENT`, `ERROR`, `WARN`, `INFO`, `DEBUG`, `VERBOSE`를 설정할 수 있으며 뒤로 갈 수록 더 자세한 로그를 확인할 수 있습니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const config = {
  dev:{
    logLevel: 'INFO'
  }
}
```
{% endtab %}

{% tab title="Android - Java" %}
```java
config.setLogLevel(Log.DEBUG);
```
{% endtab %}

{% tab title="Android - Kotlin" %}
```kotlin
config.setLogLevel = Log.DEBUG
```
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
let remonCast = RemonCast()
remonCast.debugMode = true
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
RemonCall *remonCall = [[RemonCall alloc] init];
remonCall.debugMode = YES;
```
{% endtab %}
{% endtabs %}



