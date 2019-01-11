# Callbacks

## Overview

`RemonCast`, `RemonCall`의 간단한 코드 만으로 통신 및 방송이 가능 합니다. 사용자의 필요에 따라 UI처리 및 추가 작업이 필요한 경우가 발생 합니다. 아래의 다양한 Callback을 통해 보다 세부적인 개발이 가능합니다.

방송과 통신은 각각에 적합한 이벤트와 흐름을 가지고 있습니다. 이를 알아두면 Callback를 활용하는데 도움이 됩니다. 이에 대한 내용은 아래를 참고하세요.

{% page-ref page="../overview/flow.md" %}

{% page-ref page="channel.md" %}

## Basics

### onInit\(token\)

`onInit`은 SDK가 인터넷을 통해 RemoteMonster 서버에 정상적으로 접속하여 RemoteMonster의 방송, 통신 인프라를 사용할 준비가 완료된 상태를 의미합니다. 이때 인증 정보인 `token`을 돌려 받습니다. 대다수의 경우 사용할 일이 없으며 디버깅에 활용하게 됩니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const listener = {
  onInit(token) {
    // Do something
  }
}
```
{% endtab %}

{% tab title="Android" %}
```java
remonCast.onInit(() -> {
    // Do something
});
```
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
remonCast.onInit { (token) in
  // Do something
}
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
[remonCast onInitWithBlock:^{
    // Do something
}];
```
{% endtab %}
{% endtabs %}

### onCreate\(channelId\) - livecast

방송에서 송출자만 사용합니다. 송출자가 `create()`을 통해 방송을 정상적으로 생성하여 송출이 될때입니다.

`onCreate`는 인자로 `channelId`를 넘겨줍니다. 이것은 이 방의 고유한 구분자로 시청자들이 이 `channelId`를 통해 접속하여 방송을 보게 됩니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const listener = {
  onCreate(channelId) {
    // Do something
  }
}

const cast = new Remon({ listener })
cast.createCast()                          // Server generate chid
```
{% endtab %}

{% tab title="Android" %}
```java
remonCast.onCreate((channelId) -> {
    // Do something
});

remonCast.create();             // Server generate channelId
```
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
remonCast.onCreate { (channelId) in
  // Do something
}

remonCast.create()               // Server generate chid
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
[remonCast onCreateWithBlock:^(NSString * _Nullable chId) {
    // Do something
}];
```
{% endtab %}
{% endtabs %}

### onJoin\(\) - livecast

방송에서 시청자만 사용됩니다. 시청자가 `join()`을 통해 연결이 완료 된후 미디어 시청이 가능해 졌을 때 호출 됩니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const listener = {
  onJoin(channelId) {
    // Do something
  }
}

const cast = new Remon({ listener })
cast.joinCast('MY_CHANNEL_ID')                    // 'chid' is mandatory
```
{% endtab %}

{% tab title="Android" %}
```java
remonCast.onJoin(() ->
    // Do something
});

remonCast.join('MY_CHANNEL_ID');             // channelId is mandatory
```
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
remonCast.onJoin {
  // Do something
}

remonCast.join('MY_CHANNEL_ID')            // 'chid' is mandatory
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```javascript
const listener = {
  onJoin(channelId) {
    // Do something
  }
}

const cast = new Remon({ listener })
cast.joinCast('MY_CHANNEL_ID')                    // 'channelId' is mandatory
```
{% endtab %}
{% endtabs %}

### onConnect\(channelId\) - communication

통신에서만 사용됩니다. 실질적으로 채널을 만들어 통화를 요청하는 Caller이거나 만들어진 채널에 접속하여 요청에 응답하는 Callee일때의 동작을 달리 하는 경우가 많으며 위해서 개발자가 Caller, Callee여부에 대한 상태를 관리해야 합니다.

Caller는 `connect()`을 통해 채널을 새로 만들고 상대방이 입장하기를 기다립니다.

Callee는 `connect()`을 통해 이미 만들어진 채널에 접속하게 됩니다. 이때 만들어진 채널의 `channelId`를 필수로 필요하게 됩니다. 정상적으로 완료되면 `onConnect`가 생기나, Callee라면 곧바로 발생하는 `onComplete`를 사용하는것을 권장합니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const listener = {
  onConnect(channelId) {
    if (isCaller) {
      // Do something
    }
  }
}

const call = new Remon({ listener })
call.connectCall()
// Or
call.connectCall('MY_CHANNEL_ID')
```
{% endtab %}

{% tab title="Android" %}
```java
remonCall.onConnect((channelId) -> {
    // Do something
});

remonCall.connect();
// Or
remonCall.connect("MY_CHANNEL_ID");
```
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
remonCall.onConnect { (channelId) in
     // Do something
}

remonCast.connect()
// Or
remonCast.connect("MY_CHANNEL_ID")
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
[remonCall onConnectWithBlock:^(NSString * _Nullable chId) {
    // Do something
}];

