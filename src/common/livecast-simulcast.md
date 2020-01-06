# Simulcast

영상 방송 송출시 고화질, 저화질의 영상을 동시에 보내고, 수신측에서 이를 선택적으로 받을 수 있으며 이 기능을 Simulcast라 합니다. 

{% embed url="https://webrtcglossary.com/simulcast/" %}

## 지원범위

Simulcast는 영상방송과 Conference Call 에서만 지원합니다. 송출은 여러 품질의 미디어를 동시에 보낼 수 있는 기능이며, 수신시에는 이중 원하는 품질의 미디어를 선택적으로 수신하는 기능입니다.

| 플랫폼 | 지원 |
| :--- | :--- |
| Web - 송출 | O |
| Web - 수신 | O |
| Android - 송출 \(v2.6.3 이상\) | O |
| Android - 수신 | O |
| iOS - 송출 \(v2.6.15 이상\) | O |
| iOS - 수신 | O |

현재 지원하는 코덱은 VP8 입니다.

| 코덱 | 지원여부 |
| :--- | :--- |
| VP8 | O |
| VP9 | X |
| AV1 | X |
| H.264 | O |

## 규격

송출은 시뮬케스트를 지원해야 하며, 수신은 특별한 기능의 지원여부와 상관없이 서버에서 제공하는 미디어를 받게 됩니다.

송출시 현재는 일부 브라우저와 iOS, Android 에서 가능하며 아직은 모든 브라우저가 지원하고 있지 않습니다. 최신 Chrome, Firefox 에서 실험적인 기능으로 제공중입니다. 아래와 같이 작동됩니다.

| **Capture resolution** | Layer 1 | Layer 2 | Layer 3 |
| :--- | :--- | :--- | :--- |
| 1920x1080 | 320x180 | 640x360 | 1920x1080 |
| 1280x720 | 320x180 | 640x360 | 1280x720 |
| 960x540 | under 320x180 | 480x270 | 960x540 |
| 640x360 | under 320x180 | 640x360 | disabled |
| 480x270 | under 320x180 | 480x270 | disabled |
| 320x180 | 320x180 | disabled | disabled |

```cpp
struct SimulcastFormat {
  int width;
  int height;
  // The maximum number of simulcast layers can be used for
  // resolutions at |widthxheigh|.
  size_t max_layers;
  // The maximum bitrate for encoding stream at |widthxheight|, when we are
  // not sending the next higher spatial stream.
  int max_bitrate_kbps;
  // The target bitrate for encoding stream at |widthxheight|, when this layer
  // is not the highest layer (i.e., when we are sending another higher spatial
  // stream).
  int target_bitrate_kbps;
  // The minimum bitrate needed for encoding stream at |widthxheight|.
  int min_bitrate_kbps;
};
// These tables describe from which resolution we can use how many
// simulcast layers at what bitrates (maximum, target, and minimum).
// Important!! Keep this table from high resolution to low resolution.
// clang-format off
const SimulcastFormat kSimulcastFormats[] = {
  {1920, 1080, 3, 5000, 4000, 800},
  {1280, 720, 3,  2500, 2500, 600},
  {960, 540, 3, 900, 900, 450},
  {640, 360, 2, 700, 500, 150},
  {480, 270, 2, 450, 350, 150},
  {320, 180, 1, 200, 150, 30},
  {0, 0, 1, 200, 150, 30}
};
```

#### Chrome

{% embed url="https://chromium.googlesource.com/external/webrtc/+/master/media/engine/simulcast.cc" %}

#### Firefox

{% embed url="https://hg.mozilla.org/mozilla-central/file/default/media/webrtc/trunk/webrtc/media/engine/simulcast.cc" %}

## 송출 \(beta\)

송출시 `simulcast: true`설정을 통해 사용하며 위의 표와 같이 작동합니다.  영상의 `width`, `height`, `fps` 및 `maxBandwidth` 에 의해 대역폭과 영상품질이 변화됩니다. 

