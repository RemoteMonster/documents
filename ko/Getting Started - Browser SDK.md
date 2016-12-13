# Browser SDK - Getting Started

## 준비사항
- node.js
- WebServer (Apache server, python SimpleHttpServer, nginx, harp ...)

## 가장 쉬운 통화앱 개발
- 먼저 웹서버가 서비스할 디렉토리 하나를 선택하거나 만듭니다.
- 해당 디렉토리에서 `npm install remon-browser-sdk` 실행합니다.
- index.html 파일을 생성하고 코드를 작성합니다.

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <style>
    video#remoteVideo { width:auto; height: 80%; background-color: black; }
    button#connectChannelButton { position:absolute; overflow:visible; left:50%; top:10px; }
    html,body { height:100%; }
  </style>

  <script src="./node_modules/remon-browser-sdk/remon.min.js"></script>
  <script>
  const remon = Remon;
  let isConnected = false;
  const config = { credential: {
      key: '1234567890', serviceId: 'SERVICEID1'
    },
    view: {
      remote: '#remoteVideo'
    },
  };
  remon.init({ userConfig:config });

  function start() {
    if (isConnected === false){
      isConnected = true;
      document.getElementById("connectChannelButton").innerHTML = "Close";
      remon.connectChannel("simpleRemon");
    }else{
      isConnected = false;
      document.getElementById("connectChannelButton").innerHTML = "Connect";
      remon.disconnect();
    }
  }
  </script>
  <title>Remon JS Simple Test</title>
</head>
<body>
  <video id="remoteVideo" autoplay controls class="video"></video>
  <button id="connectChannelButton" class="btn btn-sm" onclick="start();">Connect</button>
</body>
</html>
```

- 이제 이 디렉토리를 웹서버를 통해서 접근할 차례입니다. 예를 들어 harp server를 사용했다고 합시다.
- harp server 라고 실행하면 포트 9000번을 통해 접근할 수 있죠.
- http://localhost:9000 으로 파이어폭스나 크롬 브라우저를 통해 접근해봅시다. 2개의 탭으로 접근하거나 아예 다른 창으로 각각 'Connect'를 클릭하면?
- 첫번째 Remon 앱을 만든 것을 축하합니다.

## 소스를 살펴보기
### Config
먼저 remon 객체를 만듭니다.
- `const remon = Remon`

설정 객체를 만듭니다.

```javascript
const config = { credential: {
    key: '1234567890', serviceId: 'SERVICEID1'
  },
  view: {
    remote: '#remoteVideo'
  },
};
```

- key값은 Remote Monster에 회원가입하여 받게 되는 비밀번호입니다. serviceId값은 Remote Monster에 회원가입시 입력한 자신의 서비스 id입니다. 잘 모른다면 `credential` 객체를 설정 않해도 무방합니다.
- view 항목에 보면 video 태그의 id를 설정합니다. 원격에서 상대방의 영상이 수신되면 그 영상을 출력할 video 태그의 id입니다.

만들어둔 설정을 인자로 하여 객체를 초기화 합니다.
- `remon.init({ userConfig:config });`

### Connect
이제 방에 들어갈 시간입니다. connectChannel 메소드는 입력값에 해당하는 방으로 들어가는 명령을 수행합니다.
- `remon.connectChannel("simpleRemon");`

혹은 방에서 나옵니다.
- `remon.disconnect()`
- 방에 들어가는 명령이 있다면 나오는 명령이 있겠죠. disconnect는 바로 들어갔던 방에서 나오는 명령입니다
- 이제 모든 것이 끝났습니다. Remote Monster의 Javascript API는 이것만으로도 통신의 모든 것을 완벽히 수행합니다. 물론 더 자세한 조작은 필요하겠죠?

## LocalVideo 생성
앞서 예제는 상대편 video만 있어서 연결하기 전에는 나의 얼굴을 확인할 수 없었습니다. 이제 나의 video tag를 삽입하고 그 tag의 id를 RemoteMonster에게 알려줍시다.

`html body`에 다음과 같이 `local Video`를 추가합니다.
- `<video id=\"localVideo\" autoplay controls class=\"video\">`

그리고 config를 다음과 같이 수정합니다.
```javascript
const config = {
  credential: {
    key: '1234567890', serviceId: 'SERVICEID1'
  },
  view: {
    remote: '#remoteVideo', local:'#localVideo'
  },
};
```

## Callback 이벤트 처리기 사용하기
Remon은 수많은 일들을 내부적으로 Remote Monster의 서버와 작업하게 됩니다. 때로는 네트워크 상황이 안좋아서 연결이 안될 수도 있고 특별한 이벤트는 귀기울여 수신해야할 필요도 있습니다. 때문에 Remon은 콜백 이벤트 처리기, Listener를 제공하여 이를 통해 다양한 정보를 개발자가 얻을 수 있도록 하고 있습니다.

```javascript
const listener = {
  onInit(token) { ... },
  onCreateChannel(channelId) { ... },
  onConnectChannel(channelId) { ... },
  onComplete() { ... },
  onAddLocalStream(stream) { ... },
  onAddRemoteStream(stream) { ... },
  onStateChange(state) { ... },
  onDisconnectChannel() { ... },
  onMessage(message) { ... },
  onError(error) { ... },
};
```

위에서 만든 설정과 리스너를 인자로 하여 다시 시작해봅시다.

```javascript
remon.init({ userConfig:config, userListeners:listener });
...
remon.connectChannel("simpleRemon");

```
