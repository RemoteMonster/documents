# Simulcast

영상 방송 송출시 고화질, 저화질의 영상을 동시에 보내고, 수신측에서 이를 선택적으로 받을 수 있으며 이 기능을 Simulcast라 합니다. 

{% embed url="https://webrtcglossary.com/simulcast/" %}

## 지원범위

Simulcast는 영상방송만 지원합니다. 송출은 여러 품질의 미디어를 동시에 보낼 수 있는 기능이며, 수신시에는 이중 원하는 품질의 미디어를 선택적으로 수신하는 기능입니다.

| 플랫폼 | 지원 |
| :--- | :--- |
| Web - 송출 | O |
| Web - 수신 | O |
| Android - 송출 | X |
| Android - 수신 | O |
| iOS - 송출 | X |
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

송출시 현재는 브라우저에서만 가능하며 아직은 모든 브라우저가 지원하고 있지 않습니다. 최신 Chrome, Firefox에서 실험적인 기능으로 제공중입니다. 아래와 같이 작동됩니다.

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
N/A
{% endtab %}

{% tab title="iOS - Swift" %}
N/A
{% endtab %}

{% tab title="iOS - ObjC" %}
N/A
{% endtab %}
{% endtabs %}

## 수신 \(beta\)

각 품질 단계를 선택이 합니다. 

기본 동작은 `HIGH`로 수신을 시도하며 미디어인코딩값, FPS 등을 참고하여 제대로 수신이 안되는 경우 자동으로 `LOW`로 변경됩니다. 환경이 다시 원할해져서 자동으로 `HIGH`로 되는 기능은 제공되지 않으며 아래의 기능을 통해 별도로 선택이 가능합니다. 자동으로 변경되는 기능은 Android, iOS로만 지원됩니다.

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
// 고화질로 변경 시청 할 때
remonCast.simulcast("HIGH", chId);
// 저화질로 변경 시청 할 때
remonCast.simulcast("LOW", chId);
```
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
let remonCast = RemonCast()
remonCast.switchBandWidth(bandwidth:.HIGH) // .HIGH || .MEDIUM || .LOW 
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
// 2.4.21 부터 지원
RemonCast *remonCast = [RemonCast new];
// .HIGH || .MEDIUM || .LOW
[remonCast objc_switchBandWidthWithBandwidth:objc_RemonBandwidth.HIGH];
```
{% endtab %}
{% endtabs %}



