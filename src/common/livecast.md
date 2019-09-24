# Livecast

## 기본 설정

방송을 하기 전에 각 플렛폼 별 프로젝트 설정을 진행 합니다.

## 개발

`RemonCast` 클래스는 방송 생성 및 시청을 위한 기능을 제공합니다. `RemonCast` 클래스의 `create()` 함수와 `join()` 함수를 이용하여 방송 기능을 이용 할 수 있습니다.

전체적인 구성과 흐름은 아래를 참고하세요.

{% page-ref page="../overview/flow.md" %}

{% page-ref page="../overview/structure.md" %}

### View 등록

방송 송출자가 스스로의 모습을 확인하거나, 시청자가 방송을 보기 위해서 실제 비디오가 그려지는 View를 정하고 연결해야 됩니다. 방송 송출자에게는 스스로가 보이도록 Local View를 등록 하고, 시청자에게는 송출자가 보이도록 Remote View를 등록합니다.

{% tabs %}
{% tab title="Web" %}
```markup
<!-- Caster : local view -->
<video id="localVideo" autoplay muted></video>
```

```markup
<!-- Viewer : remote view -->
<video id="remoteVideo" autoplay></video>
```
{% endtab %}

{% tab title="Android" %}
```markup
<!-- Caster : local view -->
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
<!-- Viewer : remote view -->
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

ConstraintLayout 과 같이 안드로이드에서 제공하는 레이아웃으로 구성할 수 있습니다.

```markup
<androidx.constraintlayout.widget.ConstraintLayout
    android:id="@+id/constraintLayout"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MainActivity">

    <!-- Remote -->
    <RelativeLayout
        android:id="@+id/layoutRemote"
        android:layout_width="0dp"
        android:layout_height="0dp"
        android:layout_margin="10dp"
        app:layout_constraintDimensionRatio="H,1:1.33"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toTopOf="parent"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintBottom_toBottomOf="parent"
        >
        <org.webrtc.SurfaceViewRenderer
            android:id="@+id/surfRendererRemote"
            android:layout_width="match_parent"
            android:layout_height="match_parent" />
    </RelativeLayout>
    
    <!-- Local -->
    <RelativeLayout
        android:id="@+id/layoutLocal"
        android:layout_width="80dp"
        android:layout_height="0dp"
        android:layout_margin="18dp"
        app:layout_constraintDimensionRatio="H,1:1.33"
        app:layout_constraintVertical_bias="0.1"
        app:layout_constraintTop_toTopOf="parent"
        app:layout_constraintRight_toRightOf="parent"
        app:layout_constraintBottom_toBottomOf="parent"
        >

        <org.webrtc.SurfaceViewRenderer
            android:id="@+id/surfRendererLocal"
            android:layout_width="match_parent"
            android:layout_height="match_parent"
            />
        <ImageView
            android:layout_width="match_parent"
            android:layout_height="match_parent"
            android:src="@drawable/remon_identity"
            android:scaleType="fitCenter"
            android:visibility="visible"
            />
    </RelativeLayout>
</androidx.constraintlayout.widget.ConstraintLayout>
```
{% endtab %}

{% tab title="iOS - Swift" %}
Interface Builder를 통해 지정 하게 되며 iOS - Getting Start에 따라 환경설정을 했다면 이미 View등록이 완료된 상태 입니다. 혹, 아직 완료가 안된 상태라면 아래를 참고하세요.

{% page-ref page="../ios/ios-getting-started.md" %}
{% endtab %}

{% tab title="iOS - ObjC" %}
Interface Builder를 통해 지정 하게 되며 iOS - Getting Start에 따라 환경설정을 했다면 이미 View등록이 완료된 상태 입니다. 혹, 아직 완료가 안된 상태라면 아래를 참고하세요.

{% page-ref page="../ios/ios-getting-started.md" %}
{% endtab %}
{% endtabs %}

보다 더 자세한 내용은 아래를 참고하세요.

{% page-ref page="../web/web-view.md" %}

{% page-ref page="../android/android-media.md" %}

{% page-ref page="../ios/ios-media.md" %}

### 방송생성

`RemonCast`의 `create()` 함수를 이용하여 방송 만들 수 있습니다. `create()` 함수가 호출 되면 `Remon`의 미디어 서버에다른 사용자들이 접속 할 수 있는 방송이 채널로써 만들어 지게 됩니다. 이때 채널이 만들어 지면서 `channelId`를 반환하게 되고, 이를 통해 시청자가 접근할 수 있습니다.

{% tabs %}
{% tab title="Web" %}
```javascript
// <video id="localVideo" autoplay muted></video>
let myChannelId

const config = {
  credential: {
    serviceId: 'MY_SERVICE_ID',
    key: 'MY_SERVICE_KEY'
  },
  view: {
    local: '#localVideo'
  },
  media: {
    sendonly: true
  }
}

