---
description: Android로 간단한 방송 앱을 개발합니다.
---

# Android - Livecast

## 기본 설정

방송을 하기 전에 프로젝트 설정을 진행 합니다.

{% page-ref page="android-getting-start.md" %}

## 개발

* RemonCast를 활용한 방송은 다음과 같은 순서로 개발이 진행됩니다.
  1. Remon SDK 프로젝트 build.gradle 등록
  2. Android Permission 요청
  3. layout.xml 에 영상전용 View 등록
  4. RemonCast Builder로 build
  5. RemonCast 방송 `createRoom`\(송출\) 혹은 `joinRoom`\(시청\)
  6. Callback 메소드 처리하기
  7. 방송 송출,  시청종료 처리
* 이제 하나씩 따라해봅시다. 예상 소요시간은 약 15분 입니다.

### layout.xml에 영상전용 View 등록

{% tabs %}
{% tab title="방송 송출" %}
방송송출 경우 Local View를 Layout에 추가합니다.

* 방송 송출자라면 송출되는 자신의 화면을 보고 싶을 것입니다. 때문에 미리 자신이 원하는 View에 다음과 같이 localView 를 추가합니다. `PercentFrameLayout`은 동적으로 다양한 비율로 화면 크기와 위치를 조절하는 레이아웃이며 실제 영상을 보여주는 뷰는 `SurfaceViewRenderer`입니다.

{% code-tabs %}
{% code-tabs-item title="activity\_caster.xml" %}
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
{% endcode-tabs-item %}
{% endcode-tabs %}
{% endtab %}

{% tab title="방송 시청" %}
방송시청의 경우 Remote View를 Layout에 추가합니다.

* 시청자에겐 방송자의 Video를 제공해야 합니다. 때문에 미리 자신이 원하는 View에 다음과 같이 RemoteView 를 추가합니다. `PercentFrameLayout`은 동적으로 다양한 비율로 화면 크기와 위치를 조절하는 레이아웃이며 실제 영상을 보여주는 뷰는 `SurfaceViewRenderer`입니다.

{% code-tabs %}
{% code-tabs-item title="activity\_viewer.xml" %}
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
{% endcode-tabs-item %}
{% endcode-tabs %}
{% endtab %}
{% endtabs %}



### RemonCast의 초간단 생성

* 이제 코딩의 시간입니다. Key와 ServiceID는 넣지 않아도 됩니다. 자동으로 테스트용 key와 serviceId로 설정됩니다. 나중에 본격적으로 Remote Monster를 사용하고 싶다면 회원가입을 하고 키를 발급받아서 입력하면 됩니다.
* RemonCast를 build할 때 여러가지 환경 설정을 할 수 있습니다. 여기서는 일단 제일 간단한 방법으로 진행하겠습니다.
* 필요에 따라서는 영상통화가 아닌 음성통화만 사용하게 할 수도 있고 코덱을 바꾸거나 해상도를 바꿀 수도 있습니다.

방송 송출의 경우

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

방송 시청의 경우

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

{% hint style="info" %}
`createRoom`, `joinRoom` 함수에 `RemonConfig`를 직접 전달 할 수도있습니다.

[Config 확인하러 가기.]()
{% endhint %}

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

