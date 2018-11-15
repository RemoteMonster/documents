---
description: RemoteMonster가 제공하는 실시간 품질 체크 방법을 소개합니다.
---

# Realtime Quality Statistics Report

## Overview

영상 및 음성 통화 중에 현재 통화의 품질이 어떠한지를 통합하여 1에서 5까지의 단계로 확인할 수 있습니다.

사용자는 간혹 자신 혹은 상대방의 네트워크 문제로 인하여 통화 품질이 안좋거나 끊어진 상황에서도 서비스의 문제라고 생각하고 불만을 제기할 수 있습니다. 때문에 사용자의 문제가 네트워크의 문제임을 사전에 알려주거나 다양한 UI 처리가 가능합니다.

현재 이 통화 품질 정보는 5초에 한번씩 받을 수 있습니다.

| 단계 | 품질 | 비고 |
| :--- | :--- | :--- |
| 1 | 매우 좋음 |  |
| 2 | 좋음 |  |
| 3 | 나쁨 |  |
| 4 | 매우 나쁨 |  |
| 5 | 방송, 통화 불능 |  |

## Usage

{% tabs %}
{% tab title="Web" %}
```javascript
const listener = {
  onStat(result){
    const stat = `State: l.cand: ${result.localCandidate} /r.cand: ${result.remoteCandidate} /l.res: ${result.localFrameWidth} x ${result.localFrameHeight} /r.res: ${result.remoteFrameWidth} ${result.remoteFrameHeight} /l.rate: ${result.localFrameRate} /r.rate: ${result.remoteFrameRate} / Health: ${result.rating}`
    console.log(stat)
  }
}
```

`Remon` 객체를 생성할 때 입력 인자로 넣는 listener의 메소드 중 `onStat()` 을 구현하여 품질 정보를 받을 수 있습니다. 위의 `result`에서 받을 수 있는 여러 정보 중 `result.rating` 이 바로 네트워크 상황에 따른 통합적인 통화 품질 정보입니다.
{% endtab %}

{% tab title="Android" %}
```java
  @Override
  public void onStat(RemonStatReport report) {
      Logger.i(TAG, "report: " + report.getHealthRating());
      String stat = "health:" + report.getHealthRating().getLevel() + "\n";
  }
```

report에는 방송/통신의 상태를 알 수있는 여러가지 값들이 있습니다. `report.getHealthRating().getLevel()`을 통해 품질을 상태를 알 수도 있고, `report.getRemoteFrameRate()` / `report.getLocalFrameRate()`를 통해 해당 연결의 fps를 확인 할 수 있습니다. 
{% endtab %}

{% tab title="Swift" %}
```swift
let remonCall = RemonCall()
remoCall.onRemonStatReport{ (stat) in 
    let rating:RatingValue = stat.getRttRating()
    let level = rating.levle
}
self.showRemoteVideoStat = true //stat 정보가 영상 위에 오버레이 됩니다.
```

onRemonStatReport 함수는 RemonStatReport 객체를 인자로 전달 합니다. 
{% endtab %}

{% tab title="Objc" %}
```objectivec
[self.remonCast onRemonStatReportWithBlock:^(RemonStatReport * _Nonnull stat) {
    RatingValue *rating = [stat getRttRating];
    // Do something
}];
```
{% endtab %}
{% endtabs %}

## Simulcast

simulcast는 High 과 Low 두 단계가 있습니다.

{% tabs %}
{% tab title="Web" %}
```javascript

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

{% tab title="Swift" %}
```swift

```
{% endtab %}

{% tab title="Objc" %}
```objectivec

```
{% endtab %}
{% endtabs %}



