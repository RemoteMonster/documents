# Browser SDK - Getting Started

## 설치

npm을 통한 설치

- `npm install --save remon-browser-sdk`



## 설정

### config 객체 생성

- 아래의 값은 필수적으로 설정되어야함
- view에서 값은 CSS 셀렉터 형태로 지정되어야함


```javascript
{
  credential: {
    key: undefined,
    serviceId: undefined,
  },
  view: {
    local: undefined,
    remote: undefined,
  },
}
```

### listener 객체 생성

- 아래와 일치하는 이름의 콜백 리스너를 생성
- 아래와 같이 일부 리스너는 함수 인자를 받아 조작하여 사용할 수 있음

```javascript
{
 onInit(token) { ... },
 onCreateChannel(channelId) { ... },
 onConnectChannel(channelId) { ... },
 onComplate() { ... },
 onDisplayUserMedia(stream) { ... },
 onAddLocalStream(stream) { ... },
 onAddRemoteStream(stream) { ... },
 onStateChange(state) { ... },
 onDisconnectChannel() { ... },
 onMessage(message) { ... },
 onError(error) { ... },
}
```

## 초기화
- 위에서 만든 설정과 리스너를 인자로 하여 시작

```javascript

Remon.init({ userConfig, userListeners });

// connect Channel with channel name
remon.connectChannel(“myroom”);

```

## onDestroy() 처리

- 현재 아래와 같으나 0.1.0 릴리즈에서 close로 변경예정

```javascript
remon.disconnect();
```







