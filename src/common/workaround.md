# Workaround

## Network Environment

영상, 음성등 미디어를 전송하는데 있어서 네트워크 환경은 절대적인 영향을 미칩니다. 리모트몬스터의 방송과 통신기능은 기본적으로 실시간에 준하는 빠른 전송을 하기위한 다양한 기술이 접목되어 있습니다. 다만, 이러한것과는 별개로 최상의 사용자 경험을 위해 몇가지 추가적인 작업을 하는것을 권장드립니다.

### 방송, 통화간 차이

통화는 peer-to-peer 를 기본으로 1:1로 연결이 진행됩니다. 이 상황에서는 특별한 변화가 없는 이상 각 peer가 서로의 네트워크 환경과 단말의 미디어 환경에 맞추어 서로간에 품질 최적화 등의 작업을 지능적으로 수행합니다.

다만 방송의 경우 송출자 및 시청자간 지능적인 품질 최적화의 일부 제한이 있을 수 있으며, 아래의 경우를 참고하여 대비하는것이 좋습니다. 대다수의 사용자는 네트워크 환경에 따른 미디어 품질의 높고 낮음을 인지 하지 못하고 단순히 응용 서비스의 작동이상으로 착각하는 경우가 많음으로 아래와 같은 항목을 적극 활용하는것이 유용합니다.

{% hint style="info" %}
통화기능을 사용한다면 필요시 이 장을 참고하여도 좋습니다. 방송기능을 사용한다면 아래의 내용을 살펴보고 처음부터 준비하는것을 권장합니다.
{% endhint %}

### FPS 감시 - 방송/통신 - 영상

방송/통신 영상 수신에 관련된 방법입니다. 3G 같이 지나치게 낮은 대역폭, 네트워크의 문제나 미디어가 최초에 연결될때 지연같은 이유로 영상이 안나오는 경우가 있습니다. 이때 SDK에서는 FPS가 0으로 나타나게되고 이 값을 감시하면서 로딩 인디케이터나 안내등을 제공하여 사용자 경험을 향상 할 수 있습니다.

e.g. FPS가 0일시 방송화면 전체를 가리는 로딩 인디케이터

{% tabs %}
{% tab title="Web" %}

{% endtab %}

{% tab title="Android" %}
```java
  @Override
  public void onStat(RemonStatReport report) {
      int fps = report.getRemoteFrameRate();
  }
```

