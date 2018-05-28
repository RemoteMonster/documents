---
description: 상황에 맞는 기능을 개발할 수 있는 Callback 함수 사용법을 알려드립니다.
---

# Callbacks

## Overview

`RemonCast/RemonCall`로 매우 짧은 코드 만으로 통신 및 방송이 가능 합니다. 하지만 `Remon` 상태에 따라 UI처리 및 추가 작업이 필요한 경우가 발생 합니다. `Remon`은 SDK 사용자가 쉽게 `Remon`의 상태 변화를 추적 할 수 있도록 `Callback` 함수를 제공합니다. 각 함수에 해당되는 `Callback`을 적용시키면 됩니다.

## Basics

### onInit\(\)

`onInit()`는 사용자가 통신 연결 시도를 하거나 방송 생성 및 시청을 시도 했을때 `Remon`이 해당 동작을 하기 위한 준비가 끝났을 때 호출 됩니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const listener = {
  onInit() {
     // Do something
  }
}

const rtc = new Remon({ listener })
```
{% endtab %}

{% tab title="Android" %}
```java
remonCast.onInit(new RemonCast.onInitCallback() {
    @Override
    public void onInit() {
        // Do something
    }
});
```
{% endtab %}

{% tab title="iOS" %}
```swift
remonCast.onInit {
    // Do something
}
remonCast.createRoom()
```
{% endtab %}
{% endtabs %}

### onCreate\(chid\) - livecast

만약 사용자가 방송을 생성 했다면 방송이 정상적으로 생성 되고, 방송 서버와 연결 되기 전단계에 호출 됩니다. 사용자가 1:1 통신을 시도 했다면 `onCreate()` 가 호출 된 이후 상대방을 기다리는 상태가 됩니다. 사용자가 방송을 생성 했다면 방송이 생성 되고 미디어 서버와 연결이 완료된 이 후에 호출 됩니다. 사용자가 1:1 통신을 채널을 생성 했다면 상대방과 통신 연결이 완료된 이후에 호출 됩니다.

{% tabs %}
{% tab title="Web" %}

{% endtab %}

{% tab title="Android" %}
```java
remonCast.onCreate(new RemonCast.onCreateCallback() {
    @Override
    public void onCreate() {
        //do something
    }
});
```
{% endtab %}

{% tab title="iOS" %}
```swift
remonCast.onCreate {
    // 이 블럭은 createRoom() 함수가 호출된 이후 싱행 되며, onInit가 구현 되어 있다면 onInit{}가 먼저 호출 될 것입니다.
}
remonCast.createRoom()
```

```swift
remonCall.onCreate {
    // 이 블럭은 createChannel() 함수가 호출된 이후에 실행 됩니다.이후 채널 Remon은 WAIT 상가 되며 상대방의 연결을 기다게 됩니다.
}
remonCall.connectChannel("chid")
```
{% endtab %}
{% endtabs %}

### onConnect\(chid\) - communication

사용자가 방송을 생성 했다면 방송이 생성 되고 미디어 서버와 연결이 완료된 이 후에 호출 됩니다. 사용자가 1:1 통신을 채널을 생성 했다면 상대방과 통신 연결이 완료된 이후에 호출 됩니다.

연결이 완료 된후 미디어 스트림 전송이 가능해 졌을 때 호출 됩니다. 사용자의 방송이 성공적으로 만들어 졌다면 `onInit` &gt; `onConnect` &gt; `onComplete` 가 순차적으로 호출 될 것입니다. 사용자가 1:1 통신을 시도 하였다면 상대방과 연결이 완료 되고 `onComplete`가 호출 될 것입니다.

{% tabs %}
{% tab title="Web" %}

{% endtab %}

{% tab title="Android" %}
```java
remonCast.onConnect(new RemonCast.onConnectCallback() {
    @Override
    public void onConnect() {
        // Do something
    }
});
```
{% endtab %}

{% tab title="iOS" %}
```swift
remonCast.onConnect {
    // 연결이 완료 된 상태에서 처리활 작업이 있다면 여기서 하세요.
    // 문제가 발생 하지 않는 다면 이 상태는 매우 짧을 것입니다.
}
remonCast.createRoom()
```

```swift
remonCast.onConnect {
    // onCreate() 가 호출 된 후에 대기 상태에서 상대방이 연결 되었다면 이 블럭이 실행 됩니다.
    // 연결이 완료 된 상태에서 처리활 작업이 있다면 여기서 하세요.
}
remonCast.joinRoom("chid")
```
{% endtab %}
{% endtabs %}

### onComplete\(\)

연결이 완료 된후 미디어 전송이 가능해 졌을 때 호출 됩니다. 사용자의 방송이 성공적으로 만들어 졌다면 `onInt` &gt; `onCreate` &gt; `onConnect` &gt; `onComplete` 가 순차적으로 호출 될 것입니다. 사용자가 1:1 통신을 시도 하였다면 상대방과 연결이 완료 되고 `onComplete`가 호출 될 것입니다.

{% tabs %}
{% tab title="Web" %}

{% endtab %}

{% tab title="Android" %}
```java
remonCast.onComplete(new RemonCast.onCompleteCallback() {
    @Override
    public void onComplete() {
        // Do something
    }
});
```
{% endtab %}

{% tab title="iOS" %}
```swift
remonCast.onComplte {
    // 모든 작업이 완료 되고, 영상 전송이 시작 됩니다!!!
}
remonCast.joinRoom("chid")
```
{% endtab %}
{% endtabs %}

### onClose\(\)

사용자가 명시적으로 `close()` 함수를 호출 하거나 상대방이 `close()`함수를 호출 했을때 또는 네트워크 이상 등으로 더이상 연결을 유지 하기 어려울 때 등 연결이 종료 되면 호출 됩니다.

사용자가 명시적으로 `close()` 함수를 호출 하거나 상대방이 `close()`함수를 호출 했을때 또는 네트워크 이상 등으로 더이상 연결을 유지 하기 어려울 때 등 연결이 종료 되면 호출 되며, `Remon`에서 사용했던 자원들 해제가 완료된 상태입니다.

{% tabs %}
{% tab title="Web" %}

{% endtab %}

{% tab title="Android" %}
```java
remonCast.onClose(new RemonCast.onCloseCallback() {
    @Override
    public void onClose() {
        // Do something
    }
});
```
{% endtab %}

{% tab title="iOS" %}
```swift
remonCast.onClose {
    // Do something
}
```
{% endtab %}
{% endtabs %}

### onErrror\(error\)

`Remon`이 동작 중에 에러가 발생 할때 호출 됩니다.

{% tabs %}
{% tab title="Web" %}

{% endtab %}

{% tab title="Android" %}
```java
remonCast.onError(new RemonCast.onErrorCallback() {
    @Override
    public void onError(RemonException remonException) {
        // Do something
    }
});
```
{% endtab %}

{% tab title="iOS" %}
```swift
remonCast.onError { (err)
    print(err.localizedDescription)
}
```
{% endtab %}
{% endtabs %}

## Advanced

### onStateChange\(state\)

최초 `Remon`객체를 만들고 방을 만들며 접속하고 접속에 성공하고 방송, 통신을 마칠 때까지의 모든 상태 변화에 대해 처리하는 메소드입니다. `RemonState` enum객체를 통해 어떤 상태로 변경되었는지를 알려줍니다. `RemonState`의 상태는 다음과 같습니다.

| 값 | 내용 | 비고 |
| --- | --- | --- | --- | --- | --- | --- |
| INIT | 시작 |  |
| WAIT | 채널 생성 |  |
| CONNECT | 채널, 방 접속 |  |
| COMPLETE | 연결 완료 |  |
| FAIL | 실패 |  |
| CLOSE | 종료 |  |

{% tabs %}
{% tab title="Web" %}

{% endtab %}

{% tab title="Android" %}

{% endtab %}

{% tab title="iOS" %}
N/A
{% endtab %}
{% endtabs %}

### onStat\(report\)

통신 / 방송 상태를 알수있는 `report`를 받습니다. `report`는 사용자가 `remon` 생성시 설정한 `statInterval`간격 마다 들어오게 됩니다.

{% tabs %}
{% tab title="Web" %}

{% endtab %}

{% tab title="Android" %}
```java
remonCast.onStat(new RemonCast.onStatCallback() {
    @Override
    public void onStat(RemonStatReport statReport) {
        //do something
    }
});
```
{% endtab %}

{% tab title="iOS" %}
```swift
let remonCall = RemonCall()
remoCall.onRemonStatReport{ (stat) in 
    let rating = stat.getRttRating()
    //do something
}
```
{% endtab %}
{% endtabs %}

보다 더 자세한 내용은 아래를 확인하세요.

{% page-ref page="qulity-status.md" %}

### onMessage\(message\)

`Remon`은 연결이 완료된 이후에 간단한 메세지 전송 기능을 지원 합니다. 상대방으로 부터 메세지가 전달 되었을 때 호춯 됩니다.

{% tabs %}
{% tab title="Web" %}

{% endtab %}

{% tab title="Android" %}
```java
remonCast.onMessage(new RemonCast.onMessageCallback() {
    @Override
    public void onMessage(String var1, String var2) {
       //do something        
    }
});
```
{% endtab %}

{% tab title="iOS" %}
```swift
remonCall.onMessage { (msg)
    print(msg)
}
remonCall.sendMessage("msg")
```
{% endtab %}
{% endtabs %}

보다더 자세한 내용은 아래를 확인하세요.

{% page-ref page="error-code.md" %}

### onSearch\(channels\)

현재 동일한 serviceId를 가진 방송 또는 통신을 검색결과를 받습니다. `RemonCast`의 경우에는 `RemonCast.searchRooms()`를 `RemonCall`의 경우에는 `RemonCall.searchCalls()`하면 검색을 하게 됩니다.

{% tabs %}
{% tab title="Web" %}

{% endtab %}

{% tab title="Android" %}
```java
remonCast.onSearch(new RemonCast.onSearchCallback() {
    @Override
    public void onSearch(List<Room> rooms) {
        //do something
    }
});
```
{% endtab %}

{% tab title="iOS" %}
N/A
{% endtab %}
{% endtabs %}

보다 더 자세한 내용은 아래를 확인하세요.

{% page-ref page="channel.md" %}

### onAddLocalStream\(stream\)

자기 자신의 카메라의 영상이 혹은 음성 스트림을 획득하였을 경우 호출됩니다.

### onAddRemoteStream\(stream\)

상대방의 영상이나 음성 스트림을 획득하였을 경우 호출됩니다. 연결이 되었음을 의미합니다.

{% page-ref page="qulity-status.md" %}

