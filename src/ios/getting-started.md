# iOS SDK - Getting Started

## 준비 사항

* Xcode 개발 환경
* iOS 9.2 이상

## 프로젝트 생성 및 설정

* Xcode에서 Swift기반의 프로젝트를 하나 생성합니다.
* 프로젝트 생성 후 Build Settings에서 bitcode에 대하여 No를 설정해야 합니다. \(Remon SDK 0.1.6 부터는 bitcode를 지원함\)

![bitcode](../.gitbook/assets/ios_bitcode.png)

* 또한 Info.plist에서 다음 항목에 대해 추가 혹은 변경을 해주셔야 합니다.
  * Privacy: Bluetooth, Microphone, Camera

![settings](../.gitbook/assets/ios_buildsettings.png)

## Cocoapods을 이용한 SDK 설치

SDK 설치를 원하는 프로젝트의 Podfile에 `pod 'Remon-iOS-SDK', '~> 2.0`을 추가 하거나

```text
target 'MyApp' do
  pod 'Remon-iOS-SDK', '~> 2.0'
end
```

을 추가 합니다. 그리고 터미널에서 _pod install_ 를 실행 합니다. 만약 _pod install_ 이 동작하지 않는 다면 _pod update_를 실행 합니다.

## 직접 RemoteMonster iOS SDK import하기 \(Without Cocoapods\)

* 다운로드받은 RemoteMonster iOS SDK를 압축을 풀면 2개의 Framework이 존재합니다. 각각의 Framework을 Finder에서 끌어다 프로젝트 트리창에 놓습니다. 그러면 RemoteMonster iOS SDK를 프레임워크로 인식하게 됩니다.

![framework](../.gitbook/assets/ios_importframework.png)

## Remon 설정 및 레이아웃 구성

Remon은 RemonIBController를 이용하여 InterfaceBuilder를 이용한 설정이 가능 합니다.

* 스토리보드에 RemonIBController의 하위객체인 RemonCall 또는 RemonCast를 추가합니다.
  * RemonCall를 1:1 통신을 지원 하며 RemonCast는 1:N 방송을 지원 합니다.
  * InterfaceBuilder에서 Utilities 뷰를 이용하여 Remon을 설정 합니다.
  * Service ID와 Service Key를 필수 설정값입니다. 발급 받으신 ID와 Key를 입력 합니다.

![](../.gitbook/assets/basic_config.png)

* 스토리보드에서 원하는 Scene에서 원하는 위치에 Veiw를 배치하고 RemonIBController의 remoteView와 localView에 바인딩 하여 줍니다.

![](../.gitbook/assets/basic_config3.png)

* Remon를 사용하는 ViewContoller에 remonios를 임포트 하고, RemonIBController객체를 아웃렛 변수에 바인딩 합니다.

![](../.gitbook/assets/basic_config2.png)

## 개발

* Remon 설정이 완료 되었다면 실제 개발은 쉽습니다. ViewContoller에서 방송 또는 통신을 시도 하세요!

```text
remonCall.connetChannel("channelID")
```

#### InterfaceBuilder를 이용하지 않아도 Remon을 이용할 수 있습니다.

```text
let caster = RemonCast()
caster.serviceId = "YourServiceID"
caster.serviceKey = "YourServiceKey"
caster.broadcast = true
caster.localView = localView
caster.createRoom()
```

* RemonIBController에 값을 직접 설정 않고, connectChannel\(\), createRoom\(\), joinRoom\(\) 함수에 RemonConfig를 전달 할 수도 있습니다. 이 경우에는  RemonIBContoller 인스턴스에 설정된 값이 무시되고 전달된 config 정보를 이용합니다.

```text
let viewer = RemonCast()
viewer.remoteView = remoteView
let config = RemonConfig()
config.serviceId = "YourServiceID"
config.key = "YourServiceKey"
config.channelType = "VIEWER"
caster.joinRoom(config)
```



