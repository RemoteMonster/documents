# iOS - Overview

## 쉽고 간편하게 방송 또는 통신 기능을 구현 하세요.

![](../.gitbook/assets/undefined.jpg)

Remon를 클래스는 Remon SDK 에서 가장 핵심이 되는 클래스 입니다. Remon 클래스를 사용하고, RemonDelegate를 직접 구현 하여 Remon이 제공하는 통신 기능과 방송 기능을 구현 할 수도 있지만 이는 복잡하고, 따분한 작업이 될 것입니다. 그래서 SDK 사용자가 좀 더 쉽고 빠르게 Remon를 이용 할 수 있도록 복잡 하고, 반복적인 기본 작업을 포함 하고 있는 RemonController 클래스와 Interface Builder\(이하 IB\) 지원을 위한 RemonIBController 클래스를 제공 합니다. RemonController 클래스를 이용한면 복잡한 RemonDelegate의 메소드들을 구현 할 필요 없이 필요한 부분 추가 적으로 구현 하면 됩니다.

이 장에서는 코드상에서 RemonCall 클래스와 RemonCast 클래스를 이용하는 방법을 간략 소개 합니다. IB를 이용한 더 자세한 내은 **iOS - Getting Start** 장을 참조 하세요.

{% page-ref page="ios-getting-start.md" %}

#### ​RemonCall를 이용한 1:1 통신 구현 

RemonCall은 통신 기능을 위한 RemonController의 하위 클래스 입니다.

* connectChannel\(\) 함수는 채널을 생성 하거나 이미 생성된 채널에 접속 하는 함수 입니다. 만약 당신이 채널의 생성자라면 connectChannel\(\) 함수 호출 이후 다른 사용자의 연결이 있을 때까지 대기 하는 상태가 될 것입니다.

```swift
let remonCall = RemonCall()
remonCall.localView = myLocalView
remonCall.remoteView = myRemoteView
// set remonCall config
remonCall.connectChannel("wantedChannelID")
```

#### RemonCast를 이용한 방송 구현

RemonCall은 통신 기능을 위한 RemonController의 하위 클래스 입니다.

* RemonCast의 createRoom\(\) 함수를 이용하여 방송 만들 수 있습니다. createRoom\(\) 함수가 호출 되면 Remon의  미디어 서버에다른 사용자들이 접속 할 수 있는 방송이 만들어 지게 됩니다.

```swift
let remonCast = RemonCast()
remonCast.localView = myLocalView
// set remonCall config
remonCast.createRoom()
let myChID  = remonCast.channelID // after created room
```

* RemonCast의 joinRoom\(chid\) 함수를 이용하면 방송에 참여 할 수 있습니다. 

```swift
let remonCast = RemonCast()
remonCast.remoteView = myRemoteView
// set remonCall config
remonCast.joinRoom("chid")
```

Remon를 이용하면 보면 Remon의 상태를 확인이 불가피한 경우가 있습니다. 이 경우에는 RemonController 클래스의 Observer 함수들을 이용하여 원하는 상태에 SDK 사용자가 필요한 행동을 정의 할 수 있습니다.

{% page-ref page="ios-observer.md" %}



