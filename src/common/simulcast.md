# Simulcast - beta

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

| 코 | 지원여부 |
| :--- | :--- |
| VP8 | O |
| VP9 | X |
| AV1 | X |
| H.264 | X |

## 송출 \(beta\)

현재는 브라우저에서만 가능하며 아직은 모든 브라우저가 지원하고 있지 않습니다. 최신 Chrome, Firefox에서 실험적인 기능으로 제공중입니다.

```javascript
const config = {
  rtc: {
    simulcast: true
  }
}

const remon = new Remon({ config })
```

## 수신 \(beta\)

High 과 Low 두 단계가 있으며 선택이 합니다. 기본 동작은 High로 수신을 시도하며 미디어인코딩값등을 참고하여 제대로 수신이 안되는 경우 자동으로 Low로 변경됩니다. 환경이 다시 원할해져서 자동으로 High로 되는 기능은 제공되지 않으며 아래의 기능을 통해 별도로 선택이 가능합니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const remon = new Remon()

remon.setVideoQulity('HIGH')
remon.setVideoQulity('LOW')
```
{% endtab %}

{% tab title="Android" %}
report의 report.getRemoteFrameRate\(\)의 값을 통해 자동으로 하향 Smulcast가 적용됩니다. High에서 Fps값이 0이 될경우 자동으로 Low로  Simulcast를 하여, 원활한 방송시청 환경을 제공합니다.

사용자의 네트워크 환경을 보장할수 없으므로, Low To High 의 변경은 개발서비스 환경에 맞도록 다음과 같이 사용하시면 됩니다.

```java
// 고화질로 변경 시청 할 때
remonCast.simulcast("HIGH", chId);
```

반대의 경우도 가능합니다. \(High To Low\)

```java
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



