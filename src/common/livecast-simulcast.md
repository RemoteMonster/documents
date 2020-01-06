# Simulcast

Simulcast는 비디오를 다양한 화질로 송신하고, 네트워크 상황에 따라 적절한 화질을 선택하여 수신하는 기능입니다.

자세한 설명은 아래 WebRTC Glossary를 참고해주십시오.

{% embed url="https://webrtcglossary.com/simulcast/" %}

## 지원범위

방송과 그룹통화만 simulcast를 지원합니다. 1:1 통화는 simulcast를 지원하지 않습니다.  
Simulcast는 비디오만 관여하고, 오디오는 관여하지 않습니다.

| 플랫폼 | 지원 |
| :--- | :--- |
| Web - 송출 | O |
| Web - 수신 | O |
| Android - 송출 | O \(SDK v2.6.3 이상\) |
| Android - 수신  | O |
| iOS - 송출 | O \(SDK v2.6.15 이상\) |
| iOS - 수신 | O |

아래와 같이 코덱을 지원합니다. 권장하는 코덱은 VP8 입니다.

| 코덱 | 지원여부 |
| :--- | :--- |
| VP8 | O |
| VP9 | X |
| AV1 | X |
| H.264 | O |

웹 브라우저는 최신 Chrome, Firefox를 지원합니다. WebRTC를 지원하는 여타 웹 브라우저에서 simulcast가 동작할 수 있습니다.

## 규격

송출 시 선택할 수 있는 해상도는 Capture resolution 컬럼의 값을 참고하십시오.

수신 시 선택되는 해상도는 송출 해상도와 layer 선택\(HIGH, MEDIUM, LOW\)에 따라 정해집니다. Layer 선택은 아래 "수신" 섹션에서 설명합니다.

| **Capture resolution** | LOW | MEDIUM | HIGH |
| :--- | :--- | :--- | :--- |
| 1920x1080 | 320x180 | 640x360 | 1920x1080 |
| 1280x720 | 320x180 | 640x360 | 1280x720 |
| 960x540 | under 320x180 | 480x270 | 960x540 |
| 640x360 | under 320x180 | 640x360 | disabled |
| 480x270 | under 320x180 | 480x270 | disabled |
| 320x180 | 320x180 | disabled | disabled |

#### 

Simulcast 내부에 대해 자세히 알고 싶으면, 아래 소스코드를 참고하시기 바랍니다.

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

#### Chrome의 simulcast 구현

{% embed url="https://chromium.googlesource.com/external/webrtc/+/master/media/engine/simulcast.cc" %}

#### Firefox의 simulcast 구현

{% embed url="https://hg.mozilla.org/mozilla-central/file/default/media/webrtc/trunk/webrtc/media/engine/simulcast.cc" %}

## 송출 \(beta\)

송출 시 아래와 같이 `simulcast: true`설정을 적용합니다. 

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
// sdk v2.6.3 부터 지원
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
// sdk v2.6.15 부터 지원
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

Web SDK는 fps를 낮추어 정해진 대역폭에서 움직임을 떨어뜨리고 고화질의 이미지를 보여주거나 maxBandwidth를 낮추어 저화질의 이미지를 보여주는 등의 최적화를 시도할 수 있으나, 이런 설정은 추가적인 인코더의 연산을 일으키며 가급적 변경하지 않거나 입력 신호단에서 최적의 값을 제공하는것이 좋습니다.   
  
Android, iOS SDK는 fps, maxBandwidth 등 세부적인 조절은 불가능하며, 내부에 설정된 기준대로만 화질이 선택됩니다. 

Simulcast를 적용한 송출은 모바일 기기의 CPU, 배터리 사용량을 다소 높이는 점에 유의하십시오.

## 수신 \(beta\)

수신 시 아래와 같이 Simucast layer를 선택합니다. 선택지는 HIGH, MEDIUM, LOW입니다.

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

SDK는 fps, 비디오 특성 등을 참고하여 자동으로 낮은 화질로 변경합니다. 자동으로 높은 화질로 변경하지는 않습니다. 높은 화질로 변경은 앱의 특성에 따라 개발사가 구현하시길 권합니다. 



