# 새 방송 프로젝트 설정 - Web

## 준비사항 <a id="undefined"></a>

* Project ID \(Service ID\) [키 발급](create-key.md)
* 웹 브라우저, 프론트엔드 개발 환경
* WebRTC를 지원하는 브라우저

### 프로젝트 생성 및 설정

웹 브라우저에서 RemoteMonster를 이용할 때에는 JavaScript 라이브러리를 이용합니다. 일반적인 웹 프론트엔드 개발 준비를 하면 됩니다.

### CDN으로 라이브러리 추가 \(권장\)

[jsDelivr](https://www.jsdelivr.com/package/npm/@remotemonster/sdk) CDN에 있는 RemoteMonster SDK를 이용할 수 있습니다. 아래와 같이 Latest 또는 Specific version을 HTML 파일에 삽입하십시오.

adapter.js 최신 버전을 remon.js 앞에 삽입해주십시오. 웹 브라우저 호환성을 위해 권장합니다.

{% code title="index.html" %}
```markup
<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>

<!-- Latest -->
<script src="https://cdn.jsdelivr.net/npm/@remotemonster/sdk/remon.min.js"></script>

<!-- 또는 -->

<!-- Specific version -->
<script src="https://cdn.jsdelivr.net/npm/@remotemonster/sdk@2.0.8/remon.min.js"></script>
```
{% endcode %}

### NPM으로 라이브러리 다운로드

npm으로 최신 버전을 다운로드 할 수 있습니다. node\_modules/webrtc-adapter/out/adapter.js 파일과 node\_modules/@remotemonster/sdk/remon.min.js 파일을 HTML 파일에 위 예시를 참고하여 삽입하십시오.

```bash
npm install @remotemonster/sdk
npm install webrtc-adapter
```

### Service Id, Service Key 입력

remon.min.js 파일을 추가한 뒤에 다음과 Service Id와 Key를 입력합니다.

```markup
<script>
const config = {
  credential: {
    serviceId: 'myServiceId', 
    key: 'myKey'
  }
}

// config는 다음과 같이 새로운 Remon 객체를 생성할 때 인자로 사용합니다.
// const caller = new Remon({config: config});
</script>
```

설정이 완료된 HTML파일의 예시는 다음과 같습니다.

{% code title="index.html" %}
```markup
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body>


  <script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@remotemonster/sdk/remon.min.js"></script>
  <script>
    const config = {
      credential: {
        serviceId: '발급 받은 Service Id를 입력',
        key: '발급 받은 Service Key를 입력'
      }
    }
  </script>
</body>

</html>
```
{% endcode %}

이 HTML 파일을 https가 지원되는 웹 서버에 업로드 하고 테스트합니다. 반드시 **https**에서 테스트하십시오.

RemoteMonster를 이용한 개발은 Remon 클래스에 대한 이해가 필요합니다.

[Remon 클래스 알아보기](https://github.com/RemoteMonster/remon-devguide-ko-2019/tree/f32c3e15637cf2b089461da0c2b5c5b8b154cbe3/livestreamingplatform/inside-remoncall-sdk/remoncall.md)

프로젝트 설정을 완료했습니다. 이어서 기능을 구현에 대해 알아봅니다.

[단순 통화 앱 만들기\(Web\)](https://github.com/RemoteMonster/remon-devguide-ko-2019/tree/f32c3e15637cf2b089461da0c2b5c5b8b154cbe3/livestreamingplatform/tutorial-simplelivestreaming-viewer/simplevideocall-code-web.md)

