# iOS - Observer

## RemonController Observer

`Remon`으로 매우 짧은 코드 만으로 통신 및 방송이 가능 합니다. 하지만 `Remon` 상태에 따라 UI처리 및 추가 작업이 필요한 경우가 발생 합니다. `Remon`은 SDK 사용자가 쉽게 `Remon`의 상태 변화를 추적 할 수 있도록 `Observer` 함수를 제공합니다. 

### onInit\(\)

`onInit()`는 사용자가 통신 연결 시도를 하거나 방송 생성 및 시청을 시도 했을때 `Remon`이 해당 동작을 하기 위한 준비가 끝났을 때 호출 됩니다.

```swift
remonCast.onInit {
    // 이 블럭은 createRoom() 함수가 호출 된 이후에 실행 됩니다.
}
remonCast.createRoom()
```

### onCreate\(\)

만약 사용자가 방송을 생성 했다면 방송이 정상적으로 생성 되고, 방송 서버와 연결 되기 전단계에 호출 됩니다. 사용자가 1:1 통신을 시도 했다면 `onCreate()` 가 호출 된 이후 상대방을 기다리는 상태가 됩니다.

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

### onConnect\(\)

사용자가 방송을 생성 했다면 방송이 생성 되고 미디어 서버와 연결이 완료된 이 후에 호출 됩니다. 사용자가 1:1 통신을 채널을 생성 했다면 상대방과 통신 연결이 완료된 이후에 호출 됩니다.

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

### onComplete\(\)

연결이 완료 된후 미디어 전송이 가능해 졌을 때 호출 됩니다. 사용자의 방송이 성공적으로 만들어 졌다면 `onInt` &gt; `onCreate` &gt; `onConnect` &gt; `onComplete` 가 순차적으로 호출 될 것입니다. 사용자가 1:1 통신을 시도 하였다면 상대방과 연결이 완료 되고 `onComplete`가 호출 될 것입니다.

```swift
remonCast.onComplte {
    // 모든 작업이 완료 되고, 영상 전송이 시작 됩니다!!!
}
remonCast.joinRoom("chid")
```

### onClose\(\)

사용자가 명시적으로 `close()` 함수를 호출 하거나 상대방이 `close()`함수를 호출 했을때 또는 네트워크 이상 등으로 더이상 연결을 유지 하기 어려울 때 등 연결이 종료 되면 호출 됩니다.

```swift
remonCast.onClose {
    // remon이 닫혔습니다.
}
```

### onErrror\(\)

`Remon`이 동작 중에 에러가 발생 할때 호출 됩니다.

```swift
remonCast.onError { (err)
    print(err.localizedDescription)
}
```

### onMessage\(\)

`Remon`은 연결이 완료된 이후에 간단한 메세지 전송 기능을 지원 합니다. 상대방으로 부터 메세지가 전달 되었을 때 호춯 됩니다.

```swift
remonCall.onMessage { (msg)
    print(msg)
}
remonCall.sendMessage("msg")
```



