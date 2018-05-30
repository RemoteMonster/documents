# iOS - View

Interface Builder를 통해 StoryBoard를 이용하여 환경설정과 개발을 할 수 있으며, 제공된 SDK를 통해 개별 코드로 View를 구성할 수 있습니다.

Interface Builder를 통한 기본적인 사용은 아래를 참고하세요.

{% page-ref page="ios-getting-start.md" %}

Interface Builder 빌더를 사용하지 않는 다면 아래 코드를 참조 하세요.

```swift
let remonCall = RemonCall()
remonCall.remoteView = myRemoteView
remonCall.localView = myLocalView
```

{% hint style="info" %}
RemonController에 remoteView 또는 localView를 지정 했다면 RemonController는 지정된 뷰에 비디오 렌더링뷰를 추가 하고, 지정된 뷰의 변화를 추적하여 지정 뷰의 크기에 맞게 비디오 렌더링뷰를 설정 합니다.
{% endhint %}



