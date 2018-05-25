# Config

## Basics

RemoteMonster는 객체 생성 전에 config값을 선행적으로 받습니다. 가장 단순하게는 화면이 보일 View와 Service Id, Key를 지정하는 것이 필요합니다.

### View

영상이 표출될 View를 지정하는 설정으로 필수적입니다.

{% tabs %}
{% tab title="Web" %}
```markup
  <video id="remoteVideo" autoplay controls></video>
  <video id="localVideo" autoplay controls muted></video>
```

controls 속성을 추가할 경우 영상에서 제어 컨트롤을 추가할 수 있습니다. local video 영상인 경우에는 보통 muted 속성을 추가하여 자기 음성이 다시 자기에게 들리는 하울링 현상을 없애야 합니다.

```javascript
  const config = {
    view: {
      remote: '#remoteVideo', local: '#localVideo'
    }
  }
```
{% endtab %}

{% tab title="Android" %}
```java
  Config config = new com.remotemonster.sdk.Config();
  config.setLocalView((SurfaceViewRenderer) findViewById(R.id.local_video_view));
  config.setRemoteView((SurfaceViewRenderer) findViewById(R.id.remote_video_view));
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
      serviceId: 'MyServiceId', key: 'myKey'}
  }
```
{% endtab %}

{% tab title="Android" %}
```java
  Config config = new com.remotemonster.sdk.Config();
  config.setServiceId("myServiceId");
  config.setKey("myKey");
```
{% endtab %}
{% endtabs %}

## Media

음성과 영상에 대한 보다 다양한 옵션이 제공됩니다.

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

{% tab title="Android" %}
```java
// Audio Only
config.setVideoCall(true);

// Audio, Video
config.setVideoCall(true);
```
{% endtab %}
{% endtabs %}

### Video Options

width와 height는 상대편에게 보낼 영상의 해상도를 결정하는 것입니다. 최대 640 480의 해상도로 보낼 것을 설정하였지만 이것이 꼭 지켜지는 것은 아닙니다. WebRTC는 기본적으로 네트워크나 단말의 상태에 따라 해상도와 framerate등을 유연하게 변화시키면서 품질을 유지하고 있기 때문입니다. 해상도가 실제와 차이가 날 수는 있지만 ratio는 최대한 맞추기 위해 노력합니다.

Browser는 H.264와 VP8, VP9등의 영상 코덱을 지원하고 있습니다. RemoteMonster는 H.264를 기본 코덱으로 사용하고 있으며 변경이 필요하다면 이 설정으로 변경할 수 있습니다.

frameRate항목은 1초에 몇번의 frame으로 인코딩할 지를 결정합니다. 일반적인 영상통화에서는 15정도면 적당하지만 더 촘촘한 framerate를 원한다면 높여줄 수 있겠죠.

facingMode는 기기의 앞과 뒤에 카메라가 있을 때 어떤 쪽의 카메라를 사용할 것인지를 결정하는 것입니다. 현재 모바일 버전의 크롬 브라우저에서는 facingMode가 제대로 동작하지 않습니다.

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
      facingMode: 'user'             // 'user', 'environment'
    }
  }
}
```
{% endtab %}

{% tab title="Android" %}
```java
config.setVideoWidth(640);
config.setVideoHeight(480);
config.setVideoCodec("VP8");  // 'VP9', 'VP8', 'H264'
config.setVideoFps(15);
```
{% endtab %}
{% endtabs %}

### Audio Options

동으로 사용자의 접근성을 감지하여 이어링모드로 할지 스피커폰모드로 할지 동적으로 변화합니다. 만약 이 기능을 해제하고 싶다면 false, 계속 유지하고 싶다면 true로 설정하세요.

{% tabs %}
{% tab title="Android" %}
```java
config.setSpeakerPhone("auto"); // auto, true, false
```
{% endtab %}
{% endtabs %}

## Debug

SILENT, ERROR, WARN, INFO, DEBUG, VERBOSE를 설정할 수 있으며 뒤로 갈 수록 더 자세한 로그를 확인할 수 있습니다.

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

{% tab title="Android" %}
```java
config.setLogLevel(Log.DEBUG);
```
{% endtab %}
{% endtabs %}

