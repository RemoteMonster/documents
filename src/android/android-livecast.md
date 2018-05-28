---
description: Android로 간단한 방송 앱을 개발합니다.
---

# Android - Livecast

## 환경구성

아래를 참고하여 개발환경을 구성 하세요.

{% page-ref page="android-getting-start.md" %}

## 개발

### Service Key 등록

아래를 참고하여 ServiceKey를 등록하세요.

### View 등록

layout.xml 에 RemoteMonster SDK가 제공하는 전용 View를 지정합니다. 

#### 방송 송출

방송송출 경우 Local View를 Layout에 추가합니다.

방송 송출자라면 송출되는 자신의 화면을 보고 싶을 것입니다. 때문에 미리 자신이 원하는 View에 다음과 같이 localView 를 추가합니다. PercentFrameLayout은 동적으로 다양한 비율로 화면 크기와 위치를 조절하는 레이아웃이며 실제 영상을 보여주는 뷰는 SurfaceViewRenderer입니다.

```markup
<com.remotemonster.sdk.PercentFrameLayout
    android:id="@+id/perFrameLocal"
    android:layout_width="match_parent"
    android:layout_height="match_parent">
    <org.webrtc.SurfaceViewRenderer
        android:id="@+id/surfRendererLocal"
        android:layout_width="match_parent"
        android:layout_height="match_parent" />
</com.remotemonster.sdk.PercentFrameLayout> 
```

#### 방송 시청

방송시청의 경우 Remote View를 Layout에 추가합니다.

시청자에겐 방송자의 Video를 제공해야 합니다. 때문에 미리 자신이 원하는 View에 다음과 같이 RemoteView 를 추가합니다. PercentFrameLayout은 동적으로 다양한 비율로 화면 크기와 위치를 조절하는 레이아웃이며 실제 영상을 보여주는 뷰는 SurfaceViewRenderer입니다.

```markup
<com.remotemonster.sdk.PercentFrameLayout
    android:id="@+id/perFrameRemote"
    android:layout_width="match_parent"
    android:layout_height="match_parent">
    <org.webrtc.SurfaceViewRenderer
        android:id="@+id/surfRendererRemote"
        android:layout_width="match_parent"
        android:layout_height="match_parent" />
</com.remotemonster.sdk.PercentFrameLayout>
```

#### 참고

추가적으로 View를 다루는 방법은 아래를 참고하세요.

{% page-ref page="android-view.md" %}

### RemonCast 생성

* 이제 코딩의 시간입니다. Key와 ServiceID는 넣지 않아도 됩니다. 자동으로 테스트용 key와 serviceId로 설정됩니다. 나중에 본격적으로 Remote Monster를 사용하고 싶다면 회원가입을 하고 키를 발급받아서 입력하면 됩니다.

#### 방송 송출

{% code-tabs %}
{% code-tabs-item title="CastActivity.java" %}
```java
remonCast = RemonCast.builder()
        .context(CastActivity.this)
        .localView(surfRendererlocal)        // 자신 Video Renderer
        .build();
```
{% endcode-tabs-item %}
{% endcode-tabs %}

#### 방송 시청

{% code-tabs %}
{% code-tabs-item title="ViewerActivity.java" %}
```java
castViewer = RemonCast.builder()
        .context(ViewerActivity.this)
        .remoteView(surfRendererRemote)        // 방송자의 video Renderer
        .build();
```
{% endcode-tabs-item %}
{% endcode-tabs %}

### RemonCast 방송 송출,시청

`RemonCast` 클래스는 방송 생성 및 시청을 위한 기능을 제공합니다. `RemonCast` 클래스의 `createRoom` 함수와 `joinRoom` 함수를 이용하여 방송 기능을 이용 할 수 있습니다. 

{% code-tabs %}
{% code-tabs-item title="CastActivity.java" %}
```java
remonCast.createRoom();       
```
{% endcode-tabs-item %}
{% endcode-tabs %}

{% code-tabs %}
{% code-tabs-item title="ViewerActivity.java" %}
```java
castViewer.joinRoom(connectChId);           // 들어가고자 하는 channel
```
{% endcode-tabs-item %}
{% endcode-tabs %}

*  RemoteMonster는 임의의 방이름을 생성해서 반환값으로 방이름을 반환합니다. 다음에 그 방으로 입장하고 싶은 이는 그 반환된 값으로 `joinRoom`하면 됩니다. 그렇지 않고 직접 방 이름을 넣어서 방을 생성하거나 방을 접속할 수도 있습니다.



### 

### Callback 메소드 처리하기

`Remon`은 방송 생성 및 시청 중에 상태 추적을 돕기 위한  Callback을 제공 합니다.

생성된 remonCast에 eventListener를 등록해 줍니다.

{% code-tabs %}
{% code-tabs-item title="CastActivity.java" %}
```java
remonCast.onInit(() -> Log("onInit"));
remonCast.onConnect(() -> Log("onConnect"));
remonCast.onComplete(() -> Log("onComplete"));
remonCast.onClose(() -> Log("onClose"));
remonCast.onError(e -> Log("error code : " + e.getRemonCode().toString()));
remonCast.onStat(report -> Log(report.getFullStatReport()));
```
{% endcode-tabs-item %}
{% endcode-tabs %}



### 방송 송출, 시청종료 처리

* 모든 통신이 끝났을 경우 꼭 RemonCast객체를 `close()`해주어야 합니다. close를 통해서 모든 통신자원과 미디어 스트림 자원이 해제됩니다.

```java
remonCast.close();
```

