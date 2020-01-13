# 단순 시청 앱 만들기\(Web\)

## 목차

1. HTML 템플릿 받아서 풀어놓기 
2. JavaScript 라이브러리 파일 추가, Config 만들기 
3. 동영상이 표시될 요소\(video tag\) 추가
4. 채널에 들어가기, 채널ID 확인하기
5. 테스트 하기 
6. 아주 조금 예쁘게 하기, 통화 상태 표시하기

## 준비사항

* Service Id
* https 지원 웹 서버 또는 웹 호스팅

## HTML 템플릿 받아서 풀어놓기

[단순 시청 앱 HTML 템플릿](https://www.remotemonster.com/devguide-assets/remotemonster-simplevideocall-tutorial-web.zip)을 다운로드하여 풀어 놓습니다. simplewatch.html, complete.html, simplelivestreaming.html 3개의 파일을 확인하십시오. 내용이 비어있는 simplewatch.html 을 수정하며 단순 시청 앱을 만들어봅니다. 수정 완료된 내용은 complete.html 파일에서 확인할 수 있습니다. simplewatch.html 파일의 내용은 아래와 같습니다.

{% tabs %}
{% tab title="simplewatch.html" %}
```markup
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>리모트몬스터 단순 시청 앱</title>

  <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
</head>
<body>

</body>
</html>
```
{% endtab %}
{% endtabs %}

## RemoteMonster JavaScript 라이브러리 파일 추가, Config 만들기

리모트몬스터 라이브러리 remon.js 파일을 추가합니다. 웹 브라우저 호환성을 위해 adapter.js 파일도 추가합니다. config를 만듭니다.

{% tabs %}
{% tab title="simplewatch.html" %}
```markup
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>리모트몬스터 단순 시청 앱</title>

  <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
</head>
<body>

  <script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@remotemonster/sdk/remon.min.js"></script>
  <script>
  let remon;
  const config = {
    credential: {
      serviceId: '발급 받은 Service Id를 입력',
      key: '발급 받은 Secret Key를 입력'
    },
    view: {
      remote: '#remoteVideo'
    }
  };
  </script>
</body>
</html>
```
{% endtab %}
{% endtabs %}

## 동영상이 표시될 엘리먼트\(video tag\) 추가, 레이아웃에 맞추기

video 요소 1개를 추가합니다. 방송의 영상을 표시하기 위해서입니다. remote video 요소에 autoplay 속성이 있으면 방송채널에 들어갔을 때 동영상이 바로 표시됩니다. config에 remote 항목으로 이 video 요소의 ID를 입력합니다. button 요소 2개를 추가합니다. "시작" 버튼은 방송채널에 들어가고, "종료" 버튼은 방송채널에서 나가는 데 씁니다. 방송채널의 ID를 표시할 영역을 추가합니다. 시작 버튼을 눌렀을 때 영상이 보이지 않으면 video 요소의 autoplay 속성을 확인하십시오.

아래와 같은 모습을 만들겁니다. 안 예쁘다고요? 문서 뒷부분에서 예쁘게 해보겠습니다.

{% tabs %}
{% tab title="simplewatch.html" %}
```markup
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>리모트몬스터 단순 시청 앱</title>

  <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
</head>
<body>
  <div id="wingleft"></div>
  <div id="mymain">
    <h2>시청</h2>
    <video id="remoteVideo" autoplay muted></video>
    <br>
    <button id="mystart" class="btn btn-main">Start</button>
    <button id="mystop" class="btn btn-main" disabled>Stop</button>
  </div>
  <div id="wingright"></div>

  <script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@remotemonster/sdk/remon.min.js"></script>
  <script>
  let remon;
  const config = {
    credential: {
      serviceId: '발급 받은 Service Id를 입력',
      key: '발급 받은 Secret Key를 입력'
    },
    view: {
      remote: '#remoteVideo'
    }
  };
  </script>
</body>
</html>
```
{% endtab %}
{% endtabs %}

## 채널에 들어가기

방송을 테스트할 때 사용할 채널ID를 미리 정합니다. 튜토리얼은 채널ID를 "my-first-livestreaming"으로 합니다.

출시를 위한 앱을 만들 때에는 고유하고 추측하기 어려운 채널ID를 써야합니다.

{% tabs %}
{% tab title="simplewatch.html" %}
```markup
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>리모트몬스터 단순 시청 앱</title>

  <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
</head>
<body>
  <div id="wingleft"></div>
  <div id="mymain">
    <h2>시청</h2>
    <video id="remoteVideo" autoplay muted></video>
    <br>
    <button id="mystart" class="btn btn-main">Start</button>
    <button id="mystop" class="btn btn-main" disabled>Stop</button>
  </div>
  <div id="wingright"></div>

  <script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@remotemonster/sdk/remon.min.js"></script>
  <script>
  let remon;
  const config = {
    credential: {
      serviceId: '발급 받은 Service Id를 입력',
      key: '발급 받은 Secret Key를 입력'
    },
    view: {
      remote: '#remoteVideo'
    }
  };
  const listener = {
    onCreate(chid) { console.log(`EVENT FIRED: onCreate: ${chid}`); },
    onJoin(chid) { console.log(`EVENT FIRED: onJoin: ${chid}`); $('#mystart').prop( "disabled", true ); $('#mystop').prop( "disabled", false ); },
    onClose() { console.log('EVENT FIRED: onClose'); $('#mystart').prop( "disabled", false ); $('#mystop').prop( "disabled", true ); },
    onError(error) { console.log(`EVENT FIRED: onError: ${error}`); },
    onStat(result) { console.log(`EVENT FIRED: onStat: ${result}`); }
  };
  $('#mystop').click(function(){
    remon.close();
  });
  $('#mystart').click(function(){
    remon.joinCast("my-first-livestreaming");
  });
  </script>
</body>
</html>
```
{% endtab %}
{% endtabs %}

### 채널 생성하기

simplelivestreaming.html 파일을 열어 Service ID와 Secret Key를 수정합니다.

```javascript
  $('#mystart').click(function(){
    // createCast의 인자는 방송채널의 ID입니다. 실제 서비스에서는 동일한 방송채널의 ID가 아닌, 고유하고 예측이 어려운 ID를 사용해야합니다.
    remon.createCast("my-first-livestreaming");
  });
```

## 테스트 하기

simplewatch.html, simplelivestreaming.html 파일을 웹에 게시합니다. 로컬에서 테스트 할 경우 http와 https 모두 가능합니다. 로컬이 아닐 경우 반드시 https 환경에서 테스트해야합니다.

웹 브라우저 창을 2개 엽니다. 두 창에서 각각 simplewatch.html, simplelivestreaming.html 파일의 주소를 엽니다. simplelivestreaming.html 창에서 "시작" 버튼을 클릭합니다. 다음 simplewatch.html 창에서 "시작" 버튼을 누릅니다. 동영상이 표시됩니다.

정상적으로 동영상이 표시되지 않는다면, 웹 브라우저의 JavaScript 콘솔 창을 열어 오류 메시지를 확인합니다.

## 아주 조금 예쁘게 하기

video 요소의 크기를 조절하고 배치를 바꾸어 보기 좋게 합니다. head 요소 안에 style 을 추가 합니다.

{% tabs %}
{% tab title="simplewatch.html" %}
```markup
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>RemoteMonster - Simple Example</title>

  <!-- 아주 조금 예쁘게 하기 -->   
  <style>
    #mymain { 
      margin-left: auto; margin-right: auto; width: 320px; 
    }
    #wingleft { 
    }
    #wingright { 
    }
    #remoteVideo { 
      width: 320px; height: 240px; background-color: black; 
    }
  </style>
  <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
</head>
<body>
  <div id="wingleft"></div>
  <div id="mymain">
    <h2>시청</h2>
    <video id="remoteVideo" autoplay muted></video>
    <br>
    <button id="mystart" class="btn btn-main">Start</button>
    <button id="mystop" class="btn btn-main" disabled>Stop</button>
  </div>
  <div id="wingright"></div>

  <script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@remotemonster/sdk/remon.min.js"></script>
  <script>
  let isConnected = false;
  let remon;
  const config = {
    credential: {
      serviceId: '발급 받은 Service Id를 입력',
      key: '발급 받은 Secret Key를 입력'
    },
    view: {
      remote: '#remoteVideo'
    }
  };
  const listener = {
    onCreate(chid) { console.log(`EVENT FIRED: onCreate: ${chid}`); },
    onJoin(chid) { console.log(`EVENT FIRED: onJoin: ${chid}`); $('#mystart').prop( "disabled", true ); $('#mystop').prop( "disabled", false ); },
    onClose() { console.log('EVENT FIRED: onClose'); $('#mystart').prop( "disabled", false ); $('#mystop').prop( "disabled", true ); },
    onError(error) { console.log(`EVENT FIRED: onError: ${error}`); },
    onStat(result) { console.log(`EVENT FIRED: onStat: ${result}`); }
  };
  remon = new Remon({ config, listener });
  $('#mystop').click(function(){
    remon.close();
  });
  $('#mystart').click(function(){
    remon.joinCast("my-first-livestreaming");
  });
  </script>
</body>
</html>
```
{% endtab %}
{% endtabs %}

![\(&#xC2DC;&#xCCAD; &#xC571;&#xC758; &#xC2E4;&#xC81C; &#xC678;&#xC591;&#xC740; &#xB2E4;&#xB97C; &#xC218; &#xC788;&#xC2B5;&#xB2C8;&#xB2E4;.\)](../../.gitbook/assets/video.saramara.ai_sangyong_simplewatch-l.html-nexus-5.png)

## 그 외 주요 메소드들 <a id="undefined-2"></a>

RemonCall의 주요 인스턴스 메소드는 다음과 같습니다.

* close\(\) : RemonCall 객체가 소멸됩니다. 통화를 종료할 때 사용합니다. close 후에 새 통화를 시작하려면 RemonCall 객체를 새롭게 생성 해야 합니다.
* showLocalVideo\(\): 통화 시작 전에 자신의 카메라 화면을 미리 보고 싶을 때 호출합니다.
* pauseLocalVideo\(true\): 통화 중 자신의 카메라 화면을 중지하고 싶을 때 호출합니다.
* switchCamera\(\): 카메라가 여러 개일 때 카메라를 순차적으로 스위칭해서 보여줍니다.
* fetchCalls\(\) : 통화채널을 조회할 때 호출합니다.

## Callback에 대하여 <a id="callback"></a>

* onInit\(\): RemonCall 객체 생성이 정상적으로 처리됐을 때 호출됩니다. token이 인자로 전달됩니다.
* onConnect\(\): 통화채널이 만들어졌을 때 호출됩니다. 생성된 채널ID가 인자로 전달됩니다.
* onComplete\(\) : 통화 상대방과 연결이 됐을 때 호출됩니다.
* onClose\(\): 통화가 종료되었을 때 호출됩니다. CloseType이 인자로 전달됩니다.
* onError\(\): 에러가 발생했을 때 호출됩니다. 오류 메시지가 인자로 전달됩니다.
* onStat\(\): RemoteMonster가 통화품질 데이터를 5초마다 자동으로 생성합니다. 통화품질 데이터가 생성될 때 호출됩니다. 통화품질 데이터가 인자로 전달됩니다.

자세한 내용은 다음 문서를 참고합니다.

​[Callback과 Observer](https://app.gitbook.com/@remotemonster/s/remon-ko-20191001/~/drafts/-LsL6vPjeqajroIstiKC/primary/videocallplatform/inside-remoncall-sdk/callback-observer)​

단순 통화 앱을 만들며 RemoteMonster를 이용해 기능을 구현하는 방법을 알아보았습니다. Remon SDK의 내부를 알면 다양한 옵션을 선택할 수 있고, 원하는 것을 쉽게 구현할 수 있습니다.

​[Remon SDK의 내부](https://app.gitbook.com/@remotemonster/s/remon-ko-20191001/~/drafts/-LsL6vPjeqajroIstiKC/primary/videocallplatform/inside-remoncall-sdk)