const listener = {
  onCreate(channelId) {
    myChannelId = channelId
  }
}
​
const caster = new Remon({ listener, config })
caster.createCast()
```
{% endtab %}

{% tab title="Android - Java" %}
```java
caster = RemonCast.builder()
    .serviceId("MY_SERVICE_ID")
    .key("MY_SERVICE_KEY")
    .context(CastActivity.this)
    .localView(surfRendererlocal)        // local Video Renderer
    .build();

caster.onCreate((channelId) -> {
    myChannelId = channelId;
});

caster.create();
```
{% endtab %}

{% tab title="Android - Kotlin" %}
```kotlin
caster = RemonCast.builder()
    .serviceId("MY_SERVICE_ID")
    .key("MY_SERVICE_KEY")
    .context(CastActivity.this)
    .localView(surfRendererlocal)        // local Video Renderer
    .build()

caster.onCreate { channelId -> 
    myChannelId = channelId;
}

caster.create()
```
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
remonCast.create("MY_CHANNEL_ID")
```

혹은 아래와 같이 Interface Builder 없이 작성 가능합니다.

```swift
let caster = RemonCast()
caster.serviceId = "MY_SERVICE_ID"
caster.serviceKey = "MY_SERVICE_KEY"
caster.localView = localView

remonCast.onCreate { (channelId) in
    let myChannelId = caster.channelId
}

caster.create("MY_CHANNEL_ID")
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
[remonCast create:@"MY_CHANNEL_ID"];
```

Or you can create it without _Interface Builder_ as follows.

```objectivec
RemonCast *caster = [[RemonCast alloc]init];
caster.serviceId = @"MY_SERVICE_ID";
caster.serviceKey = @"MY_SERVICE_KEY";
caster.localView = localView;

[self.remonCast onCreateWithBlock:^(NSString * _Nullable chId) {
    [self.channelIdLabel setText:chId];
}];

[caster create:@"MY_CHANNEL_ID"];
```
{% endtab %}
{% endtabs %}

### 방송시청

`RemonCast`의 `joinRoom(channelId)` 함수를 이용하면 방송에 참여 할 수 있습니다. 이때 원하는 `channelId`를 알려줘야 하는데 보통 아래의 Channel을 참고하여 전체 목록을 통해 사용자가 선택하는 방식이 많이 사용됩니다.

{% tabs %}
{% tab title="Web" %}
```javascript
// <video id="remoteVideo" autoplay></video>
let myChannelId

const config = {
  credential: {
    serviceId: 'MY_SERVICE_ID',
    key: 'MY_SERVICE_KEY'
  },
  view: {
    local: '#remoteVideo'
  },
  media: {
    recvonly: true
  }
}

const listener = {
  onJoin() {
    // Do something
  }
}
​
const viewer = new Remon({ listener, config })
viewer.joinCast('MY_CHANNEL_ID')                  // myChnnelId from caster
```
{% endtab %}

{% tab title="Android - Java" %}
```java
viewer = RemonCast.builder()
    .serviceId("MY_SERVICE_ID")
    .key("MY_SERVICE_KEY")
    .context(ViewerActivity.this)
    .remoteView(surfRendererRemote)        // remote video renderer
    .build();
​
viewer.onJoin(() -> {});

viewer.join("MY_CHANNEL_ID");                     // myChid from caster
```
{% endtab %}

{% tab title="Android - Kotlin" %}
```kotlin
viewer = RemonCast.builder()
    .serviceId("MY_SERVICE_ID")
    .key("MY_SERVICE_KEY")
    .context(ViewerActivity.this)
    .remoteView(surfRendererRemote)        // remote video renderer
    .build()
​
viewer.onJoin{
}

viewer.join("MY_CHANNEL_ID")                     // myChid from caster
```
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
remonCast.join("MY_CHANNEL_ID")
```

혹은 아래와 같이 Interface Builder 없이 작성 가능합니다.

```swift
let viewer = RemonCast()
viewer.serviceId = "MY_SERVICE_ID"
viewer.key = "MY_SERVICE_KEY"
viewer.remoteView = remoteView

viewer.onJoin {
    // Do something
}

viewer.join("MY_CHANNEL_ID")
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```javascript
[remonCast join:@"MY_CHANNEL_ID"]
```

Or you can create it without _Interface Builder_ as follows.

```swift
RemonCast *caster = [[RemonCast alloc]init];
caster.serviceId = @"MY_SERVICE_ID";
caster.serviceKey = @"MY_SERVICE_KEY";
caster.localView = localView;

[self.remonCast onJoinWithBlock:^() {

}];

[caster join:@"MY_CHANNEL_ID"];
```
{% endtab %}
{% endtabs %}

### Callbacks <a id="observer"></a>

개발중 다양한 상태 추적을 돕기 위한 Callback을 제공 합니다. 

