# Web - Overview

* Remon클래스는 가장 핵심이 되는 클래스로서 다음과 같은 메소드를 제공합니다.

  ```javascript
  // 생성자
  class Remon({config:config, listener:listener})
  ```

* Config 정보, 콜백메소드 처리를 위한 Listener를 입력값으로 넣으면 원격의 리모트몬스터 서버와 연결이 됩니다.
* 연결이 완료되면 listener의 onInit메소드와 onStateChange메소드가 호출됩니다.

**1:1 통신하기**

* 만약 객체가 생성후 바로 상대편과 연결을 하고 싶다면 Remon의 connectChannel 메소드를 호출하면 됩니다.

  ```javascript
  // 1:1 방에 통화 연결
  Remon.connectChannel(String channelId)
  ```

* 1:1 방에 접속하거나 방을 만드는 명령입니다. 주어진 이름의 방이 없을 경우 방을 만들고 이미 방이 있을 경우 방에 접속합니다. 물론 사전에 방 이름이 있어야 하겠지만 만약 방 이름이 없을 경우 RemoteMonster는 고유한 방 이름을 생성해서 listener의 onCreateChannel메소드를 통해 방이름을 반환하게 됩니다.
* 메소드는 하나이지만 방이름이 이미 존재하는지 여부에 따라 없으면 listener의 onCreateChannel메소드, 있으면 onConnectChannel 메소드가 호출된다고 보면 되며, onConnectChannel메소드 호출시 상대편과 연결이 완료되었음을 의미합니다.
* 상대편과 통화 연결에 완전히 성공하는 경우 Observer의 onStateChange의 STATE.COMPLETE 상태가 입력값으로 들어옵니다. 이 때 필요한 서비스를 진행하면 됩니다.

**방송하기 & 방송 시청하기**

```javascript
Remon.createCast(roomname); // 방송용 방 만들기
Remon.joinCast(room id); //방송용 방 시청하기
```

* 방송용 방을 만들거나 시청하는 명령입니다.

```javascript
// 1:1 방을 검색
Remon.search(String channelId)
// 방송용 방을 검색
Remon.liveRooms()
```

* 주어진 인자값에 해당하는 방이름이 있는지 검색하여 알려줍니다. 인자값이 없으면 모든 방 정보를 알려줍니다.
* 검색의 결과는 return값을 통해서도 받을 수 있고 Observer의 onSearch를 통해서 받을 수 있습니다.
* 
**그외의 명령들**

```javascript
// 자신의 영상을 mute하기
pauseLocalVideo(bool)
// 원격의 영상을 mute하기
pauseRemoteVideo(bool)
// 자신의 음성을 mute하기
muteLocalAudio(bool)
// 원격의 영상을 mute하기
muteRemoteAudio(bool)
```

**종료하기**

```javascript
Remon.close();
```

* Remon을 사용한 이후에는 반드시 close를 해주어야 합니다. 통신에 문제가 생기면 알아서 close가 되기도 하지만 남아있는 자원이 만에 하나 있다면 기기 성능에 아무래도 영향을 미칠 수 있습니다.
* 재연결이 필요한 경우에도 close를 하고 다시 Remon객체를 생성하는 것을 권합니다.
* 명시적으로 close를 할 경우 상대 peer에게 onDisconnectChannel 이벤트가 발생합니다. 또한 명시적이지 않고 브라우저를 그냥 닫았다면  상대편에게는 onStateChange 이벤트가 발생하면서 STATE.CLOSE 혹은 STATE.FAIL의 이벤트가 발생합니다. 만약 네트워크가 안좋아졌거나 끊어지면 상대편에게 onError의 type=ICEFailedError이 발생합니다.

```javascript
Remon.sendMessage(userMessage)
```

* 연결이 된 상태에서 상대에게 메시지를 전달할 수 있습니다.
* 메시지를 받는 것은 listener의 onMessage를 통해서 받을 수 있습니다. 주로 통신용으로만 사용합니다

