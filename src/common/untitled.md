# Communication

##  기본 설정 {#undefined}

통신을 하기 전에 프로젝트 설정을 진행 합니다.​

{% page-ref page="../web/web-getting-start.md" %}

{% page-ref page="../android/android-getting-start.md" %}

{% page-ref page="../ios/ios-getting-start.md" %}

## 개발 {#undefined-1}

통신을 기능은 이용하기 위해서는 `RemonCall` 클래스를 이용합니다. `RemonCall`클래스의 `connect()` 함수를 이용하여 채널 생성 및 접속이 가능합니다.

전체적인 구성과 흐름은 아래를 참고하세요.​​

{% page-ref page="../overview/flow.md" %}

{% page-ref page="../overview/structure.md" %}

### View 등록

통화중 스스로의 모습을 보거나 상대방의 모습을 보기위한 뷰가 필요합니다. 자기 자신의 모습은 Local View, 상대방의 모습은 Remote View로 등록을 합니다.

{% tabs %}
{% tab title="Web" %}
```markup
<!-- local view -->
<video id="localVideo" autoplay muted></video>
<!-- remote view -->
<video id="remoteVideo" autoplay></video>
```
{% endtab %}

{% tab title="Android" %}
```markup
<!-- local view -->
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
<!-- remote view -->
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

{% page-ref page="../ios/ios-getting-start.md" %}
{% endtab %}
{% endtabs %}

보다 더 자세한 내용은 아래를 참고하세요.

{% page-ref page="../web/web-view.md" %}

{% page-ref page="../android/android-view.md" %}

{% page-ref page="../ios/ios-view.md" %}

### 통화 걸기

`connectChannel()` 함수에 전달한 `chid` 값에 해당하는 채널이 존재하지 않으면 채널이 생성되고, 다른 사용자가 해당 채널에 연결하기를 대기 하는 상태가 됩니다. 이때 해당 `chid`로 다른 사용자가 연결을 시도 하면 연결이 완료 되고, 통신이 시작 됩니다.

{% tabs %}
{% tab title="Web" %}
```javascript
// <video id="localVideo" autoplay muted></video>
// <video id="remoteVideo" autoplay></video>
let myChid
​
const config = {
  credential: {
    serviceId: 'MY_SERVICE_ID',
    key: 'MY_SERVICE_KEY'
  },
  view: {
    local: '#localVideo',
    remote: '#remoteVideo'
  }
}
​
const listener = {
  onConnect(chid) {
    myChid = chid
  },
  onComplete() {
    // Do something
  }
}
​
const caller = new Remon({ listener, config })
caller.connectCall()
```
{% endtab %}

{% tab title="Android" %}
```java
caller = RemonCall.builder()
    .serviceId("MY_SERVICE_ID")
    .key("MY_SERVICE_KEY")
    .context(CallActivity.this)
    .localView(surfRendererLocal)
    .remoteView(surfRendererRemote)
    .build();
​
caller.onConnect(new RemonCall.onConnectCallbakc() {
    @Override
    public void onConnect(chid) {
        myChid = chid  // Callee need chid from Caller for connect
    }
});
​
caller.onComplete(new RemonCall.onCompleteCallbakc() {
    @Override
    public void onComplete() {
        // Caller-Callee connect each other. Do something
    }
});

caller.connect();
```
{% endtab %}

{% tab title="iOS" %}
```swift
let caller = RemonCall()

caller.onConnect { (chid) in
    let myChid = chid          // Callee need chid from Caller for connect
}

caller.onComplete {
    // Caller-Callee connect each other. Do something
}

