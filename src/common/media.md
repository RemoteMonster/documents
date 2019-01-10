---
description: RemoteMonster가 제공하는 실시간 품질 체크 방법을 소개합니다.
---

# Media

## Overview

최적의 미디어 품질을 얻기위한 안내입니다. 

기본적인 설정과 플렛폼별 안내는 아래를 참고하세요.

{% page-ref page="config.md" %}

{% page-ref page="../web/web-view.md" %}

{% page-ref page="../android/android-media.md" %}

{% page-ref page="../ios/ios-media.md" %}

## Bitrate

영상의 품질과 네트워크 환경에 영향을 받습니다. maxBitrate 로 조절이 가능합니다. 지나치게 낮은 maxBitrate는 인코더에 추가적인 부하로인해 품질을 저하할 수 있습니다.

{% page-ref page="config.md" %}

코덱별로 적합한 bitrate가 다릅니다. 아래를 참고하세요

### 일반

{% embed url="https://help.netflix.com/ko/node/306" %}

### VP9

{% embed url="https://developers.google.com/media/vp9/settings/vod/" %}

### h.264

{% embed url="https://bitmovin.com/video-bitrate-streaming-hls-dash/" %}

## Simulcast

여러 품질의 영상을 제공하고 수신자가 품질을 선택할 수 있도록 합니다.

{% page-ref page="livecast-simulcast.md" %}

## Hardware Acceleration

단말에서 인코딩, 디코딩의 하드웨어 가속여부는 사용성과 영상표현의 한계에 많은 영향을 미칩니다. 사용하는 코덱이 하드웨어 가속을 받으면 인코딩, 디코딩시 보다 여유로운 사용자 경험을 제공하거나, 4K 60FPS와 같은 더 높은 품질을 제공할 수 있습니다.

코덱의 하드웨어 가속은 칩셋, 플렛폼, OS, OS Version, 해상도등 원하는 미디어의 품질, 인코딩/디코딩여부등 다양한 상황에 연관되어 있으며, 목표로 하는 단말에서 결과적으로는 직접 확인하는것이 좋습니다.

방송/통신에서 송출측의 경우 FPS, Bitrate를 변경할 시 인코더가 하드웨어 가속을 받는다면, 원하는 형태의 환경을 구성할 가능성이 더 높습니다. 예를 들어 Full HD입력신호를 1000kbps와같이 낮은 대역폭으로 제공한다던지, 60FPS의 입력신호를 모바일환경을 고려하여 24FPS로 낮추는 것과 같은 입력신호를 변형하는 인코딩 상황에서 하드웨어 가속은 큰 도움이 됩니다.

아래는 환경을 확인할수 있는 방법을 안내합니다.

### Web

#### Chrome

주소표시줄에 아래를 입력함으로써 내용을 살펴 볼 수 있습니다.

* `chrome://gpu` : 코덱에 대한 하드웨어 인코딩/디코딩 여부 확인
* `chrome://media-internals` : 지원가능한 해상도/FPS등 미디어 환경

#### Firefox

주소표시줄에 `about:support` 입력하여 코덱에 대한 하드웨어 인코딩/디코딩 여부를 확인 가능합니다.

### Android

아래의 `MediaCodecList` API를 통해 확인이 가능합니다. 이중 `OMX.google.` 로시작되는것은 소프트웨어 코덱으로 이를 제외한 값들이 하드웨어로 지원되는 코덱입니다.

{% embed url="https://developer.android.com/reference/android/media/MediaCodecList" %}

### iOS

아래의 VideoToolbox API를 통해 확인이 가능합니다. h264 코덱만 지원됩니다.

{% embed url="https://developer.apple.com/documentation/videotoolbox" %}

### References

#### Intel

{% embed url="https://github.com/intel/media-driver" %}

{% embed url="https://en.wikipedia.org/wiki/Intel\_Quick\_Sync\_Video" %}

#### Nvidia

{% embed url="https://developer.nvidia.com/video-encode-decode-gpu-support-matrix" %}

#### AMD

{% embed url="https://en.wikipedia.org/wiki/Video\_Coding\_Engine" %}

{% embed url="https://en.wikipedia.org/wiki/Video\_Core\_Next" %}

#### Encoders

{% embed url="https://trac.ffmpeg.org/wiki/HWAccelIntro" %}

#### Browser

{% embed url="https://caniuse.com/\#feat=webm" %}

#### Codecs

{% embed url="https://en.wikipedia.org/wiki/VP9" %}

#### Articles

{% embed url="https://bloggeek.me/webrtc-h264-video-codec-hardware-support/" %}

