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

{% tab title="iOS" %}
```swift
remonCast.onInit { (token) in
  // Do something
}
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

{% tab title="iOS" %}
```swift
remonCast.onCreate { (channelId) in
  // Do something
}

remonCast.create()               // Server generate chid
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

{% tab title="iOS" %}
```swift
remonCast.onJoin {
  // Do something
}

remonCast.join('MY_CHANNEL_ID')            // 'chid' is mandatory
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

{% tab title="iOS" %}
```swift
remonCall.onConnect { (channelId) in
     // Do something
}

remonCast.connect()
// Or
remonCast.connect("MY_CHANNEL_ID")
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

{% tab title="iOS" %}
```swift
remonCall.onComplte {
    // Do something
}
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

{% tab title="iOS" %}
```swift
remonCast.onClose {
    // Do something
}

remonCast.close()
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

{% tab title="iOS" %}
```swift
remonCast.onError { (error) in
    // Do something
}
```
{% endtab %}
{% endtabs %}

좀 더 자세한 내용은 아래를 참고하세요.

{% page-ref page="error-code.md" %}

## Advanced

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

{% tab title="iOS" %}
N/A
{% endtab %}
{% endtabs %}

### onStat\(report\)

통신 / 방송 상태를 알수있는 `report`를 받습니다. `report`는 사용자가 `remon` 생성시 설정한 `statInterval`간격 마다 들어오게 됩니다. 네트워크 상황등에 따른 미디어 품질을 나타냄으로 사용자에게 로딩 UI 처리등 안내를 하는데 유용합니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const listener = {
  onStat(result) {
    // Do something
  }
}
```
{% endtab %}

{% tab title="Android" %}
```java
remonCast.onStat((result) -> {
    // Do something
});
```
{% endtab %}

{% tab title="iOS" %}
```swift
let remonCall = RemonCall()
remoCall.onRemonStatReport{ (result) in 
    let rating = result.getRttRating()
    // Do something
}
```
{% endtab %}
{% endtabs %}

보다 더 자세한 내용은 아래를 확인하세요.

{% page-ref page="realtime-quality-statistics-report.md" %}

