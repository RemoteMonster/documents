# FAQ

## Android, iOS용 샘플 앱 빌드가 안 됩니다.

빌드 환경의 편차가 커서, 환경에 따라 빌드가 안 되는 경우가 간혹 있습니다. [리모트몬스터 커뮤니티](https://community.remotemonster.com/)에 오류 메시지와 함께 질문을 남겨주십시오. 

## 방송/통화 시작 전에 카메라를 선택하고 싶습니다.

채널에 접속하기 전에 카메라를 선택하면 됩니다. 아래 예제를 참고하시기 바랍니다.

### Web

[https://sample.remotemonster.com/videoConfig.html](https://sample.remotemonster.com/videoConfig.html)

[https://sample.remotemonster.com/videoConfigForCast.html](https://sample.remotemonster.com/videoConfigForCast.html)

### Android

RemonCall, RemonCast 객체를 생성할 때 아래와 같이 isFirstFrontFacing\(\) 메소드를 이용하여 카메라를 선택합니다. 객체를 생성한 후에는 switchCamera\(\) 메소드를 이용해야합니다.

```text
RemonCall.Builder().isFirstFrontFacing(true);
RemonCast.Builder().isFirstFrontFacing(true);
```

### iOS

RemonCall, RemonCast 객체의 frontCamera 속성을 변경합니다.

```text
remonCall.frontCamera = true
remonCast.frontCamera = true
```

## 방송/통화 중에 카메라를 전환하고 있습니다. 어떻게 하나요?

RemonCast, RemonCall의 인스턴스 메소드 중 switchCamera 가 있습니다. 이 메소드를 이용하면 카메라를 전환할 수 있습니다.  
아래 문서에서 swtichCamera 메소드를 확인해주십시오.

### [Web용 SDK](https://remotemonster.github.io/web-sdk/docs/Remon.html)

#### [iOS용 SDK](https://remotemonster.github.io/ios-sdk/Classes/RemonClient.html#/c:@CM@RemoteMonster@objc%28cs%29RemonClient%28im%29switchCameraWithIsMirror:isToggle:)

#### [Android용 SDK](https://remotemonster.github.io/android-sdk/index.html?com/remotemonster/sdk/Remon.html)

## 시청자 쪽에서 채널에 접속이 안 됩니다.

방송자 쪽에서 채널을 생성한 후에 시청자 쪽에서 채널에 접속할 수 있습니다. 시청자 쪽에서 먼저 채널에 접속하려고 시도했는지 확인 바랍니다.

위 문제가 아니라면  [리모트몬스터 커뮤니티](https://community.remotemonster.com/)에 오류 메시지와 함께 질문을 남겨주십시오.

## 통화 테스트 시 소리 울림이 심합니다. 왜 그런가요?

통화에 사용한 두 디바이스가 가까이에 있으면 울림이 발생합니다. 흔히 하울링이라고 합니다. 두 디바이스를 멀리 두고 테스트 해보시기 바랍니다.

통화 시 음성의 문제는 다양한 원인에 의해 발생할 수 있습니다. [리모트몬스터 커뮤니티](https://community.remotemonster.com/)에 상황을 설명해주시면 원인을 찾는데 도움이 됩니다.

## 웹에서, 오디오만 쓸 건데 video 태그를 써야하나요?

오디오만 쓸 때엔 video 태그 말고 audio 태그를 사용해주십시오. 아래 샘플 앱을 참고해주시기 바랍니다.

[https://sample.remotemonster.com/voiceCall.html](https://sample.remotemonster.com/voiceCall.html)

[https://sample.remotemonster.com/voiceCast.html](https://sample.remotemonster.com/voiceCast.html)



