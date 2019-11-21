---
description: 뷰와 레이아웃에 대해 소개합니다.
---

# Android - Media

## Overview

영상, 음성 미디어의 표출과 사용에 대해 안내합니다.

공통적인 부분은 아래를 참고하세요.

{% page-ref page="../common/media.md" %}

## View

레이아웃과 관련하여 2개의 클래스를 제공하고 있습니다. 가장 핵심이 되는, 영상을 출력하는 View인 `SurfaceViewRender` 와 SurfaceViewRender 를 효율적으로 RelativeLayout에서 배치하는데 도움을 주는 `PercentFrameLayout`으로 이루어져 있습니다. 이 중에서도 `SurfaceViewRender`가 가장 핵심이므로 먼저 살펴보겠습니다.

### SurfaceViewRender

#### Basic

Android layout 파일에서 다음과 같이 layout에 배치함으로써 `SurfaceViewRender`를 사용할 수 있습니다.

```markup
<RelativeLayout
android:layout_width="match_parent"
android:layout_height="match_parent"
android:background="@android:color/darker_gray"
android:layout_alignParentBottom="false"
android:layout_weight="2">
  <org.webrtc.SurfaceViewRenderer
    android:id="@+id/remote_video_view"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content" />
  <org.webrtc.SurfaceViewRenderer
    android:id="@+id/local_video_view"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content" />
</RelativeLayout>
```

그리고 특정 Activity에서 다음과 같이 이 View의 객체를 얻어옵니다.

```java
SurfaceViewRender localRender =
  (SurfaceViewRenderer) findViewById(R.id.local_video_view);
SurfaceViewRender remoteRender =
  (SurfaceViewRenderer) findViewById(R.id.remote_video_view);
```

이제 이 뷰를 사용할 기본 준비가 완료되었습니다. `Remon` 클래스의 객체를 생성하고 생성할 때 `Config`객체에 이 두 쌍의 뷰를 설정하면 통신이 시작됨과 함께 이 뷰에 카메라나 원격의 영상 스트림이 출력됩니다.

#### Advanced

몇가지 이 `SurfaceViewRender`의 메소드를 살펴보겠습니다.

뷰간의 Z-Order를 설정할 수 있습니다. 즉 이 뷰를 다른 뷰보다 위 위치하도록 설정합니다. 겹치는 뷰가 있을 경우 다른 뷰는 false로 하고 해당 뷰만 true로 설정해야 합니다.

```java
localRender.setZOrderMediaOverlay(true/false);
```

해당 뷰의 영상을 거울효과를 주어서 좌우가 바뀌는 방식으로 보여줄 수 있습니다.

```java
localRender.setMirror(false);
```

layout에 어떻게 채울지를 결정합니다.

```java
localRender.setScalingType(RendererCommon.ScalingType);
```

### PercentFrameLayout

안드로이드의 ConstraintLayout 과 같이 제공하려는 서비스에 맞게 레이아웃을 구성 합니다. 리모트몬스터 안드로이드 SDK에서는 영상관련 View의 배치를 쉽게 하기 위해 `PercentFrameLayout`을 제공합니다. `PercentFrameLayout`을 이용하면 영상 관련 View를 RelativeLayout안에서 자유롭게 배치하고 동적으로 움직일 수 있습니다. `PercentFrameLayout`은 layout내의 뷰들을 퍼센트 방식으로 배치합니다. 

해당 레이아웃을 relativeLayout상에서 가로세로 100%채워서 배치 합니다.

```java
layout.setPosition(0,0,100,100);
```

해당 레이아웃을 relativeLayout을 4분면으로 나눠서 좌측 하단에 50%를 차지합니다.

```java
layout.setPosition(0,50,50,50);
```

### Fill Policy

Video를 보여주는 `SurfaceViewRenderer`의 `ScalingType`을 통해 비디오소스가 보이는 방식을 지정 할 수 있습니다. 

![Video Source](../.gitbook/assets/background2.png)

#### Fit

뷰의 크기에 맞게 비디오 프레임의 크기가 조정됩니다. 가로 세로 비율을 유지합니다. 검은 색 테두리가 표시 될 수 있습니다.

```java
surfaceView.setScalingType(RendererCommon.ScalingType.SCALE_ASPECT_FIT);
```

![](../.gitbook/assets/fit.png)

#### Fill

비디오 프레임이 뷰의 크기를 채우기 위해 크기가 조정됩니다.종횡비 유지. 비디오 프레임의 일부는 Clipping 됩니다.

```java
surfaceView.setScalingType(RendererCommon.ScalingType.SCALE_ASPECT_FILL);
```

![](../.gitbook/assets/fill.png)

#### Balanced

FIT와 FILL 간의 절충입니. 비디오 프레임은 다음과 같이 채울 것입니다. 적어도 가로 세로 비율을 유지하면서 뷰를 가능하게 합니다.

```java
surfaceView.setScalingType(RendererCommon.ScalingType.SCALE_ASPECT_BALNANCED);
```

![](../.gitbook/assets/balance.png)



## Audio

RemonCall의 setSpeakerphone\(boolean\)을 이용하여,  스피커폰을 사용할지 Earpiece 모드를 사용할 지 설정 할 수 있습니다. 

{% code title="CallActivity.java" %}
```java
btnSpeakerPhoneOnOff.setOnClickListener(view -> {
            if (remonCall != null) {
                isSpeakerPhone = isSpeakerPhone ? (isSpeakerPhone = false) : (isSpeakerPhone = true);
                remonCall.setSpeakerphoneOn(isSpeakerPhone);
            }
        });
```
{% endcode %}

## Background Policy

안드로이드는 특별한 설정이 없으면 백그라운드시 모든 미디어가 송출 및 수신이 됩니다. 만약 수신등에서 백그라운드로 진입시 음소거가 필요하다면, 시스템 이벤트등을 통해 별도 처리하면 됩니다.

| 상황 | 미디어 | 내용 |
| :--- | :--- | :--- |
| 송출 백그라운드 | 영상 | 수신측에서 영상/음성 정상 수 |
| 송출 백그라운드 | 음성 | 수신측에서 음성 정상 수신 |
| 수신 백그라운 | 영상 | 음성을 들을 수 있음 |
| 수신 백그라운드 | 음성 | 음성을 들을 수 있음 |

