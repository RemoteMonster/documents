---
description: Android로 간단한 방송 앱을 개발합니다.
---

# Android - Livecast

## 환경구성

아래를 참고하여 개발환경을 구성 하세요.

{% page-ref page="android-getting-start.md" %}

## 개발

`RemonCast` 클래스는 방송 생성 및 시청을 위한 기능을 제공합니다. `RemonCast` 클래스의 `createRoom()` 함수와 `joinRoom()` 함수를 이용하여 방송 기능을 이용 할 수 있습니다.

전체적인 구성과 흐름은 아래를 참고하세요.

{% page-ref page="../overview/flow.md" %}

{% page-ref page="../overview/structure.md" %}

### View 등록

layout.xml 에 RemoteMonster SDK가 제공하는 전용 View를 지정합니다. 

#### 방송 송출

자신의 모습이 보이는 Local View를 Layout에 추가합니다. 이 View는 카메라로부터 직접 가져오는 미디어를 보여주며, 실제 시청자가 볼 화면과는 네트워크상황이나 기타 여건에 의해 품질이 다르거나 시간차가 미세하게 다를 수 있습니다.

```markup
<com.remotemonster.sdk.PercentFrameLayout
    android:id="@+id/perFrameLocal"
    android:layout_width="match_parent"
    android:layout_height="match_parent">
    <org.webrtc.SurfaceViewRenderer
        android:id="@+id/surfRendererLocal"
        android:layout_width="match_parent"
        android:layout_height="match_parent" />
</com.remotemonster.sdk.PercentFrameLayout> 
```

#### 방송 시청

상대방의 모습이 보이는 Remote View를 Layout에 추가합니다.

```markup
<com.remotemonster.sdk.PercentFrameLayout
    android:id="@+id/perFrameRemote"
    android:layout_width="match_parent"
    android:layout_height="match_parent">
    <org.webrtc.SurfaceViewRenderer
        android:id="@+id/surfRendererRemote"
        android:layout_width="match_parent"
        android:layout_height="match_parent" />
</com.remotemonster.sdk.PercentFrameLayout>
```

#### 참고

추가적으로 View를 다루는 방법은 아래를 참고하세요.

{% page-ref page="android-view.md" %}

### 방송 생성

RemonCast의 createRoom\(\) 함수를 이용하여 방송 만들 수 있습니다. createRoom\(\) 함수가 호출 되면 Remon의 미디어 서버에다른 사용자들이 접속 할 수 있는 방송이 만들어 지게 됩니다. 이때 onCreate 콜백을 통해 만들어진 방의 chid를 가져 올 수 있습니다.

createRoom\(\) 호출시 인자값이 없으면 자동으로 chid를 생성해서 알려주고, 원하는 id를 입력하면 해당 id로 chid를 만들어서 반환합니다.

{% code-tabs %}
{% code-tabs-item title="CastActivity.java" %}
```java
remonCast = RemonCast.builder()
        .context(CastActivity.this)
        .localView(surfRendererlocal)        // local Video Renderer
        .serviceId("MyServiceId")
        .key("MyServiceKey")
        .build();
remonCast.createRoom();

remonCast.onCreate(new RemonCast.onCreateCallback() {
        @override
        public void onCreate(String chid) {
                myChannelId = chid;
        }
});
```
{% endcode-tabs-item %}
{% endcode-tabs %}

이 때 Service Id와 Key 를 필요로 하게 되는데 아래를 참고하세요.

{% page-ref page="../common/service-key.md" %}

### 방송 시청

방송 생성시 얻은 chid를 joinRoom\(\)에 인자값으로 주어 해당 채널에 접속합니다. 접속이 완료되면 onComplete가 발생되어 이때부터 View에서의 다양한 처리 등을 진행해 주면 됩니다.

{% code-tabs %}
{% code-tabs-item title="ViewerActivity.java" %}
```java
castViewer = RemonCast.builder()
        .context(ViewerActivity.this)
        .remoteView(surfRendererRemote)        // remote video renderer
        .serviceId("MyServiceId")
        .key("MyServiceKey")
        .build();
castViewer.joinRoom(myChannelId);

remonCast.onComplete(new RemonCast.onCompleteCallback() {}
        @override
        public void onComplete() {
                // Do something
        }
{)
```
{% endcode-tabs-item %}
{% endcode-tabs %}

### Callback

`Remon`은 방송 생성 및 시청 중에 상태 추적을 돕기 위한  Callback을 제공 합니다.

생성된 remonCast에 eventListener를 등록해 줍니다.

{% code-tabs %}
{% code-tabs-item title="CastActivity.java" %}
```java
remonCast.onInit(() -> Log("onInit"));
remonCast.onCreate(() -> Log("onCreate"));
remonCast.onComplete(() -> Log("onComplete"));
remonCast.onClose(() -> Log("onClose"));
remonCast.onError(e -> Log("error code : " + e.getRemonCode().toString()));
remonCast.onStat(report -> Log(report.getFullStatReport()));
```
{% endcode-tabs-item %}
{% endcode-tabs %}

자세한 내용은 아래를 참고하세요.

{% page-ref page="../common/callbacks.md" %}

### Channel

방송을 시청 하기 위해서는 시청 하려는 채널이 ID가 필요 합니다. 채널 ID는 방송이 생성 될 때 마다 변경 되는 유니크 값입니다. `Remon`는 시청 하려는 채널에 쉽게 접근 할 수 있도록 돕는 검색 기능을 제공 합니다.

채널에 대한 더 자세한 내용은 아래를 참고하세요.

{% page-ref page="../common/channel.md" %}

### 종료

모든 통신이 끝났을 경우 꼭 RemonCast객체를 `close()`해주어야 합니다. close를 통해서 모든 통신자원과 미디어 스트림 자원이 해제됩니다.

```java
remonCast.close();
```

### 설정

방송 생성과 시청시 다양한 설정을 통해 원하는 형태로 구성이 가능합니다. 아래를 참고하세요.

{% page-ref page="../common/config.md" %}



