---
description: 안드로이드에서 설정방법을 소개합니다.
---

# Config

## Config

* RemoteMonster는 객체 생성 전에 config값을 선행적으로 받습니다. 가장 단순하게는

  ```java
  Config config = new com.remon.remondroid.Config();
  config.setLocalView((SurfaceViewRenderer) findViewById(R.id.local_video_view));
  config.setRemoteView((SurfaceViewRenderer) findViewById(R.id.remote_video_view));
  ```

* 와 같이 영상을 출력할 video view를 설정하는 것만으로 RemoteMonster는 잘 알아듣고 config처리를 합니다. 하지만 실제 서비스를 위해서 RemoteMonster는 더 많은 설정값을 요구합니다. 이를테면 서비스 인증을 위한 키값을 요구합니다.

  ```java
  Config config = new com.remon.remondroid.Config();
  config.setServiceId("simpleapp");
  config.setKey("blahblah");
  ```

* 위와 같이 config는 view 항목뿐 아니라 인증값을 요구합니다. 따라서 되도록이면 홈페이지에서 별도의 인증키를 발급받으시는 것을 추천합니다. 이를 통해 더 나은 서비스를 제공받을 수 있습니다.
* key는 리모트몬스터로 부터 발급받는 비밀키입니다. serviceId는 여러분이 리모트몬스터에 서비스 가입을 할 때 입력하는 값입니다. 즉 당신의 id값이라고 보면 됩니다.
* 이제 이 config에 더하여 음성과 영상에 대한 보다 다양한 옵션을 살펴봅시다.

  ```java
  config.setVideoCall(true);
  ```

* 영상통신이 필요없고 음성통신만 필요한 경우에는 videoCall항목을 false로 합니다.

  ```java
  config.setVideoWidth(640);
  config.setVideoHeight(480);
  ```

* width와 height는 상대편에게 보낼 영상의 해상도를 결정하는 것입니다. 최대 640 480의 해상도로 보낼 것을 설정하였지만 이것이 꼭 지켜지는 것은 아닙니다. WebRTC는 기본적으로 네트워크나 단말의 상태에 따라 해상도와 framerate등을 유연하게 변화시키면서 품질을 유지하고 있기 때문입니다. HD급부터 QQVGA\(160x120\)급까지 다양한 해상도를 적용할 수 있습니다.

  ```java
  config.setVideoCodec("VP8");
  ```

* 영상통신시의 코덱을 결정합니다. H.264와 VP8, VP9등의 영상 코덱을 지원하고 있습니다. RemoteMonster는 H.264를 기본 코덱으로 사용하고 있으며 변경이 필요하다면 이 설정으로 변경할 수 있습니다.

  ```java
  config.setVideoFps(15);
  ```

* frameRate항목은 1초에 몇번의 frame으로 인코딩할 지를 결정합니다. 일반적인 영상통화에서는 15정도면 적당하지만 더 촘촘한 framerate를 원한다면 높여줄 수 있겠죠.

  ```java
  config.setSpeakerPhone("auto"|"true"|"false")
  ```

* Remon은 자동으로 사용자의 접근성을 감지하여 이어링모드로 할지 스피커폰모드로 할지 동적으로 변화합니다. 만약 이 기능을 해제하고 싶다면 false, 계속 유지하고 싶다면 true로 설정하세요.

```java
config.setLogLevel(Log.DEBUG);
```

* 마지막으로 로그레벨 설정입니다. ERROR, WARN, INFO, DEBUG, VERBOSE를 설정할 수 있으며 뒤로 갈 수록 더 자세한 로그를 확인할 수 있습니다.

