# RemoteMonster 시작하기
RemoteMonster는 사용하기 쉬운 통신 기능을 목표로 아래와 같은 절차로 사용 가능합니다.
- 키발급 (단순 테스트시 생략가능)
- SDK 설정
- 개발

## 키 발급
필요에 따라 키 없이 혹은 키를 발급받아 사용이 가능합니다. 테스트를 위해 이 문서를 보고 있다면 곧장 다음 장을 읽어보세요.

- 단순 테스트를 위한 키 없이 사용: 간단히 코드를 작성하거나 기능을 확인하기 위해서라면 가입등 어떤 절차도 필요 없습니다. 곧바로 플렛폼 별 문서를 통해 SDK를 설치하고 개발을 시작하면 됩니다.
- 서비스 운영을 위한 키 발급 후 사용: WebRTC의 기본적인 통신은 Peer to Peer 연결로써 모바일 환경, 방화벽, 네트워크 상황 등 다양한 이유로 연결이 실패할 경우 RemoteMonster 서버를 통해 Realy(TURN) 연결을 할 필요가 있고 RemoteMonster는 이를 `Connection Fail-over`란 이름으로 제공하고 있습니다. RemoteMonster의 `Connection Fail-over`를 사용하기 위해서는 키를 발급 받고 구독 중인 상품에 따라 `Connection Fail-over`의 신뢰성과 품질을 보장합니다. 상용 서비스를 검토중이면 키를 발급받고 홈페이지 Price 페이지를 확인하여 적절한 상품을 구독하세요.

### 구성
키는 아래와 같은 형태로 구성 되 있으며, RemoteMonster SDK가 RemoteMonster 서버에 접근할때 사용 됩니다.
```json
credential = {
  serviceId: '',
  key: '',
}
```
- serviceId: e-mail 형태의 각 서비스를 구분하는 Id
- key: TestKey와 ProductionKey가 발급. 용도별 사용

## SDK 설정
각 플렛폼별 대표적인 패키지 매니저를 통해 간단하게 SDK를 다운로드 받고 설정 가능합니다.

- e.g. `npm i remon-browser-sdk`

## 개발
코드는 다음과 같이 크게 3단계의 절차로 이루어 집니다. 실질적인 코드는 각 플렛폼 별 문서에 자세하게 기술되 있습니다.

### Config
통신을 위한 사전 설정작업을 수행합니다. 크게 4가지 설정이 있고 웹의 경우 아무런 Config작업 없이도 기본 동작이 가능합니다.
- 회원정보: ServiceID, Key등과 같은 회원 정보를 입력합니다. 아무 입력값이 없을 경우 테스트 key로 동작하게 됩니다.
- Video 정보: 영상통신시 나의 영상과 상대방의 영상을 출력하기 위한 화면 컴포넌트를 입력합니다.
- 영상/음성 품질 정보: 코덱이나 비트레이트, 해상도등 품질과 관련된 내용을 수정합니다.
- 개발 정보: 로그 수집 여부, 디버그 모드 등 개발과 관련된 정보를 설정합니다.

```java
Config config = new com.remon.remondroid.Config();
config.setKey;
config.setVideoCall(true);
...
```

### Connect
RemoteMonster는 서버를 통해 방을 제공하고 각 Peer가 이 방을 통해 서로를 인지하며 연결이 가능해 집니다. RemoteMonster를 사용하는데 있어 가장 기본적인 개념이 됩니다. 입력인자에는 방 이름이 있습니다. 최초 방 개설자인 경우에는 방 이름을 넣지 않아도 됩니다. 그럴 경우 별도의 고유한 방이름이 반환됩니다.

```javascript
remon.connect("방이름");
```

### Callback
통신 중에 일어나는 모든 이벤트를 수신하는 Callback 기능을 제공합니다. 통신과정은 복잡한 비동기와 제어흐름의 연속인데 이를 쉽게 사용하게 하기 위해 RemoteMonster는 이벤트로 개발자에게 제공하고, Callback을 통해 특정 상황에 적합한 기능을 수행토록 할 수 있습니다.

다음과 같은 상황에 대한 Callback이 준비되어 있습니다.

- onInit
- onConnectChannel
- onCreateChannel
- onComplate
- onAddLocalStream
- onAddRemoteStream
- onStateChange
- onDisconnectChannel
- onMessage
- onError
