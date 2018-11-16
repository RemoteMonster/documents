# Livecast

## ㄹ기본 설정

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
{% endtab %}

{% tab title="iOS" %}
Interface Builder를 통해 지정 하게 되며 iOS - Getting Start에 따라 환경설정을 했다면 이미 View등록이 완료된 상태 입니다. 혹, 아직 완료가 안된 상태라면 아래를 참고하세요.

{% page-ref page="../ios/ios-getting-started.md" %}
{% endtab %}
{% endtabs %}

보다 더 자세한 내용은 아래를 참고하세요.

{% page-ref page="../web/web-view.md" %}

{% page-ref page="../android/android-view.md" %}

{% page-ref page="../ios/ios-view.md" %}

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

{% tab title="Android" %}
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

{% tab title="Swift" %}
```swift
remonCast.create()
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

caster.create()
```
{% endtab %}

{% tab title="Objc" %}
```objectivec
[remonCast create:nil];
```

Or you can create it without _Interface Builder_ as follows.

```objectivec
RemonCast *caster = [[RemonCast alloc]init];
caster.serviceId = @"MY_SERVICE_ID";
caster.serviceKey = @"MY_SERVICE_KEY";
caster.localView = localView;

[self.remonCast onCreateWithBlock:^(NSString * _Nullable chId) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.channelIdLabel setText:chId];
    });
}];
[caster create:nil];
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

{% tab title="Android" %}
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

{% tab title="Swift" %}
```swift
remonCast.join(myChannelId)                  // myChannelId from caster
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

viewer.join("MY_CHANNEL_ID")              // myChannelId from caster
```
{% endtab %}

{% tab title="Objc" %}
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
{% endtabs %}

### Observer

개발중 다양한 상태 추적을 돕기 위한 Callback을 제공 합니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const listener = {
  onInit() {
    // UI 처리등 remon이 초기화 되었을 때 처리하여야 할 작업
  },
​  
  onCreate(channelId) {
    // 방송 생성 및 시청 준비 완료
  },
​
  onJoin() {
    // 시청 시작
  },
​  
  onClose() {
    // 종료
  }
}
```
{% endtab %}

{% tab title="Android" %}
```java
remonCast = RemonCast.builder().build();

remonCast.onInit(() -> {
    // UI 처리등 remon이 초기화 되었을 때 처리하여야 할 작업
});
​
remonCast.onCreate((channelId) -> {
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

remonCast.onCreate { (channelId) in
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

{% tab title="Objc" %}
```objectivec
RemonCast *caster = [[RemonCast alloc]init];
[caster onInitWithBlock:^{
    // Things to do when remon is initialized, such as UI processing, etc.
}];

[caster onCreateWithBlock:^(NSString * _Nullable chId) {
    // Broadcast creation and watching preparation is complete
}];

[caster onJoinWithBlock:^(NSString * _Nullable chId) {
    // Start watching
}];

[caster onCloseWithBlock:^{
    // End watching
}];
```
{% endtab %}
{% endtabs %}

더 많은 내용은 아래를 참조 하세요.

{% page-ref page="callbacks.md" %}

### Channel

방송을 만들면 채널이 생성되고 고유한 `channelId`가 생성 됩니다. 이 `channelId`를 통해 시청자가 생성된 방송에 접근가능합니다. 이때 방송중인 전체 채널 목록을 아래와 같이 조회 가능합니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const remonCast = new Remon()
const casts = await remonCast.fetchCasts()
```
{% endtab %}

{% tab title="Android" %}
```java
remonCast = RemonCast.builder().build();

remonCast.featchCasts();
remonCast.onFetch((casts) -> {
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

{% tab title="Objc" %}
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

{% tab title="Android" %}
```java
remonCast = RemonCast.builder().build();
remonCast.close();
```
{% endtab %}

{% tab title="iOS" %}
```swift
let remonCast = RemonCast()
remonCast.close()
```
{% endtab %}

{% tab title="Objc" %}
```objectivec
RemonCast *remonCast = [[RemonCast alloc]init];
[remonCast closeRemon:YES];
```
{% endtab %}
{% endtabs %}

### 기타

아래를 통해 보다 자세한 설정, 실 서비스를 위한 프렉티스등 다양한 내용을 확인해 보세요.

{% page-ref page="config.md" %}

{% page-ref page="workaround.md" %}

