---
description: Android로 간단한 통신 앱을 개발합니다.
---

# Android - Communication

## 기본 설정

방송을 하기 전에 프로젝트 설정을 진행 합니다.

{% page-ref page="android-getting-start.md" %}

## 개발

`RemonCall` 클래스는 통신을 위한 기능을 제공합니다. `RemonCall` 클래스의 `connectChannel()` 함수를 이용하여 통신 기능을 이용 할 수 있습니다.

전체적인 구성과 흐름은 아래를 참고하세요.

{% page-ref page="../overview/flow.md" %}

{% page-ref page="../overview/structure.md" %}

### View 등록

View구성에 따라 통신을 할 때에, 한 Activity에서 자신과 상대방의 Stream을 동시에 볼수도 있고, 각각 따로 구성 할 수도 있습니다. 때문에 미리 자신이 원하는 View에 다음과 같이 View를 추가합니다. `SurfaceViewRenderer`중 자기자신의 모습은 Local, 인터넷을 통해 온 상대방의 모습은 Remote로 구분됩니다.

```markup
<com.remotemonster.sdk.PercentFrameLayout
    android:id="@+id/perFrameLocal"
    android:layout_width="match_parent"
    android:layout_height="match_parent">
    <org.webrtc.SurfaceViewRenderer
        android:id="@+id/surfRendererLocal"
        android:layout_width="match_parent"
        android:layout_height="match_parent"/>
</com.remotemonster.sdk.PercentFrameLayout>

<com.remotemonster.sdk.PercentFrameLayout
    android:id="@+id/perFrameRemote"
    android:layout_width="match_parent"
    android:layout_height="match_parent">
    <org.webrtc.SurfaceViewRenderer
        android:id="@+id/surfRendererRemote"
        android:layout_width="match_parent"
        android:layout_height="match_parent"/>
</com.remotemonster.sdk.PercentFrameLayout>
```

추가적으로 View를 다루는 방법은 아래를 참고하세요.

{% page-ref page="android-view.md" %}

### RemonCall의 초간단 생성

* 이제 코딩의 시간입니다. Key와 ServiceID는 넣지 않아도 됩니다. 자동으로 테스트용 key와 serviceId로 설정됩니다. 나중에 본격적으로 Remote Monster를 사용하고 싶다면 회원가입을 하고 키를 발급받아서 입력하면 됩니다.
* RemonCall를 build할 때 여러가지 Config를 설정을 할 수 있습니다. 여기서는 일단 제일 간단한 방법으로 진행하겠습니다.
* 필요에 따라서는 영상통화가 아닌 음성통화만 사용하게 할 수도 있고 코덱을 바꾸거나 해상도를 바꿀 수도 있습니다.

{% code-tabs %}
{% code-tabs-item title="CallActivity.java" %}
```java
remonCall = RemonCall.builder()
        .context(CallActivity.this)
        .localView(surfRendererLocal)
        .remoteView(surfRendererRemote)
        .build();
```
{% endcode-tabs-item %}
{% endcode-tabs %}

### RemonCall Channel 생성 혹은 접속하기

* `RemonCall`클래스의 `connectChannel()` 함수를 이용하여 채널 생성 및 접속이 가능합니다.

  `connectChannel()` 함수에 전달한 `chid` 값에 해당하는 채널이 존재하지 않으면 채널이 생성되고, 다른 사용자가 해당 채널에 연결하기를 대기 하는 상태가 됩니다. 이때 해당 `chid`로 다른 사용자가 연결을 시도 하면 연결이 완료 되고, 통신이 시작 됩니다.

{% code-tabs %}
{% code-tabs-item title="CallActivity.java" %}
```java
remonCall.connectChannel("channelId");
```
{% endcode-tabs-item %}
{% endcode-tabs %}

* 자신이 생성한 channel은 `getId()`를 통해 알 수있습니다. 

{% hint style="info" %}
`connectChannel`함수에 `RemonConfig`를 직접 전달 할 수도있습니다.
{% endhint %}

### Callback

`Remon`은 방송 생성 및 시청 중에 상태 추적을 돕기 위한  Callback을 제공 합니다.

생성된 remonCall에 eventListener를 등록해 줍니다.

{% code-tabs %}
{% code-tabs-item title="CallActivity.java" %}
```java
remonCall.onInit(() -> Log("onInit"));
remonCall.onConnect(() -> Log("onConnect"));
remonCall.onComplete(() -> Log("onComplete"));
remonCall.onClose(() -> Log("onClose"));
remonCall.onError(e -> Log("error code : " + e.getRemonCode().toString()));
remonCall.onStat(report -> Log(report.getFullStatReport()));
```
{% endcode-tabs-item %}
{% endcode-tabs %}

좀 더 자세한 내용은 아래를 참고하세요.

{% page-ref page="../common/callbacks.md" %}

### Channel

랜덤채팅등과 같은 서비스에서는 전체 채널 목록을 필요로 하게 됩니다. 접속하려는 채널에 쉽게 접근 할 수 있도록 돕는 검색 기능을 제공 합니다.

```swift
remonCast.search { (error, results) in
    // Do something
}
```

채널에 대한 더 자세한 내용은 아래를 참고하세요.

{% page-ref page="../common/channel.md" %}

### 종료

모든 통신이 끝났을 경우 꼭 RemonCall객체를 `close()`해주어야 합니다. close를 통해서 모든 통신자원과 미디어 스트림 자원이 해제됩니다.

```java
remonCall.close();
```

### 설정

통신시 다양한 설정을 통해 원하는 형태로 구성이 가능합니다. 아래를 참고하세요.

{% page-ref page="../common/config.md" %}



