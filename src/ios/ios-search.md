# iOS - Search

## 방송 및 통신 목록 검색 하기

Remon는 편리한 방송 및 통신 참여를 위하여 채널 검색 기능을 제공 합니다. RemonController의 하위 클래스인 RemonCall 또는 RemonCast를 이용하여 방송 및 통신 목록을 검색할 수 있습니다.

```
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

```text
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

{% hint style="info" %}
RemonCast의 search\(\) 함수는 방송 목록을 검색 하며 RemonCall의 search\(\) 함수는 통신 목을 검색 합니다. 검색은 같은 ServiceID를 가지는 채널을 대상으로 합니다.
{% endhint %}



