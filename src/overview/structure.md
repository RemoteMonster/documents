# Structure

## Overview

리모트몬스터의 SDK를 사용하는 것은 매우 간단합니다. 크게 3가지의 클래스 사용법만 익히면 됩니다.

![RemoteMonster SDK overview](../.gitbook/assets/sdkcommonoverview1.png)

## Remon class

Remon에서 모든 방송, 통신관련 조작을 수행합니다. 방송, 통신상태를 초기화하고 방을 개설하고 방에 접속하고 종료하는 일련의 모든 과정에서 이 `Remon` 클래스를 사용합니다. 또한, 메세지 보내기와 같은 추가적인 기능을 수행합니다.

`Remon` 클래스를 생성하기 위해서는 2개의 미리 준비된 정보가 필요합니다. 다음에 설명될 `Config`와 `Observer`입니다.

### Init

객체를 초기화하는 과정입니다. 이를 통해 RemoteMonster API 서버와 연결됩니다. 연결되는 순간 RemoteMonster 서버는 이 `Remon` 객체에게 1회용 토큰을 제공합니다.

### ConnectChannel

통신에 사용하는 기능입니다. 채널에 접속하거나 채널을 만드는 명령입니다. 주어진 이름의채널이 없을 경우 채널을 만들고 이미 채널이 있을 경우 채널에 접속합니다. 만약 채널 이름이 없을 경우 RemoteMonster는 고유한 채널 이름을 생성해서 반환합니다.

### CreateRoom, JoinRoom

방송에 사용하는 기능입니다. 방송용 방을 만들거나 시청하는 명령입니다. 방을 만들 때에는 방의 닉네임을 전달할 수 있고 `Observer`등의 콜백을 통해 `onCreate`에서 방의 실제 유일한 id값을 받게 되며 이 id값을 이용하여 `JoinRoom` 메소드를 통해 시청자는 해당 방에 접근할 수 있습니다.

### SearchChannel, SearchRoom

주어진 인자값에 해당하는 방이름이 있는지 검색하여 알려줍니다. 인자값이 없으면 모든 방 정보를 알려줍니다.

### Close

방을 나오거나 방을 없애버리고 초기화합니다.

### 플랫폼별 사용법

{% page-ref page="../web/web-livecast.md" %}

{% page-ref page="../web/web-communication.md" %}

{% page-ref page="../android/android-livecast.md" %}

{% page-ref page="../android/android-communication.md" %}

{% page-ref page="../ios/ios-livecast.md" %}

{% page-ref page="../ios/ios-communication.md" %}

## Config Class

`Remon` 객체를 초기화하기 전에 필요한 사전 설정작업은 모두 이 `Config`를 통해서 이루어집니다. 다음과 같이 구성되어 있습니다.

### Credential

인증과 관련된 정보를 처리합니다.

* key : 리모트몬스터로부터 받은 인증키를 입력합니다.
* serviceId : 내가 만들고 있는 서비스를 구분하는 unique id로 이 정보를 바탕으로 인증을 수행합니다.

{% page-ref page="../common/service-id.md" %}

### Media

영상과 음성에 대한 여러가지 설정을 할 수 있습니다.

* 영상 사용여부
  * 음성 통화만을 원한다면 영상은 false로 하고 사용하면 사용자의 통신요금과 대역을 줄일 수 있습니다.
* 코덱 선택
  * 음성과 영상 모두에 대해 코덱을 선택할 수 있습니다. 영상의 경우 리모트몬스터는 기본적으로 H.264를 사용하고 있으며 음성은 OPUS를 사용합니다.
* `FrameRate`와 해상도
  * 영상의 경우 해상도와 `FrameRate`을 수정하여 원하는 품질을 적용할 수 있습니다.
* 녹음
  * 녹음기능을 간단하고 쉽게 적용할 수 있습니다.

### 플랫폼별 사용법

아래를 통해 각 플랫폼에서 실제 개발시 설정방법을 보다 자세히 알아보세요.

## Observer Class

`Remon` 클래스가 명령을 내리는 용도라면 `Observer`는 Callback 메시지를 수신하기 위한 클래스입니다. `Observer`로부터 수신되는 이벤트를 이용하여 보다 세밀한 통신효과와 능동적인 서비스를 구현할 수 있습니다. 다음과 같은 메소드가 호출됩니다.

### onStateChange

최초 `Remon`객체를 만들고 방을 만들며 접속하고 접속에 성공하고 방송, 통신을 마칠 때까지의 모든 상태 변화에 대해 처리하는 메소드입니다. `RemonState` enum객체를 통해 어떤 상태로 변경되었는지를 알려줍니다. `RemonState`의 상태는 다음과 같습니다.

| 값 | 내용 | 비고 |
| --- | --- | --- | --- | --- | --- | --- |
| INIT | 시작 |  |
| WAIT | 채널 생성 |  |
| CONNECT | 채널, 방 접속 |  |
| COMPLETE | 연결 완료 |  |
| FAIL | 실패 |  |
| CLOSE | 종료 |  |

### onError

통신 시도 중 장애 발생시 호출됩니다.

{% page-ref page="../common/error-code.md" %}

### onAddLocalStream

자기 자신의 카메라의 영상이 혹은 음성 스트림을 획득하였을 경우 호출됩니다.

### onAddRemoteStream

상대방의 영상이나 음성 스트림을 획득하였을 경우 호출됩니다. 연결이 되었음을 의미합니다.

### onInit

`Remon`객체가 무사히 생성되었을 경우 불려집니다. 이 `onInit`메소드가 불려지고 바로 `Remon.connectchannel` 메소드를 수행할 수 있습니다.

### onSearch

`Remon.search` 메소드를 호출하면 `Observer`의 `onSearch`메소드가 결과를 반환합니다.

### onMessage

`Remon.sendMessage` 메소드를 호출하면 `Observer`의 `onMessage`메소드가 결과를 반환합니다.

### 플랫폼별 사용법



