---
description: 상황에 맞는 기능을 개발할 수 있는 Callback 함수 사용법을 알려드립니다.
---

# Callbacks

## Overview

`RemonCast/RemonCall`로 매우 짧은 코드 만으로 통신 및 방송이 가능 합니다. 하지만 `Remon` 상태에 따라 UI처리 및 추가 작업이 필요한 경우가 발생 합니다. `Remon`은 SDK 사용자가 쉽게 `Remon`의 상태 변화를 추적 할 수 있도록 `Callback` 함수를 제공합니다. 각 함수에 해당되는 `Callback`을 적용시키면 됩니다.

전체적인 흐름은 아래를 참고하세요.

{% page-ref page="../overview/flow.md" %}

{% page-ref page="channel.md" %}

## Basics

### onInit\(\)

`onInit()`은  SDK가 인터넷을 통해 RemoteMonster 서버에 정상적으로 접속하여 RemoteMonster의 방송, 통신 인프라를 사용할 준비가 완료된 상태를 의미합니다. 대다수의 경우 사용할 일이 없으며 디버깅에 활용하게 됩니다. 

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

방송에서만 사용됩니다.  Caster가 createRoom을 통해 방송을 정상적으로 생성하여 송출이 될때입니다. 이후 곧바로 onComplete가 발생하지만, 시청자와 구분을 위해 가급적 방송생성은 onCreate를 사용하는것을 권장합니다.

onCreate는 인자로 chid를 넘겨줍니다. 이것은 이 방의 고유한 구분자로 시청자들이 이 chid를 통해 접속하여 방송을 보게 됩니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const listener = {
  onCreate(chid) {
    // Do something
  }
}

const rtc = new Remon({ listener })
rtc.createCast()
// Or 
rtc.createCast('chid')
```
{% endtab %}

{% tab title="Android" %}
```java
remonCast.onCreate(new RemonCast.onCreateCallback() {
    @Override
    public void onCreate(chid) {
        // Do something
    }
});

remonCast.createRoom();
// Or
remonCast.createRoom('chid');
```
{% endtab %}

{% tab title="iOS" %}
```swift
remonCast.onCreate { (chid) in
  // Do something
}

remonCast.createRoom()
// Or
remonCast.createRoom('chid')
```
{% endtab %}
{% endtabs %}

### onConnect\(chid\) - communication

통신에서만 사용됩니다.  Caller이거나 Callee일때 동작이 다를 수 있으며 이를 위해서 개발자가 상태를 스스로 관리해야 합니다.

Caller가 connectChannel을 통해 채널을 생성하면 생성됩니다. 이후 Callee가 채널에 접속하기 전까지  RemonState가 WAIT상태가 됩니다. 통화의 상대방을 기다린다는 의미입니다. 이때 connectChannel에서 chid를 지정하지 않으면, 자동으로 chid가 만들어집니다.

Callee는 connectChannel을 통해 이미 만들어진 채널에 접속하게 됩니다. 이때 만들어진 채널의 chid를 필수로 필요하게 됩니다. 정상적으로 완료되면 onConnect가 생기나, Callee라면 곧바로 발생하는 onComplete를 사용하는것을 권장합니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const listener = {
  onConnect(chid) {
    if (isCaller) {
      // Do something
    }
  }
}

const rtc = new Remon({ listener })
rtc.connectChannel()
// Or
rtc.connectChannel('chid')
```
{% endtab %}

{% tab title="Android" %}
```java
remonCall.onConnect(new RemonCall.onConnectCallback() {
    @Override
    public void onConnect(chid) {
      if (isCaller) {
        // Do something
      }
    }
});

remonCall.connectChannel();
// Or
remonCall.connectChannel("chid");
```
{% endtab %}

{% tab title="iOS" %}
```swift
remonCall.onConnect { (chid) in
   if isCaller {
     // Do something
   }
}

remonCast.connectChannel()
// Or
remonCast.connectChannel("chid")
```
{% endtab %}
{% endtabs %}

### onComplete\(\)

방송, 통신을 통틀어 연결이 완료 된후 미디어 전송이 가능해 졌을 때 호출 됩니다. 

방송에서 특히 Watcher거나 통신에서 특히 Callee라면 onComplete를 사용하는것을 권장합니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const listener = {
  onComplete(chid) {
    if (isWatcher || isCallee) {
      // Do something
    }
  }
}
```
{% endtab %}

{% tab title="Android" %}
```java
remonCast.onComplete(new RemonCast.onCompleteCallback() {
    @Override
    public void onComplete() {
        if (isWatcher || isCallee) {
            // Do something
        }
    }
});
```
{% endtab %}

{% tab title="iOS" %}
```swift
remonCast.onComplte {
  if (isWatcher || isCallee) {
    // Do something
  }
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
```
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
```javascript
const listener = {
  onClose() {
    // Do something
  }
}
```
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
    // Do something
}
```
{% endtab %}
{% endtabs %}

좀 더 자세한 내용은 아래를 참고하세요.

{% page-ref page="error-code.md" %}

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
    // Do something
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
       // Do something        
    }
});
```
{% endtab %}

{% tab title="iOS" %}
```swift
remonCall.onMessage { (msg)
    // Do something
}
remonCall.sendMessage("msg")
```
{% endtab %}
{% endtabs %}

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

{% endtab %}
{% endtabs %}

보다 더 자세한 내용은 아래를 확인하세요.

{% page-ref page="channel.md" %}

