# Network Environment

##  Overview

영상, 음성등 미디어를 전송하는데 있어서 네트워크 환경은 절대적인 영향을 미칩니다. 리모트몬스터의 방송과 통신기능은 기본적으로 실시간에 준하는 빠른 전송을 하기위한 다양한 기술이 접목되어 있습니다. 다만, 이러한것과는 별개로 최상의 사용자 경험을 위해 몇가지 추가적인 작업을 하는것을 권장드립니다.

### WiFi 환경

MIMO기능등을 통해 동시에 여러 단말과 통신이 가능한 기능이 없고 한 순간에 한번의 단말과 통신이 되는 일반적인 보급형 모델의 경우 한 WiFi 라우터에 여러 단말이 접속해 있고, 이들이 동시에 미디어를 수신하게 된다면 어려움을 겪을 수 있습니다. 이러한 증상으로 단말에서는 검은화면\(FPS 0\)이 나타날수 있으며 아래의 FPS 감시 등을 통해 사용자에게 안내가 가능합니다. 까페와 같은 공공장소, 사무실등 보급형 무선 라우터 환경에서는 필수적으로 권장됩니다. 

{% embed url="https://ko.wikipedia.org/wiki/MIMO" %}

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
```javascript
const listener = {
  onStat(result){
    const stat = `l.rate: ${result.localFrameRate} /r.rate: ${result.remoteFrameRate}`
    console.log(stat)
  }
}
```
{% endtab %}

{% tab title="Android" %}
```java
  @Override
  public void onStat(RemonStatReport report) {
      int fps = report.getRemoteFrameRate();
  }
```

`report.getRemoteFrameRate()` / `report.getLocalFrameRate()`를 통해 해당 연결의 fps를 확인 할 수 있습니다.

방송 SDK를 사용하는 경우, receive fps가 0이 됐을때 자동으로 로딩 인디케이터를 띄워주고 원활하게 방송이 나올경우 사라지게 됩니다.
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

{% page-ref page="callbacks.md" %}

### Media Health Report 감시 - 방송/통신 - 영상/음성

방송/통신의 영상/음성 수신에 관련된 방법입니다. SDK 내부에서 자체적인 품질값을 제공하고 있습니다. 특히 이 값이 최저 일때, 간단하게는 안내, 토스트등의 사용자 경험을 보호하는 UI를 제공하는것이 의미 있습니다. 다만, 이값이 꼭 미디어가 안보이는 상황을 의미하는 것은 아니기 때문에 간단한 안내가 적합합니다. 또는 일정 시간동안 이 값의 추이를 감시하여 별도의 처리를 하는 방법이 있을 수 있습니다. 실제 사용은 아래의 링크를 참고하세요.

e.g. 품질이 나쁠 때, 네트워크 불안정으로 인해 품질이 안 좋음을 안내하는 toast UI

{% page-ref page="callbacks.md" %}

{% hint style="info" %}
Fps와 Quality Statistics Report는 어떻게 다른가요?

Fps는 사용자경험에 매우 직접적인 결과를 나타내는 값으로 연속적인 사용자 경험을 보장하기 위한 로딩 인디케이터를 띄우는 것이 유의미 합니다.

Quality Statistics Report는 다양한 값을 참조하고 경우에 따라서는 즉각적이지 않고 실제 품질을 후행하는 지표일 수 있음으로 사용자에게 앱의 이상이 아님을 안내 하는 용도로 적합합니다.
{% endhint %}

### Simulcast\(beta\) - 방송 - 영상

영상 방송의 송출과 수신에 관련된 기능입니다. 동시에 두개이상의 품질의 미디어를 제공해서 수신자측에서 네트워크 환경에 맞게 선택적으로 품질을 정할수 있습니다.

데스크탑 브라우저에서 방송송출시 simulcast기능을 사용해 두개의 고화질, 저화질의 두가지 화질을 동시에 지원가능합니다. 이 때, 단말은 처음은 고화질로 시청을 시도하고 만약 불안정 하다면 낮은 품질로 시청을 하게 됩니다. 다만 자동으로 고품질로 시도하는 기능은 제공하고 있지 않습니다.

자세한 내용은 아래 링크를 참고하세요.

{% page-ref page="livecast-simulcast.md" %}

### WiFi - Data 통신\(3G/LTE\)간 전환 - 방송/통신 - 영상/음성

RemoteMonster의 SDK는 모바일 네트워크 연결에서 자동으로 WiFi-데이터 통신간 변경시 연속적인 연결과 미디어 송수신을 제공합니다. 단, 연결변경시에 변경되는 망의 품질등에 따라 접속이 실패 할 수 있으며, 이는 다양한 상황과 환경을 고려하여 대응해야 합니다. 

아래를 참고하여 변경실패에 대비할것을 권합니다.

{% tabs %}
{% tab title="Web" %}
n/a
{% endtab %}

{% tab title="Android" %}
```java
private ConnectivityManager manager;
private final ConnectivityManager.NetworkCallback networkCallback = new ConnectivityManager.NetworkCallback() {
    @Override
    public void onAvailable(Network network) {
        super.onAvailable(network);
        Log.i("ConnectivityManager", "Network Type : " + (manager.isActiveNetworkMetered() ? "LTE" : "WIFI"));
    }

    @Override
    public void onLost(Network network) {
        super.onLost(network);
    }
};

protected void onCreate(@Nullable Bundle savedInstanceState) {
    ...
    manager = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
    manager.registerDefaultNetworkCallback(networkCallback);
}

protected void onDestroy() {
    ...
    manager.unregisterNetworkCallback(networkCallback);
}
```

[ConnectivityManager.NetworkCallback](https://developer.android.com/reference/android/net/ConnectivityManager.NetworkCallback.html#ConnectivityManager.NetworkCallback%28%29)\(\) 의 [onAvailable](https://developer.android.com/reference/android/net/ConnectivityManager.NetworkCallback.html#onAvailable%28android.net.Network%29)\([Network](https://developer.android.com/reference/android/net/Network.html) network\)을 활용해 네트워크 변경시 재연결을 시키는 로직을 구현할 수도 있습니다.
{% endtab %}

{% tab title="iOS - Swift" %}
`onRetry` 콜백을 통해 제공 됩니다. 아래를 확인하세요.

{% page-ref page="callbacks.md" %}
{% endtab %}

{% tab title="iOS - ObjC" %}
`onRetry` 콜백을 통해 제공 됩니다. 아래를 확인하세요.

{% page-ref page="callbacks.md" %}
{% endtab %}
{% endtabs %}

