---
description: 에러코드에 대해 설명합니다.
---

# Error

## Overview

Error는 넓은 영역에서의 예외상황을 말합니다. `onError` 콜백 메소드를 통해서 Error를 받게 되며 아래와 같이 다양한 상황이 있습니다.  
 Android 의 경우 RemonException 객체에 RemonErrorCode 와 메시지가 전달되며, iOS 의 경우 RemonError 로 정의된 enum 타입으로 에러 코드가 전달됩니다. 

RemonErrorCode\(Android\) / RemonError \(iOS\)

#### invalidParameterError / InvalidParameterError

* `new Remon`시 인자가 잘못될 경우
  * `config`의 Key, Service Id, Local View, Remote View 혹은 `config`나 Callback자체가 없는 경우이거나 너무 길이가 큰 경우
* `connectChannel`시에 잘못된 값\(길이가 1이하이거나 필요이상으로 너무 큰 경우 100이상\)
* `UnsupportedPlatformError`
  * Browser가 지원하지 않는 경우
  * Version이 지원하지 않는 경우

#### initError / RestInitError

* RESTful API 반환시 에러가 난 경우
  * 500 Error
* 시그널링 서버가 죽어있는 경우
  * 웹 서버는 살아있으므로 웹 서버가 잘못된 페이지를 전달함
* 웹 서버가 죽어있는 경우
  * 400 Error
* Web Socket, RESTful 호스트가 문제가 있는 경우
* Web Socket 시작중에 에러가 난 경우

#### wsError / WebSocketError

* Websocket 통신 중 발생한 에러
* Send Error
* Receive Error

#### connectError / ConnectChannelFailed

* `create`/`connect`의 반환에 `channel`정보가 없는 경우
* `channel`이 만료되거나 `channel`이 없는데 `connect`하는 경우는 알아서 서버가 `onCreateChannel`로 변화시켜버림

#### mediaError / UserMediaDeviceError

* Media 특히 Camera를 못가져온 경우\(Video를 On했음에도 불구하고\)\)
* Video Capture를 못가져온 경우

#### iceError / IceFailed

* `peerConnection` 생성 안될때
* SDP가 이미 있는데 또 자기것이 생성된 경우
* ICE, SDP가 파싱이 안되거나 추가가 안되는 경우

#### networkChange

* 네트워크 변경에 의한 에러

#### unknown / Unknown

* 서버에서 전달한 에러 혹은 알수 없는 에

## 반드시 종료해야할 오류코드 <a id="errorcode_must"></a>

onError 콜백 함수 호출 시 인자로 오류코드와 설명이 주어집니다. 1:1통화와 방송시청 시 아래 오류코드를 받았을 경우는 접속이 원활하지 않아 접속을 종료해야하는 상황입니다. 아래 오류코드를 확인하게되면 close 메소드를 호출하여 접속을 종료해주십시오. 일부 오류코드는 자동으로 close 메소드가 호출됩니다.   
Web, Android, iOS 공통으로 사용되는 코드입니다.  
그룹통화 시 아래 오류코드는 의미가 다릅니다. 그룹통화를 이용하시는 경우 이메일로 문의 바랍니다.

4101 : Service ID, Secret Key가 없음

4181, 4182 : 카메라 또는 마이크를 이용할 수 없음

4201 : 리모트몬스터와 인증이 올바르게 이루어지지 않음 \(클라이언트의 이유\)

4211 : 디바이스가 offline 임

4241 : 네트워크 환경이 매우 좋지 않아 리모트몬스터 서버로 접속이 이루어지지 않음 또는 끊어짐

4204 : 리모트몬스터와 인증이 올바르게 이루어지지 않음 \(서버의 이유\)

2010 : \(통화에서\) 이미 해당 채널에서 통화가 진행되고 있음

4342 : 네트워크 환경이 불안정함

4343 : 네트워크 환경이 불안정함

2370 : 계약하지 않은 서비스 아이디로서, 테스트 시간 3분을 초과하여 종료됨



## 종료 하지 않아도 되는 오류코드

onError 콜백 함수 호출 시 인자로 오류코드와 설명이 주어집니다. 아래 오류코드를 받았을 경우는 통화, 방송, 시청에 잠재적으로 영향을 줄 수 있는 환경의 변화을 알려줍니다. 접속을 종료하지 않아도 안전합니다.  
Web, Android, iOS 공통으로 사용되는 코드입니다.  
그룹통화 시 아래 오류코드는 의미가 다릅니다. 그룹통화를 이용하시는 경우 이메일로 문의 바랍니다.

4344 : 네트워크 환경의 변화

4345 : 네트워크 환경의 변화



