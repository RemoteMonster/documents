# Android SDK for live streaming - Getting Started

## 준비 사항
- 안드로이드 스마트폰 2개
- Android Studio 개발 환경
- 롤리팝 이상의 안드로이드 OS

## 세상에서 가장 쉬운 안드로이드 방송앱 개발
- 안드로이드에서 Remote Monster를 적용하려면 크게 다음과 같은 순서로 개발이 진행됩니다.
  1. Remote Monster Android SDK download center URL을 프로젝트 build.gradle 등록
  2. 모듈 build.gradle에 SDK 다운로드 설정
  3. AndroidMenifest.xml에 권한등의 설정
  4. Config file 생성
  5. Remon 객체 생성
  6. 방송자의 경우 Remon.createRoom, 시청자의 경우 Remon.joinRoom 실행
  7. Callback 메소드 처리하기
- 이제 하나씩 따라해봅시다. 예상 소요시간은 약 30분 입니다.

### 프로젝트 build.gradle에서 repository URL 설정
- 다음과 같이 Remote Monster가 제공하는 안드로이드 SDK repository URL을 등록합니다.
- 이 URL을 통해서 이전 버전의 Remote Monster SDK를 다운로드 받을 수도 있습니다.

```groovy
allprojects {
  repositories {
    jcenter()
    maven {
      url 'https://remotemonster.com/artifactory/libs-release-local'
    }
  }
}
```
- Java SDK는 8버전 이상이 필요합니다.
** ❗❗❗만약 빌드시 `failed to resolve: com.remon:remondroid:x.x.x`와 같은 에러가 나타난다면 [여기](http://community.remotemonster.com/t/topic/34/6?u=seunggi)를 참고하세요 ❗❗❗**
** 결론적으로 오래된 JDK가 새로운 루트 인증서를 인식 못하는 문제로 [최신 JDK](http://www.oracle.com/technetwork/java/javase/downloads/index.html)로 혹은 JDK 8u101 이상으로 업그레이드하면 됩니다 **


### module build.gradle을 수정하기
- 모듈 build.gradle dependencies 항목 마지막 라인에 다음과 같이 한 줄을 추가합니다.

```groovy
compile(group: 'com.remon', name: 'remondroid', version: '1.0.1')
```

- 이제 안드로이드 스튜디오를 동기화하면 자동으로 Remote Monster의 Android SDK인 remondroid를 다운로드 받게 됩니다.

### `AndroidManifest.xml`에 권한 추가
- 아래와 같이 Remondroid가 동작하기 위해 필요한 권한등을 추가합니다.

```xml
<uses-feature android:name="android.hardware.camera" />
<uses-feature android:name="android.hardware.camera2" />
<uses-feature android:name="android.hardware.camera.autofocus" />
<uses-feature android:name="android.hardware.camera.flash" />
<uses-feature android:glEsVersion="0x00020000" android:required="true" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.CHANGE_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.CHANGE_WIFI_STATE"/>
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.BLUETOOTH"/>
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN"/>
<uses-permission android:name="android.permission.BROADCAST_STICKY"/>
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
```

### local과 remote view를 layout에 추가
- 통화와 다르게 방송은 방송자와 시청자의 UX가 분리되는 경우가 많습니다. 때문에 별도의 Activity로 구현할 경우가 많겠죠. 아래 예제에서는 영상을 보여주는 SurfaceViewRenderer를 정의하는 xml파일입니다. PercentFrameLayout은 동적으로 다양한 비율로 화면 크기와 위치를 조절하는 레이아웃이며 실제 영상을 보여주는 뷰는 SurfaceViewRenderer입니다.

```xml
<com.remon.remondroid.PercentFrameLayout android:id="@+id/remote_video_layout"
 android:layout_width="match_parent"
 android:layout_height="match_parent">
 <org.webrtc.SurfaceViewRenderer
 android:id="@+id/remote_video_view"
 android:layout_width="wrap_content"
 android:layout_height="wrap_content" />
</com.remon.remondroid.PercentFrameLayout>
```

### Remon의 Config 객체 생성
- 이제 코딩의 시간입니다. 먼저 사전에 환경 설정을 할 필요가 있습니다. View가 시작될 때 다음과 같이 Config객체를 생성합니다. Key와 ServiceID는 넣지 않아도 됩니다. 자동으로 테스트용 key와 serviceId로 설정됩니다. 나중에 본격적으로 Remote Monster를 사용하고 싶다면 회원가입을 하고 키를 발급받아서 Config에 입력하면 됩니다.
- Config 객체를 통해 다양한 환경 설정을 할 수 있습니다. 여기서는 일단 앞서 설정한 Local, Remote View를 설정하였습니다.

```java
Config config = new com.remon.remondroid.Config();
//config.setKey("1234567890");
//config.setServiceId("SERVICEID1");
config.setLocalView((SurfaceViewRenderer) findViewById(R.id.local_video_view));
config.setRemoteView((SurfaceViewRenderer) findViewById(R.id.remote_video_view));
```

### Remon 객체 생성
- 이제 Remon 객체를 생성합니다. 주로 View 시작시에 먼저 객체를 생성할 것을 권합니다.
- Remon객체 생성시 앞서 설정하였던 Config객체를 인자로 넣어주고 기타 Observer는 그냥 다음에 설명하겠습니다.
- Observer는 Callback 클래스인데 굳이 넣고 싶지 않다면 RemonObserver를 new 해도 됩니다.

```java
// create channel
//remon = new Remon(MainActivity.this, config, new MyObserver());
remon = new Remon(MainActivity.this, config, new RemonObserver());
// 혹은
remon = new Remon(MainActivity.this, config);
remon.init(new RemonObserver());
```

### 방 만들기 혹은 시청하기
- 이제 방을 만들거나 이미 만들어진 방을 시청할 차례입니다. createRoom(name)은 방을 만드는 명령입니다. 또한 joinRoom(channelId)는 이미 만들어진 방에 접속하는 방법입니다. createRoom의 인자는 방의 닉네임입니다. id가 아닙니다. 방을 만들고 나면 Observer의 onCreate()메소드를 통해서 방의 실제 유일한 id인 채널 id를 발급받게 됩니다. 이 채널 id를 가지고 joinRoom때 쓰게 됩니다.

```java
// 방을 만들기
remon.createRoom(“myroom”);
// 방을 시청하기
remon.joinRoom("CH12322213213213123");
```

### onDestroy 처리
- 방송과 시청이 끝났을 경우 꼭 remon객체를 close해주어야 합니다. close를 통해서 모든 방송자원과 미디어 스트림 자원이 해제됩니다.

```java
remon.close();
```

### 권한에 대한 고객 확인창 처리
- 안드로이드 최신 버전의 경우 앱의 권한에 대해 처음 앱 사용시 사용자에게 직접 묻게 됩니다. 이를 위한 처리도 필요하겠죠.
- 안드로이드 개발자인 당신이 가장 선호하는 방식으로 이것을 처리하면 됩니다. 처리해야할 권한은 다음과 같습니다.

```java
public static final String[] MANDATORY_PERMISSIONS = {
  "android.permission.INTERNET",
  "android.permission.CAMERA",
  "android.permission.RECORD_AUDIO",
  "android.permission.MODIFY_AUDIO_SETTINGS",
  "android.permission.ACCESS_NETWORK_STATE",
  "android.permission.CHANGE_WIFI_STATE",
  "android.permission.ACCESS_WIFI_STATE",
  "android.permission.READ_PHONE_STATE",
  "android.permission.BLUETOOTH",
  "android.permission.BLUETOOTH_ADMIN",
  "android.permission.WRITE_EXTERNAL_STORAGE"
};
```

### RemonObserver 클래스 생성
- Remote Monster를 통해 오고가는 모든 방송과정의 이벤트를 수신할 필요가 있습니다. 이를 위해 RemonObserver에서 상속받은 별도의 Callback 클래스를 만들어봅시다.

```java
public class MyObserver extends RemonObserver {
  @Override
  public void onError(Throwable t) {
    super.onError(t);
  }
}
```

- RemonObserver를 통해 처리하면 좋은 메소드는 다음과 같습니다.
  - onStateChange: 최초 Remon객체를 만들고 방을 만들며 접속하고 접속에 성공하고 통신을 마칠 때까지의 모든 상태 변화에 대해 처리하는 메소드입니다. RemonState enum객체를 통해 어떤 상태로 변경되었는지를 알려줍니다. RemonState의 상태는 다음과 같습니다.
    - INIT(시작), WAIT(방 생성), CONNECT(방 접속), COMPLETE(방송 연결완료), FAIL(실패), CLOSE(종료)
  - onError: 통신 시도 중 장애 발생시 호출됩니다.
  - onAddLocalStream: 자기 자신의 카메라의 영상이 혹은 음성 스트림을 획득하였을 경우 호출됩니다.
  - onAddRemoteStream: 상대방의 영상이나 음성 스트림을 획득하였을 경우 호출됩니다. 연결이 되었다는 뜻이죠.
  - onSearch: Remon.search메소드를 통해 검색 결과를 받을 때 사용합니다