* 안드로이드 2.4.13, iOS 2.6.9 버전부터 콜백은 모두 UI Thread 에서 호출됩니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const listener = {
  onInit(token) {
    // UI 처리등 remon이 초기화 되었을 때 처리하여야 할 작업
  },
​  
  onConnect(channelId) {
    // 통화 생성 후 대기 혹은 응답
  },
​
  onComplete() {
    // Caller, Callee간 통화 시작
  },
​  
  onClose() {
    // 종료
  }
}
```
{% endtab %}

{% tab title="Android - Java" %}
```java
remonCast = RemonCast.builder().build();

// UI 처리등 remon이 초기화 되었을 때 처리하여야 할 작업
remonCast.onInit(() -> {
});
​
// 방송 생성
remonCast.onCreate((channelId) -> {
});
​
// 방송 참
remonCast.onJoin ( () -> {
});

// Caller, Callee간 통화 시작
remonCast.onComplete(() -> {
});
​
// 종료
remonCast.onClose(() -> {
});
```
{% endtab %}

{% tab title="Android - Kotlin" %}
```kotlin
remonCast = RemonCast.builder().build()

// UI 처리등 remon이 초기화 되었을 때 처리하여야 할 작업
remonCast.onInit {
}
​
// 방송 생성
remonCast.onCreate { channelId -> {
}
​
// 방송 참
remonCast.onJoin {
}

// Caller, Callee간 통화 시작
remonCast.onComplete {
}
​
// 종료
remonCast.onClose {
}
```
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
let remonCast = RemonCast()

remonCast.onInit { [weak self] in
    // UI 처리등 remon이 초기화 되었을 때 처리하여야 할 작업
}
​
remonCast.onCreate { [weak self](channelId) in
    // 해당 'chid'로 미리 생성된 채널이 없다면 다른 사용자가 해당 'chid'로 연결을 시도 할때 까지 대기 상태가 됩니다. 
}
​
remonCast.onJoin { [weak self] in
}

remonCast.onComplete { [weak self] in
    // Caller, Callee간 통화 시작
}
​
remonCast.onClose { [weak self](closeType) in
    // 종료
}
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
RemonCast *remonCast = [[RemonCast alloc] init];

[remonCast onInitWithBlock:^{
    // Things to do when remon is initialized, such as UI processing, etc.
}];

[remonCast onConnectWithBlock:^(NSString * _Nullable chId) {
    // Make a call then wait the callee
}];

[remonCast onJoinWithBlock:^{
}];

[remonCast onCompleteWithBlock:^{
    // Start between Caller and Callee
}];

[remonCast onCloseWithBlock:^{
    // End calling
}];
```
{% endtab %}
{% endtabs %}

더 많은 내용은 아래를 참조 하세요.​

{% page-ref page="callbacks.md" %}

### Channel 목록 조회

방송을 만들면 채널이 생성되고 고유한 `channelId`가 생성 됩니다. 이 `channelId`를 통해 시청자가 생성된 방송에 접근가능합니다. 이때 방송중인 전체 채널 목록을 아래와 같이 조회 가능합니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const remonCast = new Remon()
const casts = await remonCast.fetchCasts()
```
{% endtab %}

{% tab title="Android - Java" %}
```java
remonCast = RemonCast.builder().build();

remonCast.onFetch((casts) -> {
    // Do something
});

remonCast.featchCasts();
```
{% endtab %}

{% tab title="Android - Kotlin" %}
```kotlin
remonCast = RemonCast.builder().build()

remonCast.onFetch { casts ->
    // Do something
}

remonCast.featchCasts()

```
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
let remonCast = RemonCast()

remonCast.fetchCasts { (error, results) in
    // Do something
}
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
RemonCast *remonCast = [[RemonCast alloc]init];
 [remonCast fetchCastsWithIsTest:YES
                   complete:^(NSArray<RemonSearchResult *> * _Nullable chs) {
                        // Do something
                    }];
```
{% endtab %}
{% endtabs %}

더 자세한 내용은 아래를 참고하세요.

{% page-ref page="channel.md" %}

### 종료

방송의 송출, 시청이 끝났을 경우 꼭 `RemonCast`객체를 `close()`해주어야 합니다. close를 통해서 모든 방송 자원과 미디어 스트림 자원이 해제됩니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const remonCast = new Remon()
remonCast.close()
```
{% endtab %}

{% tab title="Android - Java" %}
```java
remonCast = RemonCast.builder().build();
remonCast.close();
```
{% endtab %}

{% tab title="Android - Kotlin" %}
```kotlin
remonCast = RemonCast.builder().build()
remonCast.close()
```
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
let remonCast = RemonCast()
remonCast.closeRemon()
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
RemonCast *remonCast = [[RemonCast alloc]init];
[remonCast closeRemon];
```
{% endtab %}
{% endtabs %}

### 기타

아래를 통해 보다 자세한 설정, 실 서비스를 위한 프렉티스등 다양한 내용을 확인해 보세요.

{% page-ref page="config.md" %}

{% page-ref page="network-environment.md" %}

