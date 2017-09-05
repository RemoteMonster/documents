# 리모트몬스터 안드로이드의 Remon 클래스
- Remon클래스는 가장 핵심이 되는 클래스로서 다음과 같은 메소드를 제공합니다.
```java
// 생성자
public Remon(Context ctx, Config config, RemonObserver observer)
```
- 안드로이드 컨텍스트와 리모트몬스터 Config, 콜백메소드 처리를 위한 Observer를 입력값으로 넣으면 원격의 리모트몬스터 서버와 연결이 됩니다.
- 연결이 완료되면 Observer의 onInit메소드와 onStateChange메소드가 호출됩니다.
- 만약 객체가 생성후 바로 상대편과 연결을 하고 싶다면 onInit메소드 때 Remon의 connectChannel 메소드를 호출하면 됩니다.
```java
// 방에 통화 연결
public void connectChannel(String channelId)
```
- 방에 접속하거나 방을 만드는 명령입니다. 주어진 이름의 방이 없을 경우 방을 만들고 이미 방이 있을 경우 방에 접속합니다. 물론 사전에 방 이름이 있어야 하겠지만 만약 방 이름이 없을 경우 RemoteMonster는 고유한 방 이름을 생성해서 Observer의 onCreateChannel메소드를 통해 방이름을 반환하게 됩니다.
- 메소드는 하나이지만 방이름이 이미 존재하는지 여부에 따라 없으면 Observer의 onCreateChannel메소드, 있으면 onConnectChannel 메소드가 호출된다고 보면 되며, onConnectChannel메소드 호출시 상대편과 연결이 완료되었음을 의미합니다.
- 상대편과 통화 연결에 완전히 성공하는 경우 Observer의 onStateChange의 STATE.COMPLETE 상태가 입력값으로 들어옵니다. 이 때 필요한 서비스를 진행하면 됩니다.
```java
// 방을 검색
public void searchChannels(String channelId)
```
- 주어진 인자값에 해당하는 방이름이 있는지 검색하여 알려줍니다. 인자값이 없으면 모든 방 정보를 알려줍니다.
- 검색의 결과는 Observer의 onSearchChannels를 통해서 받을 수 있습니다.
```java
public void sendMessage(String msg);
```
- 통신 중에 상대방에게 문자 형태의 메시지를 전달합니다. 이 기능을 활용하여 채팅에 활용하거나 내부 로직에 사용할 수 있습니다.
- Observer의 onMessage 메소드를 통해서 상대편의 메시지를 수신할 수 있습니다.
```java
public void setVideoEnabled(boolean enable)
public void setLocalVideoEnabled(boolean enable)
public void setRemoteVideoEnabled(boolean enable)
public void setAudioEnabled(boolean enable)
public void setMicMute(boolean mute);
```
- 로컬/리모트 영상, 음성을 잠시 pause하거나 다시 실행시키는 기능입니다. 아울러 자신의 기기의 마이크를 잠시 꺼두는 기능도 제공합니다. setVideoEnabled는 전체 영상을 끄고 킬 수 있습니다.
```java
public void switchCamera();
```
- 로컬 카메라가 전면과 후면이 있을 경우 이것을 토글시켜서 변경하는 것이 가능합니다.
```java
public void showLocalVideo();
```
- Remon 객체 생성시 Local video를 활성화하고 싶다면 showLocalvideo메소드를 호출합니다. connectChannel하기 전에 미리 자신의 카메라 화면을 볼 수 있습니다.
```java
public void close();
```
- Remon을 사용한 이후에는 반드시 close를 해주어야 합니다. 통신에 문제가 생기면 알아서 close가 되기도 하지만 남아있는 자원이 만에 하나 있다면 기기 성능에 아무래도 영향을 미칠 수 있습니다.
- 재연결이 필요한 경우에도 close를 하고 다시 Remon객체를 생성하는 것을 권합니다.
- 명시적으로 close를 할 경우 상대 peer에게 onDisconnect 이벤트가 발생합니다. 또한 명시적이지 않고 브라우저를 그냥 닫았다면  상대편에게는 onStateChange 이벤트가 발생하면서 STATE.CLOSE 혹은 STATE.FAIL의 이벤트가 발생합니다. 만약 네트워크가 안좋아졌거나 끊어지면 상대편에게 onError의 type=ICEFailedError이 발생합니다.

## RemonFactory: 멀티채팅 구현시
- 여러개의 Remon객체를 생성하여 다중 채널, 멀티 채팅을 구현하고자 한다면 Remonfactory를 사용하여 Remon객체를 생성하기 바랍니다.
- RemonFactory는 여러 Remon객체의 자원을 관리하므로 직접 Remon객체를 여러개 만드는 것보다 수월하게 Remon객체의 수명주기를 관리할 수 있습니다.
- 마찬가지로 개별 Remon객체의 close는 RemonFactory.close 메소드를 활용해야 합니다.
