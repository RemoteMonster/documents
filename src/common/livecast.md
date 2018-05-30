# Livecast

## 기본 설정

방송을 하기 전에 각 플렛폼 별 프로젝트 설정을 진행 합니다.

{% page-ref page="../web/web-getting-start.md" %}

{% page-ref page="../android/android-getting-start.md" %}

{% page-ref page="../ios/ios-getting-start.md" %}

## 개발

`RemonCast` 클래스는 방송 생성 및 시청을 위한 기능을 제공합니다. `RemonCast` 클래스의 `create()` 함수와 `join()` 함수를 이용하여 방송 기능을 이용 할 수 있습니다.

전체적인 구성과 흐름은 아래를 참고하세요.

{% page-ref page="../overview/flow.md" %}

{% page-ref page="../overview/structure.md" %}

### View 등록

방송 송출자가 스스로의 모습을 확인하거나, 시청자가 방송을 보기 위해서 실제 비디오가 그려지는 View를 정하고 연결해야 됩니다. 방송 송출자에게는 스스로가 보이도록 Local View를 등록 하고, 시청자에게는 송출자가 보이도록 Remote View를 등록합니다.

{% tabs %}
{% tab title="Web" %}

{% endtab %}

{% tab title="Android" %}
```markup
<!-- Caster - local view -->
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

```markup
<!-- Watcher - remote view -->
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
{% endtab %}

{% tab title="iOS" %}
Interface Builder를 통해 지정 하게 되며 `iOS - Getting Start`에 따라 환경설정을 했다면 이미 View등록이 완료된 상태 입니다. 혹, 아직 완료가 안된 상태라면 아래를 참고하세요.

{% page-ref page="../ios/ios-getting-start.md" %}
{% endtab %}
{% endtabs %}

보다 더 자세한 내용은 아래를 참고하세요.

{% page-ref page="../web/web-view.md" %}

{% page-ref page="../android/android-view.md" %}

{% page-ref page="../ios/ios-view.md" %}

### 방송생성

RemonCast의 create\(\) 함수를 이용하여 방송 만들 수 있습니다. create\(\) 함수가 호출 되면 Remon의  미디어 서버에다른 사용자들이 접속 할 수 있는 방송이 만들어 지게 됩니다.

{% tabs %}
{% tab title="Web" %}

{% endtab %}

{% tab title="Android" %}
```java
caster = RemonCast.builder()
    .serviceId("MY_SERVICE_ID")
    .key("MY_SERVICE_KEY")
    .context(CastActivity.this)
    .localView(surfRendererlocal)        // local Video Renderer
    .build();
caster.create();
​
caster.onCreate(new RemonCast.onCreateCallback() {
    @override
    public void onCreate(String chid) {
        myChid = chid;
    }
});
```
{% endtab %}

{% tab title="iOS" %}
```swift
remonCast.create()
```

혹은 아래와 같이 Interface Builder 없이 작성 가능합니다.

```swift
let caster = RemonCast()
caster.serviceId = "MY_SERVICE_ID"
caster.serviceKey = "My_SERVICE_KEY"
caster.broadcast = true
caster.localView = localView

remonCast.onCreate { (chid) in
    let myChid = caster.channelId
}

caster.create()
```
{% endtab %}
{% endtabs %}

### 방송시청

RemonCast의 joinRoom\(chid\) 함수를 이용하면 방송에 참여 할 수 있습니다.

{% tabs %}
{% tab title="Web" %}

{% endtab %}

{% tab title="Android" %}
```java
watcher = RemonCast.builder()
    .serviceId("MY_SERVICE_ID")
    .key("MY_SERVICE_KEY")
    .context(ViewerActivity.this)
    .remoteView(surfRendererRemote)        // remote video renderer
    .build();
​
watcher.onJoin(new RemonCast.onJoinCallback() {
    @override
    public void onComplete() {
         // Do something
    }
});

watcher.join(myChid);
```
{% endtab %}

{% tab title="iOS" %}
```swift
remonCast.join(myChid)
```

혹은 아래와 같이 Interface Builder 없이 작성 가능합니다.

```swift
let watcher = RemonCast()
watcher.remoteView = remoteView
let config = RemonConfig()
config.serviceId = "MY_SERVICE_ID"
config.key = "MY_SERVICE_KEY"
config.channelType viewer

watcher.onJoin {
    // Do something
}

watcher.join(config)
```
{% endtab %}
{% endtabs %}

### Observer

개발중 다양한 상태 추적을 돕기 위한  Callback을 제공 합니다.

{% tabs %}
{% tab title="Web" %}

{% endtab %}

{% tab title="Android" %}
```java
remonCast = RemonCast.builder().build();

remonCast.onInit(() -> {
    // UI 처리등 remon이 초기화 되었을 때 처리하여야 할 작업
});
​
remonCast.onCreate((chid) -> {
    // 방송 생성 및 시청 준비 완료
});
​
remonCast.onJoin(() -> {
    // 시청 시작
});
​
remonCast.onClose(() -> {
    // 종료
});
```
{% endtab %}

{% tab title="iOS" %}
```swift
let remonCast = RemonCast()

remonCast.onInit {
    // UI 처리등 remon이 초기화 되었을 때 처리하여야 할 작업
}

remonCast.onCreate { (chid) in
    // 방송 생성 및 시청 준비 완료
}

remonCast.onJoin {
    // 시청 시작
}

remonCast.onClose {
    // 종료
}
```
{% endtab %}
{% endtabs %}

더 많은 내용은 아래를 참조 하세요.

{% page-ref page="callbacks.md" %}

### Channels

방송을 시청 하기 위해서는 시청 하려는 chid가 필요 합니다. chid는 방송이 생성 될 때 마다 변경 되는 유니크 값입니다. 전체 채널 목록을 아래와 같이 조회 가능합니다.

{% tabs %}
{% tab title="Web" %}

{% endtab %}

{% tab title="Android" %}
```java
remonCast = RemonCast.builder().build();

remonCast.featchCasts();
remonCast.onFetch(casts -> {
    // Do something
});
```
{% endtab %}

{% tab title="iOS" %}
```swift
let remonCast = RemonCast()

remonCast.fetchCasts { (error, results) in
    // Do something
}
```
{% endtab %}
{% endtabs %}

더 자세한 내용은 아래를 참고하세요.

{% page-ref page="channel.md" %}

### 종료

모든 통신이 끝났을 경우 꼭 RemonCast객체를 `close()`해주어야 합니다. close를 통해서 모든 통신자원과 미디어 스트림 자원이 해제됩니다.

{% tabs %}
{% tab title="Web" %}

{% endtab %}

{% tab title="Android" %}
```java
remonCast.close();
```
{% endtab %}

{% tab title="iOS" %}
```swift
remonCast.close()
```
{% endtab %}
{% endtabs %}

### 설정

방송 생성, 시청시 좀 더 자세한 설정이 필요하다면 아래를 참고하세요.

{% page-ref page="config.md" %}



