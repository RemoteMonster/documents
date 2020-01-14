# 그룹통화 만들기\(Web\)

## 그룹통화란?

다수의 참여자가 통화에 참여하는 서비스를 위한 기능입니다. Remon SDK를 이용하여 통화 또는 방송 구현 경험이 있으면 이해에 도움이 됩니다. 통화 또는 방송 튜토리얼을 학습한 후에 그룹통화를 학습하기를 권장합니다. 

##  그룹통화 샘플 앱

* [https://sample.remotemonster.com/conference.html](https://sample.remotemonster.com/conference.html)

## 가이드의 주요 내용

1. **그룹통화를 위한 방\(room\) 만들기**
2. **방의 참여자 목록 조회**
3. **각의 참여자와 연결 수립하기**
4. **방으로부터 참여자 입장\(join\), 퇴장\(leave\) 이벤트 수신**

## 그룹통화를 위한 방\(room\) 만들기

* 모든 시작은 Remon 클래스에서  시작합니다. Remon클래스의  객체를 생성하는  방법은 다른 페이지등을 통해 참고하세요.
* Remon객체를 생성하면 바로 방\(ROOM\)을 개설할 수 있습니다.

```text
remon.createRoom("Room name");
```

* 위 코드는  'Room name'에 해당하는 방이름으로 그룹 통화방을 개설하는 코드입니다.
* 지정된 videoTag의 local  영상이  해당  방에  송출됩니다.  여기까지는  나의  영상을 Room에  송출하는 것까지 완료되는 것입니다.

## 방의 참여자 목록 조회

* 'room name' 방으로부터 참여자 목록을 조회합니다. 
* fetchRooms는 참여자 목록을 담은 배열을 리턴합니다. 배열의 각 항목은 id 속성을 갖고 있습니다.
* 참여자 목록은 앱 사용자 자신을 포함합니다. 나를 포함하여 총 3명이 방에 있으면, 3개의 항목이 조회됩니다.

```text
var searchResult= await remon.fetchRooms("Room name");
searchResult.forEach( ({id}, i) => {
  // id에 대한  처리
};
```

* 앱 사용자 자신의 id를 확인하려면 onConnect 콜백을 이용합니다.

```text
var listener= {
  onConnect(chid) {
    console.log(`My ID is ${chid} in the room`);
  },
}

// 또는, 연결이 진행된 후, getChannelId 메소드를 이용합니다.
// var myid = remon.getChannelId();


// 권장하는 방법은 아니지만, 연결이 진행된 후 Remon 객체에서도 확인할 수 있습니다.
// remon = new Remon({ config, listener });
// var myid = remon.context.channel.id; 
```

* 이제 그룹 통화 방에 속해있는 모든 참여자의 채널id를 확보하였습니다.

## 각 참여자와 연결 수립하기

* 각 참여자와의 연결은 리모트몬스터의 방송을 이용합니다.
* 각 참여자의 id는 리모트몬스터 방송 채널ID입니다.
* 위에서 조회한 각 참여자의 채널ID에 대해 Remon 객체의 시청 메소드 joinCast를 호출합니다.
* 각 참여자별로 Remon 객체를 만들어야합니다. 하나의 Remon 객체를 이용하면 안 됩니다.

```text
searchResult.forEach( ({id}, i) => {
  remon1.joinCast(id);
}
```

## 방으로부터 참여자 입장\(join\), 퇴장\(leave\) 이벤트 수신

* 그룹통화 중 수시로 참여자가 입장하고 퇴장할 수 있습니다. 참여자의 입장과 퇴장 이벤트 수신은 onRoomEvent 콜백을 이용합니다.

```text
var listener= {
  onRoomEvent(evt){
    console.log('event type: '+ evt.event); // 'join' or 'leave'
    console.log('channel id: '+ evt.channel.id); // 퇴장한 참여자의 ID
  }
}
```

* 현재 지원하는 이벤트 종류는 join과 leave입니다. 이 이벤트를 통해 새롭게 들어온 채널과 종료된 채널을 실시간으로 알 수 있습니다.

자세한 이용 방법은 그룹통화 샘플 앱의 소스코드를 참고하시기 바랍니다.

[https://sample.remotemonster.com/conference.html](https://sample.remotemonster.com/conference.html)

