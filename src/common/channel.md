# Channel

## Overview

RemoteMonster에서는 방송, 통신중 접속자가 공유하는 자원을 채널이란 이름으로 제공 하고 있습니다. 이 채널은 처음 만들때 생성되어 각각의 고유한 Id를 제공하며, 이들의 목록을 가져오거나 검색하여 특정 채널에 접속 하게 됩니다. 추가적으로 채널에 Name을 별칭으로 지정하여 좀 더 편하게 사용할 수 있습니다.

|  | Class | Id\(unique\) | Name | Methods | Callbacks |
| :--- | :--- | :--- | :--- | :--- | :--- |
| Livecast | remonCast | ChannelId | ChannelName | `create`, `join`, `fetchCasts` | `onCreate`, `onJoin` |
| Communication | remonCall | ChannelId | ChannelName | `connect`, `fetchCalls` | `onConnect`, `onComplete` |

전체적인 흐름과 여기에 대응하는 Callback은 아래를 참고하세요.

{% page-ref page="../overview/flow.md" %}

{% page-ref page="callbacks.md" %}

## Livecast

방송에서 방송 목록을 얻는 방법입니다. 일반적으로 방송 목록에서 집입할 방송을 찾는 UI에 자주 사용됩니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const remonCast = new Remon()
const casts = await remonCast.fetchCasts()    // Return Promise
```
{% endtab %}

{% tab title="Android" %}
```java
remonCast = RemonCast.builder().context(ListActivity.this).build();
remonCast.fetchCasts();
remonCast.onFetch(casts -> {
    for (Channel cast : casts) {
        myChannelId = cast.getId;
    }
});

remonCast.join(myChannelId);
```
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
remonCast.fetchCasts { (err, results) in
    if let err = err {
        // 검색 중에 발생한 에러는 remonCast.onError()를 호출 하지 않습니다.
        print(err.localizedDescription)
    } else if let results = results {
        for cast:RemonSearchResult in results {
            myChannelId = cast.id
        }
    }
}

remonCast.join(myChannelId)
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
RemonCast *remonCast = [[RemonCast alloc]init];
[remonCast fetchCastsWithIsTest:YES complete:^(NSArray<RemonSearchResult *> * _Nullable chs) {
     if (chs != nil) {
          for (RemonSearchResult *item in chs) {
               // Do Somethig                         
           }
     }                       
}];
```
{% endtab %}
{% endtabs %}

## Communication

통신에서 통화 목록을 얻는 방법입니다. 랜덤 채팅과 같은 상황에서 쓰이며 일반적으로는 잘 사용되지 않습니다.

{% tabs %}
{% tab title="Web" %}
```javascript
const remonCall = new Remon()
const calls = await remonCall
  .fetchCasts()                             // Return Promise
  .filter(item => item.status === "WAIT")
```
{% endtab %}

{% tab title="Android" %}
```java
remonCall = RemonCall.builder().build();
remonCall.fetchCalls();
remonCall.onFetch(calls -> {
    for (Channel call : calls) {
        if (call.getStatus.equals("WAIT")) {   // Only WAIT channels
            myChannelId = call.getId;
        }
    }
});

remonCall.connect(myChannelId)
```
{% endtab %}

{% tab title="iOS - Swift" %}
```swift
let remonCall = RemonCall()
remonCall.fetchCalls { (err, results) in
    if let err = err {
        //검색 중에 발생한 에러는 remonCall.onError()를 호출 하지 않습니다.
        print(err.localizedDescription)
    } else if let results = results {
        for call:RemonSearchResult in results {
            if itme.status == "WAIT" {        // Only WAIT channels
                myChannelId = call.id
            }
        }
    }
}

remonCall.connect(myChannelId)
```
{% endtab %}

{% tab title="iOS - ObjC" %}
```objectivec
RemonCall *remonCall = [[RemonCall alloc]init];
[remonCall fetchCastsWithIsTest:YES complete:^(NSArray<RemonSearchResult *> * _Nullable chs) {
     if (chs != nil) {
          for (RemonSearchResult *item in chs) {
               if ([item.status isEqualToString@"WAIT"]) {
                    // Do Somethig
               }                  
           }          
     }                       
}];
```
{% endtab %}
{% endtabs %}