caller.connect()
```
{% endtab %}
{% endtabs %}

### 통화 받기 {#undefined-3}

`connectChannel()` 함수에 접속을 원하는 `chid`값을 넣습니다. 이로서 간단하게 통화연결이 됩니다.

{% tabs %}
{% tab title="Web" %}
```javascript
// <video id="localVideo" autoplay muted></video>
// <video id="remoteVideo" autoplay></video>
const config = {
  credential: {
    serviceId: 'MY_SERVICE_ID',
    key: 'MY_SERVICE_KEY'
  },
  view: {
    local: '#localVideo',
    remote: '#remoteVideo'
  }
}
​
const listener = {
  onComplete() {
    // Do something
  }
}
​
const callee = new Remon({ listener, config })
callee.connectCall()
```
{% endtab %}

{% tab title="Android" %}
```java
callee = RemonCall.builder()
    .serviceId("MY_SERVICE_ID")
    .key("MY_SERVICE_KEY")
    .context(CallActivity.this)
    .localView(surfRendererLocal)
    .remoteView(surfRendererRemote)
    .build();

callee.onComplete(new RemonCall.onCompleteCallbakc() {
    @Override
    public void onComplete() {
        // Caller-Callee connect each other. Do something
    }
});

callee.connect(myChid);
```
{% endtab %}

{% tab title="iOS" %}
```swift
let callee = RemonCall()

callee.onComplete {
    // Caller-Callee connect each other. Do something
}

callee.connect(myChid)
```
{% endtab %}
{% endtabs %}

### Callbacks {#observer}

개발중 다양한 상태 추적을 돕기 위한 Callback을 제공 합니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const listener = {
  onInit(token) {
    // UI 처리등 remon이 초기화 되었을 때 처리하여야 할 작업
  },
​  
  onConnect(chid) {
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

{% tab title="Android" %}
```java
remonCall = RemonCall.builder().build();

remonCall.onInit((token) -> {
    // UI 처리등 remon이 초기화 되었을 때 처리하여야 할 작업
});
​
remonCall.onConnect((chid) -> {
    // 통화 생성 후 대기 혹은 응답
});
​
remonCall.onComplete(() -> {
    // Caller, Callee간 통화 시작
});
​
remonCall.onClose(() -> {
    // 종료
});
```
{% endtab %}

{% tab title="iOS" %}
```swift
let remonCall = RemonCall()

remonCall.onInit { (token) in
    // UI 처리등 remon이 초기화 되었을 때 처리하여야 할 작업
}
​
remonCall.onConnect { (chid) in
    // 해당 'chid'로 미리 생성된 채널이 없다면 다른 사용자가 해당 'chid'로 연결을 시도 할때 까지 대기 상태가 됩니다. 
}
​
remonCall.onComplete {
    // Caller, Callee간 통화 시작
}
​
remonCast.onClose {
    // 종료
}
```
{% endtab %}
{% endtabs %}

더 많은 내용은 아래를 참조 하세요.​

{% page-ref page="callbacks.md" %}

### Channel {#channels}

랜덤채팅등과 같은 서비스에서는 전체 채널 목록을 필요로 하게 됩니다. 이를 위한 전체 채널 목록을 제공합니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const remonCall = new Remon()
const calls = await remonCall.fetchCalls()
```
{% endtab %}

{% tab title="Android" %}
```java
remonCall = RemonCall.builder().build();

remonCall.fetchCalls();
remonCall.onFetch(calls -> {
    // Do something
});
```
{% endtab %}

{% tab title="iOS" %}
```swift
let remonCall = RemonCall()

remonCall.fetchCalls { (error, results) in
    // Do something
}
```
{% endtab %}
{% endtabs %}

채널에 대한 더 자세한 내용은 아래를 참고하세요.​

{% page-ref page="channel.md" %}

### 종료 {#undefined-4}

모든 통신이 끝났을 경우 꼭 RemonCast객체를 `close()`해주어야 합니다. close를 통해서 모든 통신자원과 미디어 스트림 자원이 해제됩니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const remonCall = new Remon()
remonCall.close()
```
{% endtab %}

{% tab title="Android" %}
```java
remonCall = RemonCall.builder().build();
remonCall.close();
```
{% endtab %}

{% tab title="iOS" %}
```swift
let remonCall = RemonCall()
remonCall.close()
```
{% endtab %}
{% endtabs %}

### 설정 {#undefined-5}

방송 생성, 시청시 좀 더 자세한 설정이 필요하다면 아래를 참고하세요.​

{% page-ref page="config.md" %}



