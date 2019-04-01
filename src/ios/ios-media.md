# iOS - Media

## Overview

영상, 음성 미디어의 표출과 사용에 대해 안내합니다. 

공통적인 부분은 아래를 참고하세요.

{% page-ref page="../common/media.md" %}

## View

### Basic

Interface Builder를 통해 StoryBoard를 이용하여 환경설정과 개발을 할 수 있으며, 제공된 SDK를 통해 개별 코드로 View를 구성할 수 있습니다.

Interface Builder를 통한 기본적인 사용은 아래를 참고하세요.

{% page-ref page="ios-getting-started.md" %}

### Advanced

Interface Builder를 사용하지 않는 다면 아래 코드를 참조 하세요.

{% tabs %}
{% tab title="iOS - Swift" %}
```swift
let remonCall = RemonCall()
remonCall.remoteView = myRemoteView
remonCall.localView = myLocalView
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```text
RemonCall *remonCall = [[RemonCall alloc] init];
remonCall.remoteView = myRemoteView;
remonCall.localView = myLocalView;
```
{% endtab %}
{% endtabs %}

### Size

영상 크기값을 얻기 원하신다면 `onRemoteVideoSizeChanged` 함수와 `onLocalVideoSizeChanged` 함수를 구현하여 줍니다.

```swift
let remonCall = RemonCall()
remonCall.onRemoteVideoSizeChanged {(view, size) in 
    let raito = size.height / size.width
    let oldSize = view.frame.size
    let newFrame = 
    CGRect(x: 0.0, y: 0.0, width: oldSize.width, height: oldSize.width * raito)
    view.frame = newFram
}
```

{% hint style="info" %}
`RemonController`에 `remoteView` 또는 `localView`를 지정 했다면 `RemonController`는 지정된 뷰에 비디오 렌더링뷰를 추가 하고, 지정된 뷰의 변화를 추적하여 지정 뷰의 크기에 맞게 비디오 렌더링뷰를 설정 합니다.
{% endhint %}

### Aspect ratio

`RemonController`에는 `onRemoteVideoSizeChanged`와 `onLocalVideoSizeChanged` 라는 영상의 크기 변화를 감지 할 수 있는 함수가 존재하며 이 함수를 이용하여 화면비율을 조절 할 수 있습니다. 아래 예제코드는 방송자의 영상이 '세로' 이고, 시청자의 뷰가 '세로' 일때 화면 시청자 뷰의 높이값을 기준으로 화면 비율을 변경 하는 코드 입니다.

{% tabs %}
{% tab title="iOS - Swift" %}
```swift
remonCast.onRemoteVideoSizeChanged { (view, size) in
    print("Debug onRemoteVideoSizeChanged", size)
    print("Debug self.remonCast.remoteView(\(self.remonCast.remoteView.hashValue)) and view(\(view.hashValue)) is same")
    
    let videoHeight = size.height
    let videoWidth = size.width
    let videoRatio:CGFloat = videoWidth / videoHeight
    
    guard let myView = view else { return }
    
    let myViewWidth:CGFloat = myView.frame.size.width
    let myViewHeight:CGFloat = myView.frame.size.height
    let myViewRatio:CGFloat = myViewWidth / myViewHeight
    
    if videoRatio < 1.0 { // 방송 영상이 세로입니다.
        if myViewRatio < 1.0 { // 시청자 뷰가 세로 입니다.
            let computedWidth:CGFloat = myViewHeight * videoRatio
            print("Debug computedWidth", computedWidth)
            DispatchQueue.main.async {
                myView.frame = CGRect(x: 0.0, y: 0.0, width: computedWidth, height: myViewHeight)
                myView.center = self.view.center
            }
        } else {
//                    NOOP
        }
    } else {
//                NOOP
    }
}
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
[self.remonCast onRemoteVideoSizeChangedWithBlock:^(UIView * _Nullable view, CGSize size) {
    CGFloat videoHeight = size.height;
    CGFloat videoWidth = size.width;
    CGFloat videoRatio = videoWidth / videoHeight;
    
    CGFloat myViewWidth = view.frame.size.width;
    CGFloat myViewHeight = view.frame.size.height;
    CGFloat myViewRatio = myViewWidth / myViewHeight;
    
    if (videoRatio < 1.0) { // 방송 영상이 세로입니다.
        if (myViewRatio < 1.0) { // 시청자 뷰가 세로 입니다.
            CGFloat computedWidth = myViewHeight * videoRatio;
            dispatch_async(dispatch_get_main_queue(), ^{
                view.frame = CGRectMake(0.0, 0.0, computedWidth, myViewHeight);
                view.center = self.view.center;
            });
        } else {
            //                    NOOP
        }
    } else {
        //                NOOP
    }
}];
```
{% endtab %}
{% endtabs %}

### Use External Capturer

2.4.43 버전 부터 기본 RTCCameraCapturer가 아닌 외부 Capturer를 이용 할 수 있도록 지원합니다. 이 기능을 사용하기 위해서는 RemonController의 useExternalCapturer  값을 true로 설정 하고, RemonController의 localExternalCaptureDelegator에게 외부 Capturer로 부터 얻어온 Frame를 넘겨주시면 됩니다.

{% tabs %}
{% tab title="iOS - Swift" %}
```swift
remonCast.useExternalCapturer = true

