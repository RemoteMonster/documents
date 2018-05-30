# Android - Getting Start

## 준비사항

* 안드로이드 개발 환경
* minSdkVersion 18 이상
* java 1.8 이상

## 프로젝트 생성 및 설정

### 프로젝트 생성 및 API 레벨 설정

API Level 18이상으로 설정 합니다.

![](../.gitbook/assets/image.png)

### Compatibility 설정 

Open Module Settings에서 Source Compatibility, Target Compatibility를 1.8 이상으로 설정해줍니다.

![](../.gitbook/assets/image%20%284%29.png)

### Project Gradle 설정

build.gradle\(project:name\)의 allproject에 다음 주소를 입력합니다.

```groovy
allprojects {
    repositories {
        google()
        jcenter()
        maven { url 'https://demo.remotemonster.com/artifactory/libs-release-local' }
    }
}
```

이제 안드로이드 스튜디오를 동기화하면 자동으로 Remote Monster의 Android SDK를 다운로드 받게 됩니다.

### Module Gradle 설정

build.gradle\(Module:app\) 의 dependencies에 아래와 같이 추가합니다.

```groovy
dependencies {
    ...
    
    /* Remote monster WebRTC library */
    compile 'com.remotemonster.sdk:2.0.4'
}
```

### Permission 설정

안드로이드 최신 버전의 경우 앱의 권한에 대해 처음 앱 사용시 사용자에게 직접 묻게 됩니다. 처리해야할 권한은 다음과 같습니다.

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

## 개발

이제 모든 준비가 끝났습니다. 아래를 통해 세부적인 개발 방법을 확인하세요.

### Service Key

SDK를 통해 RemoteMonster 방송, 통신 인프라에 접근하려면, Service Id와 Key가 필요합니다. 간단한 테스트와 데모를 위해서라면 이 과정을 넘어가도 좋습니다. 실제 서비스를 개발하고 운영하기 위해서는 아래를 참고하여 Service Id, Key를 발급 받아 적용하도록 합니다.

{% page-ref page="../common/service-key.md" %}

### 방송

RemonCast Class는 방송 기능을 쉽고 빠르게 만들수있는 메소드를 제공합니다.

#### 방송 송출

{% code-tabs %}
{% code-tabs-item title="CastActivity.java" %}
```java
remonCast = RemonCast.builder()
        .context(CastActivity.this)
        .localView(surfRendererlocal)        // 자신 Video Renderer
        .serviceId("MyServiceId")
        .key("MyServiceKey")
        .build();
remonCast.create();
```
{% endcode-tabs-item %}
{% endcode-tabs %}

#### 방송 시청

{% code-tabs %}
{% code-tabs-item title="ViewerActivity.java" %}
```java
castViewer = RemonCast.builder()
        .context(ViewerActivity.this)
        .remoteView(surfRendererRemote)        // 방송자의 Video Renderer
        .serviceId("MyServiceId")
        .key("MyServiceKey")
        .build();
castViewer.join("channelId");              // 들어가고자 하는 channel
```
{% endcode-tabs-item %}
{% endcode-tabs %}

혹은 좀 더 자세한 내용은 아래를 참고하세요.

{% page-ref page="android-livecast.md" %}

### 통신

RemonCall Class는 통신기능을 쉽고 빠르게 만들수있는 메소드를 제공합니다.

```java
remonCall = RemonCall.builder()
        .context(CallActivity.this)        
        .localView(surfRendererLocal)        //나의 Video Renderer
        .remoteView(surfRendererRemote)      //상대방 video Renderer
        .serviceId("MyServiceId")
        .key("MyServiceKey")
        .build();
remonCall.connect("channelId")
```

혹은 좀 더 자세한 내용은 아래를 참고하세요.

{% page-ref page="android-communication.md" %}



