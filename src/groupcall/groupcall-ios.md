# 그룹통화 만들기\(iOS\)

## 

## 그룹통화란?

다수의 참여자가 통화에 참여하는 서비스를 위한 기능입니다. 참여자는 앱을 이용하는 나와 그 외 참여자로 구분할 수 있습니다. 아래에서는 나와 참여자로 줄여서 표시합니다. 한 회기의 그룹통화는 RemonConference 클래스의 인스턴스로 대표됩니다. 나는 통화 연결, 참여자들의 입장/퇴장 알림 등 대부분의 일을 RemonConference 객체에게 위임합니다.

## RemonConference

iOS SDK 2.7.0이상

그룹통화를 위해 RemonConference 객체를 생성하고, 설정을 진행합니다.  
RemonConference 클래스는 그룹통화를 위해 아래 메소드를 제공합니다.

```swift
create( roomName:String, config:RemonConfig, callback:OnConferenceEventCallback )
leave()
```

RemonConference 클래스는 콜백으로 사용하기 위해 아래 메소드를 제공합니다. 이하 콜백용 메소드라고 합니다. 콜백용 메소드는 위에서 언급한 메소드의 콜백으로만 호출하며, 일반적인 메소드처럼 호출하지 않습니다.

```kotlin
// create 메소드의 콜백용 메소드
.on( eventName:"onRoomCreate") { participant in
}.on( eventName:"onUserJoined") { participant in
}.on( eventName: "onUserStreamConnected" ) { particpant in
}.on( eventName:"onUserLeft") { participant in
}.close {
}.error { error in
}

// participant 의 콜백용 메소드 
.on(event:"onComplete") { participant in
}.on(event:"onClose") { participant in
}.on(evennt:"onError") { error in
}
```

## 레이아웃 작업

그룹통화 화면을 나의 영상 한 개와 그룹 참여자의 영상 여러 개로 구성합니다. 레이아웃에 영상을 표시할 view를 만들고 인덱스를 지정하여 참여자의 영상을 원하는 위치에 표시할 수 있도록 합니다.

## 레이아웃 초기화

레이아웃을 바인딩하고, 각 view를 배열에 담아 index 로 접근이 가능하도록 설정합니다.

```swift
@IBOutlet var viewArray: [UIView]!
var availableViews:[Bool]?
```

## RemonConference 객체 생성

RemonConference 객체를 생성하고, 나의 영상을 송출하기 위한 설정을 합니다.

```kotlin
// 뷰를 설정하기 위한 배열 : 서버스에 맞게 구
availableViews = [Bool](repeating: false, count: self.viewArray.count)

var remonConference = RemonConference()

// config
let config = RemonConfig()
config.serviceId = "콘솔을 통해 발급 받은 Service Id"
config.key = "콘솔을 통해 발급 받은 Secret Key"


remonConference.create( "방이름", config: config) { 
    participant in
    
    // 마스터유저가 전달됩니다. (iOS의 경우 Builder 를 제공하지 않습니다)
    // 객체 생성은 RemonConference에서 이루어지므로 전달된 객체에 설정만을 제공합니다.
    participant.localView( surfaceRendererArray[0] )
    
}.close {
    // 마스터 유저가 종료된 경우 호출됩니다.
    // 송출이 중단되면 그룹통화에서 끊어진 것이므로, 다른 유저와의 연결도 모두 끊어집니다.
}.error { 
    error in
    // 마스터 유저가 연결된 채널에서 에러 발생 시 호출됩니다.
}
```

## 그룹통화 콜백

create 메소드로 그룹통화에 입장한 뒤 on\(\) 메쏘드로 콜백을 등록할 수 있습니다.모든 참여자가 퇴장하면 이 이름의 그룹통화는 소멸됩니다.  
새 참여자가 그룹통화에 입장하면 연결된 on 메소드의 콜백이 호출됩니다. on 메소드 콜백에서 RemonParticipant 객체가 제공되므로, 해당 정보를 사용해 설정을 진행합니다. 

```kotlin
remonConference.create( "방이름", config: config) { _ in
}.on( "onRoomCreated" ) { 
    participant in
    
    // 마스터 유저가 접속된 이후에 호출(실제 송출 시작)
    // TODO: 실제 유저 정보는 각 서비스에서 관리하므로, 서비스에서 채널과 실제 유저 매핑 작업 진행
    // tag 객체에 holder 형태로 객체를 지정해 사용할 수 있습니다.
    // 예제에서는 뷰 할당을 위해 단순히 view의 index를 저장합니다.
    participant.tag = 0
    
    // 뷰 설정용
    availableViews?[0] = true
}.on( "onUserJoined" ) { 
    participant in
    
    Log.d( TAG, "Joined new user" )
    // 그룹통화에 새로운 참여자가 입장했을 때 호출됩니다.
    // 새로운 참여자의 RemonParticipant 객체가 전달됩니다.
    
    // 뷰 리스트에서 비어있는 뷰를 얻어와 설정합니다.
    if let index = self?.getAvailableView() {
        participant.localView = nil
        participant.remoteView = self?.viewArray[index]
        participant.tag = index
    }

}.on( "onUserStreamConnected" ) { 
    participant in
    // 참여자가 연결된 이후에 호출됩니다.
    
}.on( "onUserLeft" ) { 
    participant in
    
    // 다른 사용자가 퇴장한 경우
    // participant.id 와 participant.tag 를 참조해 어떤 사용자가 퇴장했는지 확인후 퇴장 처리를 합니다.
    if let index = participant.tag as? Int {
        self?.availableViews?[index] = false
    }
}


// 비어있는 뷰 검색 함수 : 각 서비스에 맞게 구성합니다.
func getAvailableView() ->Int {
    if let views = self.availableViews {
        for i in 0 ... views.count {
            if views[i] == false {
                self.availableViews?[i] = true
                return i
            }
        }
    }
        
    return 0
}
```

## 그룹통화 종료

그룹통화에서 퇴장하면 나와 그룹통화의 연결이 종료됩니다. 나와 참여자들 간의 연결도 종료됩니다.

```swift
remonConference.leave()
```

## RemonParticipant

각 참여자들과의 연결은 RemonConference 내부의 RemonParticipant 객체를 통해 이루어집니다. RemonParticipant 객체는 RemonClient를 상속받은 객체이므로, 공통적인 기능은 RemonCall, RemonCast 와 동일합니다. 각 이벤트마다 RemonParticipant 객체가 전달되므로 각 연결은 해당 객체를 통해 제어할 수 있으며, 마스터 객체의 경우 RemonConference 객체에서 얻어올 수 있습니다.

```kotlin
// 마스터 유저 얻기
var participant:RemonParticipant = remonConference.me
```

{% hint style="warning" %}
RemonParticipant 객체는 RemonClient를 상속받은 객체입니다. onCreate, onClose, onError 콜백은 on 로 재정의되어 RemonConference에서 관리, 사용되고 있으므로, 해당 콜백을 변경하지 마시기 바랍니다.
{% endhint %}

