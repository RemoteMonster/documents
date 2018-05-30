---
description: 통신 서비스를 개발하는 방법을 안내합니다.
---

# iOS - Communication

## 기본 설정

통신을 하기 전에 프로젝트 설정을 진행 합니다.

{% page-ref page="ios-getting-start.md" %}

## 개발

통신을 기능은 이용하기 위해서는 `RemonCall` 클래스를 이용합니다. `RemonCall`클래스의 `connectChannel()` 함수를 이용하여 채널 생성 및 접속이 가능합니다. 

전체적인 구성과 흐름은 아래를 참고하세요.

{% page-ref page="../overview/flow.md" %}

{% page-ref page="../overview/structure.md" %}

### 통화 걸기

`connectChannel()` 함수에 전달한 `chid` 값에 해당하는 채널이 존재하지 않으면 채널이 생성되고, 다른 사용자가 해당 채널에 연결하기를 대기 하는 상태가 됩니다. 이때 해당 `chid`로 다른 사용자가 연결을 시도 하면 연결이 완료 되고, 통신이 시작 됩니다.

```swift
remonCall.connectChannel()

remonCall.onConnect { (chid) in
    let myChid = chid
}
```

### 통화 받기

`connectChannel()` 함수에 접속을 원하는 chid값을 넣습니다. 이로서 간단하게 통화연결이 됩니다.

```swift
remonCall.connectChannel(myChid)
```

### Observer

통신 기능을 해발 하다 보면 진행 상태를 알아야 하는 경우가 왕왕 발생 합니다. 이때는 `Remon`이 제공 하는 `Observer` 함수를 이용하면 쉽게 진행 상태를 추적할 수 있습니다.

```swift
remonCall.onInit {
    // UI 처리등 remon이 초기화 되었을 때 처리하여야 할 작업
}

remonCall.onConnect {
    // 해당 'chid'로 미리 생성된 채널이 없다면 다른 사용자가 해당 'chid'로 연결을 시도 할때 까지 대기 상태가 됩니다. 
}

remonCall.onComplete {
    // 통신 연결 완료. 영상 및 음성 전송이 시작 됩니다.
}

remonCast.onClose {
    // 종료
}
```

`Remon`은 `onInit()`와 `onConnect`, `onComplete` 이외에도 많은 `Observer` 함수를 제공 합니다. 더 많은 내용은 아래를 참조 하세요.

{% page-ref page="../common/callbacks.md" %}

### Channel

랜덤채팅등과 같은 서비스에서는 전체 채널 목록을 필요로 하게 됩니다. 접속하려는 채널에 쉽게 접근 할 수 있도록 돕는 검색 기능을 제공 합니다.

```swift
remonCall.search { (error, results) in
    // Do something
}
```

채널에 대한 더 자세한 내용은 아래를 참고하세요.

{% page-ref page="../common/channel.md" %}

### 종료

모든 통신이 끝났을 경우 꼭 RemonCast객체를 `close()`해주어야 합니다. close를 통해서 모든 통신자원과 미디어 스트림 자원이 해제됩니다.

```java
remonCall.close()
```

### 설정

방송 생성, 시청시 좀 더 자세한 설정이 필요하다면 아래를 참고하세요.

{% page-ref page="../common/config.md" %}