`report.getRemoteFrameRate()` / `report.getLocalFrameRate()`를 통해 해당 연결의 fps를 확인 할 수 있습니다.
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
self.remonCast.onRemonStatReport { (report) in
    if report.remoteFrameRate == 0 {
        print("Remote frame rate is zero")
    } 
    if report.localFrameRate == 0 {
        print("Local frame rate is zero")
    }
}
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
[self.remonCast onRemonStatReportWithBlock:^(RemonStatReport * _Nonnull stat) {
    if ( [stat remoteFrameRate] == 0 ) {
        NSLog(@"Remote frame rate is zero");
    }
        
    if ( [stat localFrameRate] == 0 ) {
        NSLog(@"Local frame rate is zero");
    }
}];
```
{% endtab %}
{% endtabs %}

### Media Health Report 감시 - 방송/통신 - 영상/음성

방송/통신의 영상/음성 수신에 관련된 방법입니다. SDK 내부에서 자체적인 품질값을 제공하고 있습니다. 특히 이 값이 최저 일때, 간단하게는 안내, 토스트등의 사용자 경험을 보호하는 UI를 제공하는것이 의미 있습니다. 다만, 이값이 꼭 미디어가 안보이는 상황을 의미하는 것은 아니기 때문에 간단한 안내가 적합합니다. 또는 일정 시간동안 이 값의 추이를 감시하여 별도의 처리를 하는 방법이 있을 수 있습니다. 실제 사용은 아래의 링크를 참고하세요.

e.g. 품질이 나쁠 때, 네트워크 불안정으로 인해 품질이 안 좋음을 안내하는 toast UI

{% page-ref page="media-health-report.md" %}

{% hint style="info" %}
Fps와 Quality Statistics Report는 어떻게 다른가요?

Fps는 사용자경험에 매우 직접적인 결과를 나타내는 값으로 연속적인 사용자 경험을 보장하기 위한 로딩 인디케이터를 띄우는 것이 유의미 합니다.

Quality Statistics Report는 다양한 값을 참조하고 경우에 따라서는 즉각적이지 않고 실제 품질을 후행하는 지표일 수 있음으로 사용자에게 앱의 이상이 아님을 안내 하는 용도로 적합합니다.
{% endhint %}

### Simulcast\(beta\) - 방송 - 영상

영상 방송의 송출과 수신에 관련된 기능입니다. 데스크탑 브라우저에서 방송송출시 simulcast기능을 사용해 두개의 고화질, 저화질의 두가지 화질을 동시에 지원가능합니다. 이 때, 단말은 처음은 고화질로 시청을 시도하고 만약 불안정 하다면 낮은 품질로 시청을 하게 됩니다. 다만 자동으로 고품질로 시도하는 기능은 제공하고 있지 않습니다.

자세한 내용은 아래 링크를 참고하세요.

{% page-ref page="simulcast.md" %}

## Background Policy

iOS, Android의 플렛폼 정책에 따라 앱이 백그라운드에 있을때 미디어의 연결에 변화가 있을 수 있습니다. 아래를 참고하여 개발시 응용하세요.

### Android

안드로이드는 특별한 설정이 없으면 백그라운드시 모든 미디어가 송출 및 수신이 됩니다. 만약 수신등에서 백그라운드로 진입시 음소거가 필요하다면, 시스템 이벤트등을 통해 별도 처리하면 됩니다.

| 상황 | 미디어 | 내용 |
| :--- | :--- | :--- |
| 송출 백그라운드 | 영상 | 수신측에서 영상/음성 정상 수 |
| 송출 백그라운드 | 음성 | 수신측에서 음성 정상 수신 |
| 수신 백그라운 | 영상 | 음성을 들을 수 있음 |
| 수신 백그라운드 | 음성 | 음성을 들을 수 있음 |

### iOS

백그라운드에서 SDK 연결을 지속적으로 필요하면 아래의 옵션을 Project &gt; Targets &gt; Capabilities &gt; Background Modes 에서 설정하면 됩니다. 백그라운드 설정을 안할 경우 앱이 백그라운드로 진입시 RemoteMonster와의 연결이 종료되어 방송 및 통화가 종료됩니다. 

![](../.gitbook/assets/2018-06-01-10.36.28%20%281%29.png)

{% embed url="https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/BackgroundExecution/BackgroundExecution.html" %}

아래는 지속적으로 연결이 되어있을때 작동 이며 위 옵션을 키지 않으면 백그라운드시 모든 경우에 영상, 음성의 송출, 수신이 중단됩니다.

| 상황 | 미디어 | 내용 |
| :--- | :--- | :--- |
| 송출 백그라운 | 영상 | 수신측 정지화면\(마지막 프레임, FPS 0\)이나 음성은 들림 |
| 송출 백그라운드 | 음성 | 수신측 음성들림 |
| 수신 백그라운드 | 영상 | 음성은 들을 수 있으며 개발을 통해 백그라운드시 음성을 키거나 끌 수있음 |
| 수신 백그라운드 | 음성 | 음성은 들을 수 있으며 개발을 통해 백그라운드시 음성을 키거나 끌 수있음 |

수신시 음성 들림 여부는 아래와 같이 기능 구현이 가능합니다.

```text
if (background) { remon.mute() } else { remon.unmute() }
```

## View Scaling

### Android

Video를 보여주는 `SurfaceViewRenderer`의 `ScalingType`을 통해 비디오소스가 보이는 방식을 지정 할 수 있습니다. 

![Video Source](../.gitbook/assets/background2.png)

{% tabs %}
{% tab title="Fit" %}
**SCALE\_ASPECT\_FIT** 

뷰의 크기에 맞게 비디오 프레임의 크기가 조정됩니다. 가로 세로 비율을 유지합니다. \(검은 색 테두리가 표시 될 수 있음\)

```java
surfaceView.setScalingType(RendererCommon.ScalingType.SCALE_ASPECT_FIT);
```

![](../.gitbook/assets/fit.png)
{% endtab %}

{% tab title="Fill" %}
**SCALE\_ASPECT\_FILL**

비디오 프레임이 뷰의 크기를 채우기 위해 크기가 조정됩니다.종횡비 유지. 비디오 프레임의 일부는 ****Clipping 됩니다.

```java
surfaceView.setScalingType(RendererCommon.ScalingType.SCALE_ASPECT_FILL);
```

![](../.gitbook/assets/fill.png)
{% endtab %}

{% tab title="Balanced" %}
**SCALE\_ASPECT\_BALANCED**

FIT와 FILL 간의 절충. 비디오 프레임은 다음과 같이 채울 것입니다. 적어도 가로 세로 비율을 유지하면서 뷰를 가능하게 합니다.

```java
surfaceView.setScalingType(RendererCommon.ScalingType.SCALE_ASPECT_BALNANCED);
```

![](../.gitbook/assets/balance.png)
{% endtab %}
{% endtabs %}

## Audio Session

### iOS

오디오 세션 설정을 바꾸시려면 onJoin/onConnnect/onComplte 에서 오디오세션 설정을 변경 하시면 됩니다.

{% tabs %}
{% tab title="Swift" %}
```swift
//  이 코드는 soloAmbient 카테고리를 사용하고, speaker로 음성을 출력 합니다.
self.remonCast.onJoin { (chid) in 
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

{% tab title="Objc" %}
```objectivec
//  이 코드는 soloAmbient 카테고리를 사용하고, speaker로 음성을 출력 합니다.
[self.remonCast onJoinWithBlock:^(NSString * _Nullable chid) {
	@try {
	    NSError *error = nil;
	    [AVAudioSession.sharedInstance setCategory:AVAudioSessionCategorySoloAmbient error:&error];
	    [AVAudioSession.sharedInstance setActive:YES error:&error];
	    [AVAudioSession.sharedInstance overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&error];
	} @catch (NSException *exception) {
	    NSLog(@"error is %@",[exception description]);
	}
}];
```
{% endtab %}
{% endtabs %}

