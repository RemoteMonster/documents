---
description: 개발을 위한 환경설정을 안내합니다.
---

# iOS - Getting Start

## 준비 사항

* Xcode 개발 환경
* iOS 9.2 이상

## 프로젝트 생성 및 설정

Xcode에서 Swift기반의 프로젝트를 생성합니다.

프로젝트 생성 후 `Build Settings`에서 `Enable Bitcode`에 대하여 `No`를 설정해야 합니다.

![Bitcode](../.gitbook/assets/ios_bitcode%20%281%29.png)

또한 Info.plist에서 다음 항목에 대해 추가 혹은 변경을 해주셔야 합니다.

* Privacy: Bluetooth, Microphone, Camera

![Settings](../.gitbook/assets/ios_buildsettings.png)

## SDK 설치 - Cocoapods

SDK 설치를 원하는 프로젝트의 `Podfile`에 `pod 'RemoteMonster', '~> 2.0'`을 추가 합니다

{% code-tabs %}
{% code-tabs-item title="Podfile" %}
```text
target 'MyApp' do
  pod 'RemoteMonster', '~> 2.0'
end
```
{% endcode-tabs-item %}
{% endcode-tabs %}

. 그리고 터미널에서 `pod install` 를 실행 합니다. 만약 `pod install` 이 동작하지 않는 다면 `pod update`를 실행 합니다.

```bash
$ pod install
```

## SDK 설치 - 직접 import

우선 아래의 링크를 통해 iOS SDK의 마지막 버전을 다운로드 받습니다.

{% embed data="{\"url\":\"https://remotemonster.com/developers\",\"type\":\"link\",\"title\":\"Developer\",\"icon\":{\"type\":\"icon\",\"url\":\"https://uploads-ssl.webflow.com/5ae923e519474e392b0c80fc/5b02226459e4c8782a772e2f\_remon\_logo-09.png\",\"aspectRatio\":0}}" %}

{% embed data="{\"url\":\"https://github.com/remotemonster/ios-sdk\",\"type\":\"link\",\"title\":\"RemoteMonster/ios-sdk\",\"description\":\"ios-sdk - RemoteMonster iOS SDK & examples\",\"icon\":{\"type\":\"icon\",\"url\":\"https://github.com/fluidicon.png\",\"aspectRatio\":0},\"thumbnail\":{\"type\":\"thumbnail\",\"url\":\"https://avatars2.githubusercontent.com/u/20677626?s=400&v=4\",\"width\":400,\"height\":400,\"aspectRatio\":1}}" %}

다운로드받은 RemoteMonster iOS SDK를 압축을 풀면 2개의 Framework이 존재합니다. 각각의 Framework을 Finder에서 끌어다 프로젝트 트리창에 놓습니다. 그러면 RemoteMonster SDK를 프레임워크로 인식하게 됩니다.

![Framework](../.gitbook/assets/ios_importframework%20%282%29.png)

## Remon 설정 및 레이아웃 구성

`Remon`은 `RemonIBController`를 이용하여 `InterfaceBuilder`를 이용한 설정이 가능 합니다.

* 스토리보드에 `RemonIBController`의 하위객체인 `RemonCall` 또는 `RemonCast`를 추가합니다.
  * `RemonCall`를 1:1 통신을 지원 하며 `RemonCast`는 1:N 방송을 지원 합니다.
  * `InterfaceBuilder`에서 `Utilities` 뷰를 이용하여 `Remon`을 설정 합니다.
* `ServiceID`와 `Service Key`를 설정합니다.
  * 만약 간단하게 테스트를 하기 원한다면, `SERVICEID`와 `1234567890`를 각각 입력합니다.
  * 이 ID와 Key는 테스트용도로 제공되는 것으로,  아래를 참고하여 실제 키를 발급받으세요.

{% page-ref page="../common/service-id.md" %}

![](../.gitbook/assets/basic_config.png)

* 스토리보드에서 원하는 `Scene`에서 원하는 위치에 `Veiw`를 배치하고 `RemonIBController`의 `remoteView`와 `localView`에 바인딩 하여 줍니다.

![](../.gitbook/assets/basic_config3%20%282%29.png)

* `Remon`를 사용하는 `ViewContoller`에 `RemoteMonster`를 임포트 하고, `RemonIBController`객체를 아웃렛 변수에 바인딩 합니다.

![](../.gitbook/assets/config3.png)

## 개발

`Remon` 설정이 완료 되었다면 실제 개발은 쉽습니다. `ViewContoller`에서 방송 또는 통신을 시도 하세요!

### 방송

```swift
remonCast.createRoom()               // livecast - create
remonCast.joinRoom("channelID")      // livecast - join
```

혹은 좀더 자세한 내용은 아래를 참고하세요.

{% page-ref page="ios-livecast.md" %}

### 통신

```swift
remonCall.connectChannel()              // communication
```

혹은 좀더 자세한 내용은 아래를 참고하세요.

{% page-ref page="ios-communication.md" %}