[remonCall connect:@"MY_CHANNEL_ID" :nil];
```
{% endtab %}
{% endtabs %}

### onComplete\(\) - communication

통신에만 사용됩니다. 상호간 연결이 완료 된후 미디어 전송이 가능해 졌을 때 호출 됩니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const listener = {
  onComplete() {
    // Do something
  }
}
```
{% endtab %}

{% tab title="Android" %}
```java
remonCall.onComplete(() -> {
    // Do something
});
```
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
remonCall.onComplte {
    // Do something
}
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
[remonCall onCompleteWithBlock:^{
    // Do something
```
{% endtab %}
{% endtabs %}

### onClose\(\)

사용자가 명시적으로 `close()` 함수를 호출 하거나 상대방이 `close()`함수를 호출 했을때 또는 네트워크 이상 등으로 더이상 연결을 유지 하기 어려울 때 등 연결이 종료 되면 호출 되며, `Remon`에서 사용했던 자원들 해제가 완료된 상태입니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const listener = {
  onClose() {
    // Do something
  }
}

const remon = new Remon({ listener })
remon.close()
```
{% endtab %}

{% tab title="Android" %}
```java
remonCast.onClose(() -> {
    // Do something
});

remonCast.close();
```
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
remonCast.onClose {
    // Do something
}

remonCast.close()
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
[remonCast onCloseWithBlock:^{
    // Do something
}];
```
{% endtab %}
{% endtabs %}

### onError\(error\)

`Remon`이 동작 중에 에러가 발생 할때 호출 됩니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const listener = {
  onError(error) {
    // Do something
  }
}
```
{% endtab %}

{% tab title="Android" %}
```java
remonCast.onError((error) -> {
    // Do something
});
```
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
remonCast.onError { (error) in
    // Do something
}
```
{% endtab %}

{% tab title="iOS - ObjC" %}
N/A
{% endtab %}
{% endtabs %}

좀 더 자세한 내용은 아래를 참고하세요.

{% page-ref page="error.md" %}

### onRetry\(completed\) - Beta

`Remon` 이 동작 중에 네트워크 환경의 변경이 감지되면 재연결을 시도 합니다. 이 때 재연결 상태를 알려주는 `onRetry()` 함수가 호출 되며 재연결이 시도가 시작 될 때는 `completed` 값을 `false`로 호출 되고, 재연결이 완료 되면 `completed` 값을 `true`로 호출 됩니다. 만약 재연결 시도중 재연결이 실패 하거나 에러가 발생 한다면 `onRetry()`가 아닌 `onError()` 또는 `onClose()`가 호출 될 수도 있습니다.

{% tabs %}
{% tab title="Web" %}
N/A
{% endtab %}

{% tab title="Android" %}
N/A
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
self.remonCast.onRetry { (completed) in
    if completed {
        // 재연결이 완료 되었습니다.
        // 재연결 시도 중 실패가 발생 한다면 호출 되지 않을 수 있습니다.
    } else {
        // 재연결을 시도 합니다. 재연결이 시도가 시작 되면 항상 호출 됩니다.
    }
}
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
[self.remonCall onRetryWithBlock:^(BOOL completed) {
    if (completed) {
        // 재연결이 완료 되었습니다.
        // 재연결 시도 중 실패가 발생 한다면 호출 되지 않을 수 있습니다.
    } else {
        // 재연결을 시도 합니다. 재연결이 시도가 시작 되면 항상 호출 됩니다.
    }        
}];
```
{% endtab %}
{% endtabs %}

## Advanced

### onRemoteVideoSizeChanged\(view, size\)/onLocalVideoSizeChanged\(view, size\)

영상의 사이즈는 네트워크 상태에 따라 시시각각 변화 하며, 영상의 비율은 영상장치에 따라 다릅니다. 영상 송출자가 고정된 사이즈와 비율 보장해 주지 않는 환경이라면 `onRemoteVideoSizeChanged`와 `onLocalVideoSizeChanged` 함수를 구현 하여 변화 하는 영상크기에 반응 하도록 구현합니다.

{% tabs %}
{% tab title="Web" %}
N/A
{% endtab %}

{% tab title="Android" %}
N/A
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
let remonCall = RemonCall()
remonCall.onRemoteVideoSizeChanged {(view, size) in 
    let raito = size.height / size.width
    let oldSize = view.frame.size
    let newFrame = 
    CGRect(x: 0.0, y: 0.0, width: oldSize.width, height: oldSize.width * raito)
    view.frame = newFrame
}
```

아래의 링크를 통해 구체적인 응용 예시를 확인할 수 있습니다.

{% page-ref page="../ios/ios-media.md" %}
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
[self.remonCall onLocalVideoSizeChangedWithBlock:^(UIView * _Nullable view, CGSize size) {
        CGFloat raito = size.height / size.width;
        CGRect oldFrame = view.frame;
        CGSize oldSize = oldFrame.size;
        CGRect newFrame = CGRectMake(0, 0, oldSize.width, oldSize.width * raito);
        view.frame = newFrame;
    }];
```

아래의 링크를 통해 구체적인 응용 예시를 확인할 수 있습니다.

{% page-ref page="../ios/ios-media.md" %}
{% endtab %}
{% endtabs %}

### onStateChange\(state\)

최초 `Remon`객체를 만들고 방을 만들며 접속하고 접속에 성공하고 방송, 통신을 마칠 때까지의 모든 상태 변화에 대해 처리하는 메소드입니다. `RemonState` Enum객체를 통해 어떤 상태로 변경되었는지를 알려줍니다. 일반적으로는 사용되지 않으며 디버깅에 유용합니다.

`RemonState`의 상태는 다음과 같습니다.

| 값 | 내용 | 비고 |
| :--- | :--- | :--- |
| INIT | 시작 |  |
| WAIT | 채널 생성 |  |
| CONNECT | 채널, 방 접속 |  |
| COMPLETE | 연결 완료 |  |
| FAIL | 실패 |  |
| CLOSE | 종료 |  |

{% tabs %}
{% tab title="Web" %}
```javascript
const listener = {
  onStateChange(state) {
    // Do something
  }
}
```
{% endtab %}

{% tab title="Android" %}
N/A
{% endtab %}

{% tab title="iOS - Swift" %}
N/A
{% endtab %}

{% tab title="iOS - ObjC" %}
N/A
{% endtab %}
{% endtabs %}

### onStat\(report\)

통신 / 방송 상태를 알수있는 `report`를 받습니다. `report`는 사용자가 `remon` 생성시 설정한 `statInterval`간격 마다 들어오게 됩니다. 네트워크 상황등에 따른 미디어 품질을 나타냄으로 사용자에게 로딩 UI 처리등 안내를 하는데 유용합니다.

이때, 들어오는 값은 영상 및 음성 통화 중에 현재 통화의 품질이 어떠한지를 통합하여 1에서 5까지의 단계로 확인할 수 있습니다.

사용자는 간혹 자신 혹은 상대방의 네트워크 문제로 인하여 통화 품질이 안좋거나 끊어진 상황에서도 서비스의 문제라고 생각하고 불만을 제기할 수 있습니다. 때문에 사용자의 문제가 네트워크의 문제임을 사전에 알려주거나 다양한 UI 처리가 가능합니다.

현재 이 통화 품질 정보는 5초에 한번씩 받을 수 있습니다.

| 단계 | 품질 | 비고 |
| :--- | :--- | :--- |
| 1 | 매우 좋음 |  |
| 2 | 좋음 |  |
| 3 | 나쁨 |  |
| 4 | 매우 나쁨 |  |
| 5 | 방송, 통화 불능 |  |

{% tabs %}
{% tab title="Web" %}
```javascript
const listener = {
  onStat(result){
    const stat = `State: l.cand: ${result.localCandidate} /r.cand: ${result.remoteCandidate} /l.res: ${result.localFrameWidth} x ${result.localFrameHeight} /r.res: ${result.remoteFrameWidth} ${result.remoteFrameHeight} /l.rate: ${result.localFrameRate} /r.rate: ${result.remoteFrameRate} / Health: ${result.rating}`
    console.log(stat)
  }
}
```

`Remon` 객체를 생성할 때 입력 인자로 넣는 listener의 메소드 중 `onStat()` 을 구현하여 품질 정보를 받을 수 있습니다. 위의 `result`에서 받을 수 있는 여러 정보 중 `result.rating` 이 바로 네트워크 상황에 따른 통합적인 통화 품질 정보입니다.
{% endtab %}

{% tab title="Android" %}
```java
  @Override
  public void onStat(RemonStatReport report) {
      Logger.i(TAG, "report: " + report.getHealthRating());
      String stat = "health:" + report.getHealthRating().getLevel() + "\n";
  }
```

report에는 방송/통신의 상태를 알 수있는 여러가지 값들이 있습니다. `report.getHealthRating().getLevel()`을 통해 품질을 상태를 알 수도 있고, `report.getRemoteFrameRate()` / `report.getLocalFrameRate()`를 통해 해당 연결의 fps를 확인 할 수 있습니다.
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
let remonCall = RemonCall()
remoCall.onRemonStatReport{ (stat) in 
    let rating:RatingValue = stat.getRttRating()
    let level = rating.levle
}
self.showRemoteVideoStat = true //stat 정보가 영상 위에 오버레이 됩니다.
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
[self.remonCast onRemonStatReportWithBlock:^(RemonStatReport * _Nonnull stat) {
    RatingValue *rating = [stat getRttRating];
    // Do something
}];
```
{% endtab %}
{% endtabs %}

보다 더 자세한 내용은 아래를 확인하세요.