`fps`를 낮추어 정해진 대역폭에서 움직임을 떨어뜨리고 고품질의 이미지를 보여주거나 `maxBandwidth`를 조절하여 대역폭을 저감하는 등의 최적화를 시도할 수 있으나, 이런 변화는 전부 추가적인 인코더의 연산을 필요로 하며 가급적 변경하지 않거나 입력 신호단에서 최적의 값을 제공하는것이 좋습니다.   
  
 Android, iOS의 경우 simulcast 프로퍼티를 활성화 하는 것으로 시뮬캐스트가 동작합니다. 시뮬캐스트를 위한 fps, maxBandwidth 등 세부적인 조절은 불가능하며, 내부에 설정된 대역폭 기준에 따라 영상품질이 변화 됩니다. 시뮬캐스트는 카메라 입력에 대해 여러개의 사이즈로 다중 인코딩이 일어납니다. 모바일 기기의 CPU, 배터리 사용량이 높아지므로, 사용환경에 대한 고려가 필요합니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const config = {
  rtc: {
    simulcast: true
  },
  media : {
    video : {
      width: 1280,
      height: 720
    }
  }
}

const remon = new Remon({ config })
```
{% endtab %}

{% tab title="Android" %}
```java
// sdk v2.6.3 부터 지
// RemonCast
RemonCast.builder()
    .context( android_context )
    .videoCodec( "VP8" )
    .videoWidth( 1920 )
    .videoHeight( 1080 )
    .simulcast( true )
    .build();

// RemonConference
var remonConferece = RemonConference()
remonConference.create {
    it.context( android_context )
    .videoWidth( 1920 )
    .videoHeight( 1080 )
    .videoCodec( "VP8" )
    .simulcast( true )
}.then{
}.close{
}
```
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
// sdk v2.6.15 부터 지
// RemonCast
let remonCast = RemonCast()
remonCast.videoWidth = 1920
remonCast.videoHeight = 1080
remonCast.videoCodec = "VP8"
remonCast.simulcast = true

// RemonConference
var remonConference = RemonConference()
remonConference.create{ participant in
    participant.videoWidth = 1920
    participant.videoHeight = 1080
    participant.videoCodec = "VP8"
    participant.simulcast = true
}.then{ channel in
}.close{
}.error{ error in
}
    
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
// sdk v2.6.15 부터 지원
RemonCast *remonCast = [RemonCast new];
remonCast.videoWidth = 1920;
remonCast.videoHeight = 1080;
remonCast.videoCodec = "VP8";
remonCast.simulcast = true;
```
{% endtab %}
{% endtabs %}

## 수신 \(beta\)

각 품질 단계를 선택이 합니다. 

기본 동작은 `HIGH`로 수신을 시도하며 미디어인코딩값, FPS 등을 참고하여 제대로 수신이 안되는 경우 자동으로 `LOW`로 변경됩니다. 환경이 다시 원할해져서 자동으로 `HIGH`로 되는 기능은 제공되지 않으며 아래의 기능을 통해 별도로 선택이 가능합니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const remon = new Remon()

remon.setVideoQulity('HIGH')
remon.setVideoQulity('LOW')
```
{% endtab %}

{% tab title="Android" %}
```java
// RemonCast
remonCast.switchSimulcastLayer( "HIGH" ); // "HIGH", "MEDIUM", "LOW"

// RemonConference
var participant = remonConference.getClient(1) as RemonParticipant
participant.switchSimulcastLayer( "LOW" )
```
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
// RemonCast
let remonCast = RemonCast()
remonCast.switchSimulcastLayer(bandwidth:.HIGH) // .HIGH || .MEDIUM || .LOW 

// RemonConference
let participant = remonConference.getClient(index: 1 )
participant?.switchSimulcastLayer(bandwidth:.LOW)
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
// 2.4.21 부터 지원
RemonCast *remonCast = [RemonCast new];

// .HIGH || .MEDIUM || .LOW
[remonCast switchSimulcastLayerWithBandwidth:objc_RemonBandwidth.HIGH];
```
{% endtab %}
{% endtabs %}



