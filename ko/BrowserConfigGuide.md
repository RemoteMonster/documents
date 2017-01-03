# 브라우저 SDK의 Config
## RemoteMonster SDK config의 전체 공통 구조
- RemoteMonster는 객체 생성 전에 config값을 선행적으로 받습니다. 가장 단순하게는
```javascript
const config = {
  view: {
    remote: '#remoteVideo', local: '#localVideo',
  },
};
```
- 와 같이 영상을 출력할 video tag를 설정하는 것만으로 RemoteMonster는 잘 알아듣고 config처리를 합니다. 하지만 실제 서비스를 위해서 RemoteMonster는 더 많은 설정값을 요구합니다. 이를테면 서비스 인증을 위한 키값을 요구합니다.
```javascript
const config = {
  credential: {
    key: '1234567890', serviceId: 'SERVICEID1'
  },
  view: {
    remote: '#remoteVideo', local: '#localVideo',
  },
};
```
- 위와 같이 config는 view 항목뿐 아니라 credential값을 요구합니다. 이를 통해 실제로 RemoteMonster에 가입 정보를 확인하고 더 나은 서비스를 제공받을 수 있습니다.
- key는 RemoteMonster로 부터 발급받는 비밀키입니다. serviceId는 여러분이 RemoteMonster에 서비스 가입을 할 때 입력하는 값입니다. 즉 당신의 id값이라고 보면 됩니다.
- 이제 이 config에 더하여 음성과 영상에 대한 보다 다양한 옵션을 살펴봅시다.
```javascript
const config = {
  credential: {
    key: '1234567890', serviceId: 'SERVICEID1'
  },
  view: {
    //remote: '#remoteVideo'
  },
  media: {
    audio: true, video: false,
  }
};
```
- 이 media옵션 내용은 음성만 사용하겠다는 옵션입니다. 즉 video를 false하면 영상통신을 할 수 없습니다. 매우 많은 RemoteMonster의 서비스들은 음성전용 서비스이기도 합니다.
- 만약 video를 사용한다면 매우 많은 옵션을 설정할 수 있습니다.
```javascript
video: {
  width: {max: '640'},
  height: {max: '480'},
  codec: 'H264', // 'VP9' , 'VP8' or 'H264'
  frameRate: 15,
  facingMode: 'user', // 'user' or 'environment'
}
```
- 항목을 하나씩 살펴보겠습니다.
- 먼저 width와 height는 상대편에게 보낼 영상의 해상도를 결정하는 것입니다. 최대 640 480의 해상도로 보낼 것을 설정하였지만 이것이 꼭 지켜지는 것은 아닙니다. WebRTC는 기본적으로 네트워크나 단말의 상태에 따라 해상도와 framerate등을 유연하게 변화시키면서 품질을 유지하고 있기 때문입니다. 해상도가 실제와 차이가 날 수는 있지만 ratio는 최대한 맞추기 위해 노력합니다.
- Browser는 H.264와 VP8, VP9등의 영상 코덱을 지원하고 있습니다. RemoteMonster는 H.264를 기본 코덱으로 사용하고 있으며 변경이 필요하다면 이 설정으로 변경할 수 있습니다.
- frameRate항목은 1초에 몇번의 frame으로 인코딩할 지를 결정합니다. 일반적인 영상통화에서는 15정도면 적당하지만 더 촘촘한 framerate를 원한다면 높여줄 수 있겠죠.
- facingMode는 기기의 앞과 뒤에 카메라가 있을 때 어떤 쪽의 카메라를 사용할 것인지를 결정하는 것입니다.
- 만약 통화 내용을 저장하고 싶다면 다음과 같이 설정하면 통화 후 나중에 RemoteMonster의 홈페이지를 통해 녹음된 파일을 가져올 수 있습니다.
```javascript
const config = {
  credential: {
    key: '1234567890', serviceId: 'SERVICEID1'
  },
  view: {
    //remote: '#remoteVideo'
  },
  media: {
    audio: true, video: false,
    record: true,
  }
};
```
== 기타
- 그외의 옵션을 dev라는 항목에서 설정할 수 있습니다.
```javascript
const config = {
  credential: {blahblah},
  view: {blahblah},
  media: {blahblah},
  dev:{
    logLevel: 'INFO',
  }
};
```