remonCast.onCreate { (chid) in
    self.startCapter()
}

func startCapture() {
    YourExCapturer.captureBlock { (pixelBuffer, comTime) in
        if let rtcCaptureDelegate = 
            remonCall.localExternalCaptureDelegator {
                rtcCaptureDelegate.didCaptureFrame(
                    pixelBuffer: pixelBuffer,
                    timeStamp: cmTime, 
                    videoRetation: ._0)
        }
    }
} 
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
remonCast.useExternalCapturer = YES;

[remonCast onCreateWithBlock:^(NSString * _Nullable chId) {
    [self startCapture];    
}];

- (void)startCapture {
    [yourExCapturer captureBlock: ^(CVPixelBuffer *pixelBuffer, CMTime *cmTime) {
       [remonCast.localExternalCaptureDelegator 
           didCaptureFrameWithPixelBuffer:pixelBuffer 
           timeStamp:cmTime 
           videoRetation:RemonVideoRotation_0]; 
    }];
}
```
{% endtab %}
{% endtabs %}

## Audio

### Session

iOS에서 `Audio Session Category` 설정에 따라 스피커출력, 음소거 스위치의 작동, 이어폰 연결 작동, 블루투스 등이 상이 하게 작동할 수 있습니다. SDK에서는 기본적으로 `AVAudioSessionCategoryPlayback`를 권장하며 위에 설명된 Background Policy는 `AVAudioSessionCategoryPlayback`를 사용시에 동작입니다. 대부분의 방송, 통신에 대해서는 기본값을 권장합니다. 다만 개발자가 필요에 따라 다양한 세션을 사용하여 원하는 작동을 구현 가능합니다.

Apple기본 제공의 `Audio Session Categroy`인 `soloAmbient` 사용시 소리가 기본적으로 ear piece 로 나오게 되며 스피커로 나오게 하려면 아래와 같은 적용이 필요합니다.

{% tabs %}
{% tab title="iOS - Swift" %}
```swift
//  이 코드는 soloAmbient 카테고리를 사용하고, speaker로 음성을 출력 합니다.
override func viewDidLoad() {
	super.viewDidLoad()
	do {
	    if #available(iOS 10.0, *) {
	        try AVAudioSession.sharedInstance().setCategory(.soloAmbient, mode: .default)
	    }
	    else {
	        AVAudioSession.sharedInstance().perform(NSSelectorFromString("setCategory:error:"), with: AVAudioSession.Category.soloAmbient)
	    }
	    
	    try AVAudioSession.sharedInstance().setActive(true, options: [])
	    try AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
	} catch {
	    print(error)
	}
}
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
//  이 코드는 soloAmbient 카테고리를 사용하고, speaker로 음성을 출력 합니다.
- (void)viewDidLoad {
    [super viewDidLoad];
	@try {
	    NSError *error = nil;
	    [AVAudioSession.sharedInstance setCategory:AVAudioSessionCategorySoloAmbient error:&error];
	    [AVAudioSession.sharedInstance setActive:YES error:&error];
	    [AVAudioSession.sharedInstance overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&error];
	} @catch (NSException *exception) {
	    NSLog(@"error is %@",[exception description]);
	}
}
```
{% endtab %}
{% endtabs %}

Aduio Session에 대한 모드와 일반적인 사용은 아래 링크를 확인하세요.

{% embed url="https://developer.apple.com/library/archive/documentation/Audio/Conceptual/AudioSessionProgrammingGuide/AudioSessionCategoriesandModes/AudioSessionCategoriesandModes.html" %}

### Volume Ratio

`RemonCast` 또는 `RemonCall`를 `music mode`로 이용할 경우 `outputVolume`이 크게 느껴질 수 있습니다. 이럴 경우 `volumeRatio` 값을 조정 하여 `AudioSession outputVolume` 과의 출력 비율 조정 할 수 있습니다. 예를 들어 `outputVolume`이 1.0 \(최대값\) 일때 `volumeRatio`를 0.8로 설정 한다면 `RemonCast` 또는 `RemonCall`은 `outputVolume`의 80%의 크기로 출력 되어 집니다.

{% tabs %}
{% tab title="iOS - Swift" %}
```swift
self.remonCall.volumeRatio = 0.8
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
[self.remonCall setVolumeRatio:0.8]
```
{% endtab %}
{% endtabs %}

### Mixing Sound

WebRTC가 동작을 시작 하면  WebRTC가 `AVAudioSession`을 점유 합니다. 그로 인하여 `AVAudioSession`을 이용한 효과음 재생에 문제가 발생 합니다. 이 문제를 해결 하기 위하여 `OpenAL`과 같은 저수준의 효과음 재생 라이브러리 사용을 권장 드리며 `OpenAL`을 좀 더 쉽게 사용할 수 있게 만들어진 `ObjectAL`과 같은 라이브러리를 사용 할 수 있습니다.

```objectivec
#import "ObjectAL.h"
#define SHOOT_SOUND @"shoot.caf"

