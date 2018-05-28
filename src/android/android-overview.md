---
description: 안드로이드에서 개발개요를 설명합니다.
---

# Android - Overview

## OverView

![](../.gitbook/assets/image%20%283%29.png)

`Remon Class`는 Remon SDK 에서 가장 핵심이 되는 클래스 입니다. `Remon Config` 와 `Remon Observer`의 세팅으로 Remon이 제공하는 통신 기능과 방송 기능을 이용 할 수도 있지만 이는 복잡하고, 따분한 작업이 될 것입니다. 그래서 SDK 사용자가 좀 더 쉽고 빠르게 Remon를 이용 할 수 있도록 복잡 하고, 반복적인 기본 작업을 포함 하고 있는 `RemonCall Class` 와 `RemonCast Class`를 제공 합니다. 

단순한 생성 방식과 손쉬운 로직 처리로 강력한 방송, 통신 기능을 구현할 수 있습니다.

## RemonCall Class

* RemonCall Class는 통신기능을 쉽고 빠르게 만들수있는 메소드를 제공합니다.
* Remon Class에서 통신과 관련된 메소드는 모두 사용 가능합니다.

```java
remonCall = RemonCall.builder()
        .context(CallActivity.this)        
        .localView(surfRendererLocal)        //나의 video Renderer
        .remoteView(surfRendererRemote)      //상대방 video Renderer
        .build();
remonCall.connectChannel(connectChId);
```

{% page-ref page="android-communication.md" %}

## RemonCast Class

* RemonCast Class를 이용하면 방송송출과 시청기능을 쉽고 빠르게 만들 수 있습니다.
* Remon Class에서 방송과 관련된 메소드는 모두 사용 가능합니다.

방송 송출의 경우

{% code-tabs %}
{% code-tabs-item title="CastActivity.java" %}
```java
remonCast = RemonCast.builder()
        .context(CastActivity.this)
        .localView(surfRendererlocal)        // 자신 Video Renderer
        .build();
remonCast.createRoom(connectChId);           // 들어가고자 하는 channel
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
castViewer.joinRoom(connectChId);              // 들어가고자 하는 channel
```
{% endcode-tabs-item %}
{% endcode-tabs %}

{% page-ref page="android-livecast.md" %}

## Resources

### Downloads, Change Log, Examples

{% embed data="{\"url\":\"https://github.com/remotemonster/android-sdk/\",\"type\":\"link\",\"title\":\"RemoteMonster/android-sdk\",\"description\":\"android-sdk - RemoteMonster android SDK & examples\",\"icon\":{\"type\":\"icon\",\"url\":\"https://github.com/fluidicon.png\",\"aspectRatio\":0},\"thumbnail\":{\"type\":\"thumbnail\",\"url\":\"https://avatars2.githubusercontent.com/u/20677626?s=400&v=4\",\"width\":400,\"height\":400,\"aspectRatio\":1}}" %}

RemoteMonster Android SDK에 대한 모든 정보를 얻을 수 있습니다. 다양한 예제를 코드로 검토하세요.

### Reference Document

{% embed data="{\"url\":\"https://remotemonster.github.io/android-sdk\",\"type\":\"link\",\"title\":\"Generated Documentation \(Untitled\)\"}" %}

SDK의 기능을 세부적으로 안내합니다.

