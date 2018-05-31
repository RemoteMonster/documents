# Web - Getting Start

## 준비사항

* 웹 브라우저, 프론트엔드 개발 환경
* WebRTC를 지원하는 모던 브라우저

## 프로젝트 생성 및 설정

RemoteMonster의 SDK는 브라우저 환경에서 작동합니다. 간단하게 일반적인 웹프론트 엔드 개발 준비를 하면 됩니다.

```bash
npm init
npm i serve
touch index.html
npx serve
# Open browser "localhost:3000"
```

## SDK 설치 - npm {#undefined-1}

npm을 통해 간단하게 설치가 가능합니다.

```text
npm i @remotemonster/sdk
```

## SDK 설치 - Static Import {#undefined-1}

RemoteMonster가 호스팅중인 CDN을 사용 할 수 있습니다. HTML 파일에 아래와 같이 삽입하세요.

```markup
<!-- Latest -->
<script src="https://cdn.remotemonster.com/sdk/browser/remon.min.js"></script>

<!-- Specific version -->
<script src="https://cdn.remotemonster.com/sdk/browser/2.0.0/remon.min.js"></script>
```

## 개발

이제 모든 준비가 끝났습니다. 아래를 통해 세부적인 개발 방법을 확인하세요.

### Service Key

SDK를 통해 RemoteMonster 방송, 통신 인프라에 접근하려면, Service Id와 Key가 필요합니다. 간단한 테스트와 데모를 위해서라면 이 과정을 넘어가도 좋습니다. 실제 서비스를 개발하고 운영하기 위해서는 아래를 참고하여 Service Id, Key를 발급 받아 적용하도록 합니다.

{% page-ref page="../common/service-key.md" %}

### 방송

Remon을 통해 방송 기능을 쉽고 빠르게 만들 수 있습니다.

#### 방송 송출

```javascript
<video id="localVideo" autoplay muted></video>
<script>
const config = {
  view: {
    local: '#localVideo'
  }
}

const caster = new Remon({ config })
caster.create()
</script>
```

#### 방송 시청

```javascript
<video id="remoteVideo" autoplay></video>
<script>
const config = {
  view: {
    remote: '#remoteVideo'
  }
}

const watcher = new Remon({ config })
watcher.join('CHANNEL_ID')
</script>
```

혹은 좀더 자세한 내용은 아래를 참고하세요.

{% page-ref page="../common/livecast.md" %}

### 통신

Remon을 통해 통신 기능을 쉽고 빠르게 만들 수 있습니다.

```javascript
<video id="localVideo" autoplay muted></video>
<video id="remoteVideo" autoplay></video>
<script>
const config = {
  view: {
    local: '#localVideo',
    remote: '#remoteVideo'
  }
}

const remonCall = new Remon({ config })
remonCall.connect('CHANNEL_ID')
</script>
```

혹은 좀더 자세한 내용은 아래를 참고하세요.

{% page-ref page="../common/untitled.md" %}
