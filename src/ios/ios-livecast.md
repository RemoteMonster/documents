---
description: 방송 서비스를 개발하는 방법을 안내합니다.
---

# iOS - Livecast

## 기본 설정

방송을 하기 전에 프로젝트 설정을 진행 합니다.

{% page-ref page="ios-getting-start.md" %}

## 개발

`RemonCast` 클래스는 방송 생성 및 시청을 위한 기능을 제공합니다. `RemonCast` 클래스의 `create()` 함수와 `join()` 함수를 이용하여 방송 기능을 이용 할 수 있습니다.

`RemonIBController`에 값을 직접 설정 않고, `create()`, `join()` 함수에 `RemonConfig`를 전달 할 수도 있습니다.

전체적인 구성과 흐름은 아래를 참고하세요.

{% page-ref page="../overview/flow.md" %}

{% page-ref page="../overview/structure.md" %}

### 방송생성

RemonCast의 create\(\) 함수를 이용하여 방송 만들 수 있습니다. create\(\) 함수가 호출 되면 Remon의  미디어 서버에다른 사용자들이 접속 할 수 있는 방송이 만들어 지게 됩니다.

```swift
remonCast.create()
```

혹은 아래와 같이 Interface Builder 없이 작성 가능합니다.

```swift
let caster = RemonCast()
caster.serviceId = "MyServiceID"
caster.serviceKey = "MyServiceKey"
caster.broadcast = true
caster.localView = localView
caster.create()

remonCast.onCreate { (chid) in
    let myChid = caster.channelID
}
```

### 방송시청

RemonCast의 joinRoom\(chid\) 함수를 이용하면 방송에 참여 할 수 있습니다.

```swift
remonCast.join(myChid)
```

혹은 아래와 같이 Interface Builder 없이 작성 가능합니다.

```swift
let watcher = RemonCast()
watcher.remoteView = remoteView
let config = RemonConfig()
config.serviceId = "MyServiceID"
config.key = "MyServiceKey"
config.channelType viewer
caster.join(config)
```

### Observer

개발중 다양한 상태 추적을 돕기 위한  Callback을 제공 합니다.

```swift
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

더 많은 내용은 아래를 참조 하세요.

{% page-ref page="../common/callbacks.md" %}

### Channels

방송을 시청 하기 위해서는 시청 하려는 chid가 필요 합니다. chid는 방송이 생성 될 때 마다 변경 되는 유니크 값입니다. 전체 채널 목록을 아래와 같이 조회 가능합니다.

```swift
remonCast.fetchRooms { (error, results) in
    // Do something
}
```

더 자세한 내용은 아래를 참고하세요.

{% page-ref page="../common/channel.md" %}

### 종료

모든 통신이 끝났을 경우 꼭 RemonCast객체를 `close()`해주어야 합니다. close를 통해서 모든 통신자원과 미디어 스트림 자원이 해제됩니다.

```java
remonCast.close()
```

### 설정

방송 생성, 시청시 좀 더 자세한 설정이 필요하다면 아래를 참고하세요.

{% page-ref page="../common/config.md" %}