[[OALSimpleAudio sharedInstance] playEffect:SHOOT_SOUND];
```

{% embed url="http://kstenerud.github.io/ObjectAL-for-iPhone/documentation/index.html" %}

## Background Policy

백그라운드에서 SDK 연결을 지속적으로 필요하면 아래의 옵션을 Project &gt; Targets &gt; Capabilities &gt; Background Modes 에서 설정하면 됩니다. 백그라운드 설정을 안할 경우 앱이 백그라운드로 진입시 RemoteMonster와의 연결이 종료되어 방송 및 통화가 종료됩니다. 

![](../.gitbook/assets/2018-06-01-10.36.28%20%281%29.png)

{% embed url="https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/BackgroundExecution/BackgroundExecution.html" %}

아래는 지속적으로 연결이 되어있을때 작동이며 위 옵션을 키지 않으면 백그라운드시 모든 경우에 영상, 음성의 송출, 수신이 중단됩니다. 단  아래의 동작은 `Audio Session Category`가 `AVAudioSessionCategoryPlayback` 일 경우의 동작입니다.

| 상황 | 미디어 | 내용 |
| :--- | :--- | :--- |
| 송출 백그라운 | 영상 | 수신측 정지화면\(마지막 프레임, FPS 0\)이나 음성은 들림 |
| 송출 백그라운드 | 음성 | 수신측 음성들림 |
| 수신 백그라운드 | 영상 | 음성은 들을 수 있으며 개발을 통해 백그라운드시 음성을 키거나 끌 수있음 |
| 수신 백그라운드 | 음성 | 음성은 들을 수 있으며 개발을 통해 백그라운드시 음성을 키거나 끌 수있음 |

