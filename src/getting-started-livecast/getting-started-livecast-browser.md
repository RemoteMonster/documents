---
description: 브라우저로 간단한 방송 앱을 개발합니다.
---

# Browser

## 준비사항

* node.js
* WebServer \(Apache server, python SimpleHttpServer, nginx, harp ...\)

## 가장 쉬운 방송앱 개발

* 먼저 웹서버가 서비스할 디렉토리 하나를 선택하거나 만듭니다.
* 해당 디렉토리에서 `npm install @remotemonster/sdk` 실행합니다.
* index.html 파일을 생성하고 코드를 작성합니다.

```markup
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <style>
    video#localVideo { width:auto; height: 80%; background-color: black; }
    button#connectChannelButton { position:absolute; overflow:visible; left:50%; top:10px; }
    html,body { height:100%; }
  </style>
  <title>Remon JS Simple Test</title>
  </head>
  <body>
    <video id="localVideo" autoplay controls class="video"></video>
    <input type="text" class="btn" id="chidText"></input>
    <button id="connectChannelButton" class="btn btn-sm" onclick="start();">Create</button>
  </body>
  <script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
  <script src="https://remotemonster.com/sdk/remon.min.js"></script>
  <script>
  let isConnected = false;
  const chidTextEl = document.querySelector('#chidText');
  const config = { credential: {
      key: '1234567890', serviceId: 'SERVICEID1'
    },
    view: {
      local: '#localVideo'
    },
    media: {
      audio:true,
      video:true,
      sendonly: true
    }
  };
  const listener = {
    onCreateChannel(channelId) {
      console.log(`EVENT FIRED: onCreateChannel: ${channelId}`); 
      chidTextEl.value=channelId;
    }
  }
  const remon = new Remon({ config:config, listener:listener });

  function start() {
    if (isConnected === false){
      isConnected = true;
      document.getElementById("connectChannelButton").innerHTML = "Close";
      remon.createRoom('testroom');
    }else{
      isConnected = false;
      document.getElementById("connectChannelButton").innerHTML = "Create";
      remon.disconnect();
    }
  }
  </script>

</html>
```

* 위의 페이지는 방송을 만드는, 방송하는 쪽 페이지입니다. 통신쪽 소스코드와 다른 점은 localVideo만 태그 정의가 되어있다는 점이고 config에 sendonly 필드가 추가되어 있다는 점입니다.
* 이제 이 디렉토리를 웹서버를 통해서 접근할 차례입니다. 예를 들어 harp server를 사용했다고 합시다.
* harp server 라고 실행하면 포트 9000번을 통해 접근할 수 있죠.
* [http://localhost:9000](http://localhost:9000) 으로 파이어폭스나 크롬 브라우저를 통해 접근해봅시다. 'Create'를 클릭하면?
* 잘 못느낄 수도 있지만 이제 방송이 성공했습니다. 이제 뒤 이어 시청자 앱을 만들어봅시다.
* 같은 디렉토리에 다음과 갈은 페이지를 하나 더 만들어봅시다.

```markup
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <style>
    video#localVideo { width:auto; height: 80%; background-color: black; }
    button#connectChannelButton { position:absolute; overflow:visible; left:50%; top:10px; }
    html,body { height:100%; }
  </style>
  <title>Remon JS Simple Cast Viewer</title>
  </head>
  <body>
    <video id="remoteVideo" autoplay controls class="video"></video>
    <input type="text" class="btn" id="chidText"></input>
    <button id="connectChannelButton" class="btn btn-sm" onclick="start();">Create</button>
  </body>
  <script src="https://remotemonster.com/sdk/remon.min.js"></script>
  <script>
  let isConnected = false;
  const chidTextEl = document.querySelector('#chidText');
  const config = { credential: {
      key: '1234567890', serviceId: 'SERVICEID1'
    },
    view: {
      remote: '#remoteVideo'
    },
    media: {
      audio:true,
      video:true,
      recvonly: true
    }
  };
  const listener = {
    onStateChange(state) {
      if (state === 'INIT'){
        remon.search('');
      }
    },
    onSearch(result){
      var resultObj = JSON.parse(result);
      chidTextEl.value = resultObj[0].id;
    }
  }
  const remon = new Remon({ config:config, listener:listener });

  function start() {
    if (isConnected === false){
      isConnected = true;
      document.getElementById("connectChannelButton").innerHTML = "Close";
      remon.joinRoom(chidTextEl.value);
    }else{
      isConnected = false;
      document.getElementById("connectChannelButton").innerHTML = "Create";
      remon.disconnect();
    }
  }
  </script>

</html>
```

* 위의 페이지는 방송을 시청하는 쪽 페이지입니다. 통신쪽 소스코드와 다른 점은 remoteVideo만 태그 정의가 되어있다는 점이고 config에 recvonly 필드가 추가되어 있다는 점입니다.
* 한가지 특이한 점은 remon.search\(\) 메소드를 통해 현재 방송중인 방 정보를 질의한다는 점입니다. 현재는 RemoteMonster의 공용 id인 SERVICEID1으로 접근하고 있지만 별도로 id를 발급받으면 별도의 id로 독립적인 서비스 안에서의 방 목록을 받을 수 있을 것입니다.
* Listener의 onSearch 메소드를 통해서 search메소드의 결과를 받을 수 있습니다. 이 정보를 통해서 해당 방에 접근할 수 있겠죠.
* 방을 시청하는 메소드는 remon.joinRoom입니다. 이를 통해서 removeView는 시청 내용을 출력합니다.

## Callback 이벤트 처리기 사용하기

Remon은 수많은 일들을 내부적으로 Remote Monster의 서버와 작업하게 됩니다. 때로는 네트워크 상황이 안좋아서 연결이 안될 수도 있고 특별한 이벤트는 귀기울여 수신해야할 필요도 있습니다. 때문에 Remon은 콜백 이벤트 처리기, Listener를 제공하여 이를 통해 다양한 정보를 개발자가 얻을 수 있도록 하고 있습니다.

```javascript
const listener = {
  onInit(token) { ... },
  onCreateChannel(channelId) { ... },
  onConnectChannel(channelId) { ... },
  onComplete() { ... },
  onAddLocalStream(stream) { ... },
  onAddRemoteStream(stream) { ... }, // 상대 영상이 들어왔을 때 처음 발생합니다
  onStateChange(state) { ... },
  onDisconnectChannel(who) { ... }, // 방을 시청중일 때 방이 종료되면 발생합니다
  onError(error) { ... }, // 에러 정보를 반환합니다.
  onStat(result) { ... }, // 방의 품질을 매 5초마다 반환합니다
  onSearch(result) { ... }, // 검색 결과를 반환합니다
};
```

