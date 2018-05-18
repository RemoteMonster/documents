# Livecast

## 기본 설정

방송을 하기 전에 프로젝트 설정을 진행 합니다.

{% page-ref page="../getting-started-livecasting/ios.md" %}

* 방송을 만드는 경우에는 broadcast 값을 on으로 시청인 경우에는 off로 설정 합니다.

![](../.gitbook/assets/basic_config4.png)

* broadcast 값을 코드상으로도 설정할 수 있습니다.

```text
remonCast.broadcast = true
remonCast.createRoom()
```

또는

```text
let config = RemonConfig()
config.channelType = "BROADCAST"
remonCast.createRoom(config)
```

## 개발

RemonCast 클래스는 방송 생성 및 시청을 위한 기능을 제공합니다. RemonCast 클래스의 createRoom\(\) 함수와 joinRoom\(\) 함수를 이용하여 방송 기능을 이용 할 수 있습니다.

* 방송생성

```
remonCast.createRoom()
```

* 방송시청

```
remonCast.joinRoom("chid")
```

Remon은 방송 생성 및 시청 중에  상태 추적을 돕기 위한 Observer 함수를 제공 합니다.

```text
remonCast.onInit {
    // UI 처리등 remon이 초기화 되었을 때 처리하여야 할 작업
}

remonCast.onComplete {
    // 방송 생성 및 시청 준비 완료
}

rmonCast.onClose {
    // 방송 종료
}
```

Remon이 제공하는 Observer 함수에 대한 더 자세한 내용은 Oserver 가이드 문서를 참조 하세요

{% page-ref page="observer.md" %}

방송을 시청 하기 위해서는 시청 하려는 채널이 ID가 필요 합니다. 채널 ID는 방송이 생성 될 때 마다 변경 되는 유니크 값입니다. Remon는 시청 하려는 채널에 쉽게 접근 할 수 있도록 돕는 검색 기능을 제공 합니다.

```text
remonCast.search { (error, results) in
    // 채널 목록 처리
}
```

채널 검색에 대한 더 자세한 **'Search'**에 자세히 설명 되어 있습니다.

{% page-ref page="search.md" %}



