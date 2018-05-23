# iOS - Config

## Remon 설정 하기 

Remon은 Interface Builder\(이하 IB\)를 이용하여 환경 설정을 지원 하지만, IB를 이용하지 않더라도 환경설정을 할 수 있습니다. 

```swift
let remonCast = RemonCast()
// set config value
remonCast.autoReJoin = false
remonCast.onlyAudio = false
remonCast.videoWidth = 640
remonCast.videoHeight = 480
remonCast.fps = 24
remonCast.wsUrl = "wss://signal.remontemonster.com/ws"
remonCast.restUrl = "https://signal.remontemonster.com/rest/init"
remonCast.serviceId = "yourServiceId"
remonCast.serviceKey = "yourServiceKey"

remonCast.createRoom()
```

또는 별도의 RemonConfig 인스턴스를 생성하 RemonContoller 클래스의 createRoom\(\), joinRoom\(\), connectChannel\(\)  함수에 전달 할 수도 있습니다.

```swift
let remonCast = RemonCast()
// set config value
let remonConfig = RemonConfig()
remonConfig.videoCall = true
remonConfig.videoWidth = 640
remonConfig.videoHeight = 480
remonConfig.videoHeight = 480
remonConfig.videoFps = 24
remonConfig.channelType = .broadcast
remonConfig.wsUrl = "wss://signal.remontemonster.com/ws"
remonConfig.restUrl = "https://signal.remontemonster.com/rest/init"
remonConfig.serviceId = "yourServiceId"
remonConfig.key = "yourServiceKey"

remonCast.createRoom(config)
```

{% hint style="info" %}
`connectRoom()`, `createRoom()`, `joinRoom()` 함수에 `RemonConfig`를 전달 하는 경우에는  `RemonContoller` 인스턴스에 설정된 값이 무시되고 전달된 `config` 정보를 이용합니다. 상황에 따라 다양한 설정이 변경이 요구되는 경우 여러개의 RemonConfig를 생성한 후 상황에 따라 설정을 바꿔가며 방송/통신을 생성 하거나 방송/통신 참여가 가능 합니다.
{% endhint %}



