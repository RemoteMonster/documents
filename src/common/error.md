---
description: 에러코드에 대해 설명합니다.
---

# Error

## 개요

RemoteMonster API는 크게 두가지의 예외상황을 전달합니다. Fail과 Error입니다.

### Fail

Fail은 주로 통신 중에 발생합니다. 통신 연결이 안되었거나 통신이 끊어졌거나 끊어진 것은 아니지만 상태가 불안정할 때 Fail이 발생합니다. `onStateChange` 콜백 메소드를 통해서 Fail관련 이벤트를 받을 수 있습니다.

### Error

Error는 Fail을 포함한 더 넓은 영역에서의 예외상황을 말합니다. `onError` 콜백 메소드를 통해서 Error를 받게 되며 아래와 같이 다양한 상황이 있습니다.

#### InvalidParameterError

* `new Remon`시 인자가 잘못될 경우
  * `config`의 Key, Service Id, Local View, Remote View 혹은 `config`나 Callback자체가 없는 경우이거나 너무 길이가 큰 경우
* `connectChannel`시에 잘못된 값\(길이가 1이하이거나 필요이상으로 너무 큰 경우 100이상\)
* `UnsupportedPlatformError`
  * Browser가 지원하지 않는 경우
  * Version이 지원하지 않는 경우

#### InitFailedError

* RESTful API 반환시 에러가 난 경우
  * 500 Error
* 시그널링 서버가 죽어있는 경우
  * 웹 서버는 살아있으므로 웹 서버가 잘못된 페이지를 전달함
* 웹 서버가 죽어있는 경우
  * 400 Error
* Web Socket, RESTful 호스트가 문제가 있는 경우
* Web Socket 시작중에 에러가 난 경우

#### WebSocketError: websocket 통신중에 발생한 에러

* Send Error
* Receive Error

#### ConnectChannelFailedError

* `create`/`connect`의 반환에 `channel`정보가 없는 경우
* `channel`이 만료되거나 `channel`이 없는데 `connect`하는 경우는 알아서 서버가 `onCreateChannel`로 변화시켜버림

#### BusyChannelError

* 채널이 이미 사용중인 경우

#### UserMediaDeviceError

* Media 특히 Camera를 못가져온 경우\(Video를 On했음에도 불구하고\)\)
* Video Capture를 못가져온 경우

#### ICE\(Failed\)Error

* `peerConnection` 생성 안될때
* SDP가 이미 있는데 또 자기것이 생성된 경우
* ICE, SDP가 파싱이 안되거나 추가가 안되는 경우

