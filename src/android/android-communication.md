---
description: 통신 서비스를 개발하는 방법을 안내합니다.
---

# Android - Communication

## 기본 설정

방송을 하기 전에 프로젝트 설정을 진행 합니다.

{% page-ref page="android-getting-start.md" %}

## 개발

`RemonCall` 클래스는 통신을 위한 기능을 제공합니다. `RemonCall` 클래스의 `connect()` 함수를 이용하여 통신 기능을 이용 할 수 있습니다.

전체적인 구성과 흐름은 아래를 참고하세요.

{% page-ref page="../overview/flow.md" %}

{% page-ref page="../overview/structure.md" %}

### View 등록

View구성에 따라 통신을 할 때에, 한 Activity에서 자신과 상대방의 Stream을 동시에 볼수도 있고, 각각 따로 구성 할 수도 있습니다. 다음과 같이 View를 추가합니다. `SurfaceViewRenderer`중 자기자신의 모습은 Local, 인터넷을 통해 온 상대방의 모습은 Remote로 구분됩니다.

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

### 통화 걸기

`connect()` 함수에 전달한 `chid` 값에 해당하는 채널이 존재하지 않으면 채널이 생성되고, 다른 사용자가 해당 채널에 연결하기를 대기 하는 상태가 됩니다. 이때 해당 `chid`로 다른 사용자가 연결을 시도 하면 연결이 완료 되고, 통신이 시작 됩니다.

```java
remonCall = RemonCall.builder()
    .context(CallActivity.this)
    .localView(surfRendererLocal)
    .remoteView(surfRendererRemote)
    .build();

remonCall.onConnect(new RemonCall.onConnectCallbakc() {
    @Override
    public void onConnect(chid) {
        myChid = chid
    }
});

remonCall.connect();
```

이 때 Service Id와 Key 를 필요로 하게 되는데 아래를 참고하세요.

{% page-ref page="../common/service-key.md" %}

### 통화 받기

`connectChannel()` 함수에 접속을 원하는 chid값을 넣습니다. 이로서 간단하게 통화연결이 됩니다.

```java
remonCall.connect(myChid);
```

{% hint style="info" %}
`connectChannel`함수에 `RemonConfig`를 직접 전달 할 수도있습니다.
{% endhint %}

### Callbacks

개발중 다양한 상태 추적을 돕기 위한  Callback을 제공 합니다.

```java
remonCast.onInit(() -> {
    // UI 처리등 remon이 초기화 되었을 때 처리하여야 할 작업
});

remonCast.onConnect((chid) -> {
    // 통화 생성 후 대기 혹은 응답
});

remonCast.onComplete(() -> {
    // 통화 시작
});

remonCast.onClose(() -> {
    // 종료
});
```

더 많은 내용은 아래를 참조 하세요.

{% page-ref page="../common/callbacks.md" %}

### Channels

랜덤채팅등과 같은 서비스에서는 전체 채널 목록을 필요로 하게 됩니다. 아래와 같이 목록을 얻을 수 있습니다.

```swift
remonCall.fetchCalls();
remonCall.onFetch(calls -> {
    // Do something
});
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



