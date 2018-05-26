---
description: 주요 개념중 하나인 Channel에 대해 소개합니다.
---

# Channel

## Overview

RemoteMonster에서는 방송, 통신중 접속자가 공유하는 자원을 Channel이란 이름으로 제공 하고 있습니다. 이 Channel은 각각의 고유한 Id가 있으며 이들의 목록을 보거나 Id를 통해 접속 하게 됩니다.

다만 방송과 통신에서의 동작이 다른부분이 있어 아래와 같이 구분지어 사용하도록 되어있습니다.

|  | Name | Id | Methods |
| --- | --- | --- |
| Livecast | room | chid | `createRoom`, `joinRoom` |
| Communication | channel | chid | `connectChannel` |

## Livecast

{% tabs %}
{% tab title="Web" %}

{% endtab %}

{% tab title="Android" %}


{% code-tabs %}
{% code-tabs-item title="CastActivity.java" %}
```java
remonCast = RemonCast.builder().context(ListActivity.this).build();
remonCast.searchRooms();
remonCast.onSearch(calls -> {
    for (Room room : rooms) {
        id = room.getId;
    }
});
```
{% endcode-tabs-item %}
{% endcode-tabs %}
{% endtab %}

{% tab title="iOS" %}


```swift
remonCast.search { (err, results) in
    if let err = err {
        //검색 중에 발생한 에러는 remonCast.onError()를 호출 하지 않습니다.
        print(err.localizedDescription)
    } else if let results = results {
        for item:RemonSearchResult in results {
            chid = item.id
        }
    }
}

remonCast.joinRoom(chid)
```
{% endtab %}
{% endtabs %}

{% hint style="info" %}
RemonCast의 search\(\) 함수는 방송 목록을 검색 하며 RemonCall의 search\(\) 함수는 통신 목을 검색 합니다. 검색은 같은 ServiceID를 가지는 채널을 대상으로 합니다.
{% endhint %}

## Communication

{% tabs %}
{% tab title="Web" %}

{% endtab %}

{% tab title="Android" %}


{% code-tabs %}
{% code-tabs-item title="CallActivity.java" %}
```java
remonCall = RemonCall.builder().context(ListActivity.this).build();
remonCall.searchCalls();
remonCall.onSearch(calls -> {
    for (Room call : calls) {
        id = call.getId;
    }
});
```
{% endcode-tabs-item %}
{% endcode-tabs %}
{% endtab %}

{% tab title="iOS" %}


```swift
remonCall.search { (err, results) in
    if let err = err {
        //검색 중에 발생한 에러는 remonCast.onError()를 호출 하지 않습니다.
        print(err.localizedDescription)
    } else if let results = results {
        for item:RemonSearchResult in results {
            if itme.status == "WAIT" {
                chid = item.id
            }
        }
    }
}

remonCall.connectChannel(chid)
```
{% endtab %}
{% endtabs %}

