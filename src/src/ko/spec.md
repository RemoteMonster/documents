# Spec

## 리모트 몬스터 API

* 리모트몬스터의 모든 방송 통신기술은 API형태로 제공됩니다. 이제 복잡한 Back-end개발과 방송 통신기술 개발의 부담에서 해방되어 누구나 쉽게 Skype나 Hangout, 스냅챗, 아프리카TV와 같은 방송 통신 서비스를 구현할 수 있습니다. 리모트몬스터가 구축하는 글로벌한 통신 API 백엔드와 SDK를 통해 방송 통신회사에 준하는 자원을 즉시 확보하세요.
* 리모트몬스터 API는 다음과 같은 형태로 구성되어 있습니다.

  ![RemoteMonster API overview](../../.gitbook/assets/remonapioverview%20%281%29.png)

### 주요기능

* 핵심 기능
  * 모바일 플랫폼 지원: 이미 운영중인 서비스 혹은 개발할 서비스에 SDK를 추가하고 몇가지 소스코드를 추가하여 통신 기능을 적용합니다.
  * 실시간 통화 지원: 영상, 음성 통신 뿐 아니라 방송이나 일반전화 대상 송수신 등의 기능을 제공합니다
  * 방송 서비스 지원: 아프리카TV나 트위치와 같은 실시간 방송 서비스 기능을 서비스에 적용할 수 있습니다.
  * 글로벌 클라우드 환경 지원: 리모트몬스터의 기능은 글로벌 클라우드에 의해 운영되어 세계 어디에서나 빠른 통신품질을 보장합니다.
  * 모니터링 기능: 모든 통화 트랜잭션의 상태를 실시간으로 또는 통계적으로 모니터링할 수 있습니다.
  * 녹화 기능: 필요하다면 통화 내용을 녹화하여 지속적으로 보관하는 것도 가능합니다. 앱 내에서 녹화하는 기능과 서비스 서버에서 녹화하는 기능등을 제공합니다.

### 플랫폼 지원

* 최신의 플랫폼 지원: WebRTC 엔진인 Chrominum 6개월 이내의 최신 버전을 제공하여 호환성과 성능 및 품질 최고를 경험.
* 최신의 표준 지원: WebRTC 1.0을 가장 빠르게 지원\(WebRTC 1.0 CR 기준\)
* 가장 다양한 플랫폼 및 최신의 언어 지원: Android, iOS\(Objective C, Swift 3.0\), Chrome/Firefox/Edge/Whale \( promise 방식, ES6 준수\), 국내환경에서 가장 많은 플렛폼 지원

### 품질

* Global 통신 인프라 지원: 국내 뿐 아니라 Global한 통신에 대한 레퍼런스 및 경험 확보
* 속도: 국내에서 가장 빠른 Setup time. 평균 1초 미만의 Setup time 보장\(국내, Browser 기준\)
* 품질: 모바일 기기의 성능에 따른 다양한 성능 옵션 선택 가능. 네트워크 상황에 따른 지능적인 동적 품질 적용 엔진. 다양한 코덱 선택 가능\(영상: VP8, VP9, H.264, 음성: G.711, Opus\(Stereo\), ISAC\(Mono\)

### 개발 용이성

* WebRTC 체계를 만드는데 1달 가까이 걸리는 시간을 절약하고 바로 시작
* Simple한 개발 방식: 3 line\(JS\), 10 line\(Android\)
* Config → Connect 2단계로 개발하는 가장 쉬운 ᅟWebRTC 코드

### 세부 기능표

| 분류 | 기능 | 설명 |
| --- | --- | --- |
| 지원 플랫폼 | Chrome Browser | Desktop, Android 모두 지원 |
|  | Firefox Browser | Desktop, Android 모두 지원 |
|  | Naver Whale | 지원 |
|  | MS Edge Browser | 음성 통신 지원 |
|  | Android | 최소 18\(젤리빈\), 권장 21\(롤리팝\) 이상. ARM기반 단말만 지원 |
|  | iOS | 지원\(iPad, iPhone\), bitcode 미지원 |
| 기능 | 1:1 음성 통화 | 지원 |
|  | 1:1 영상 통화 | 지원 |
|  | M:M 영상/음성 통화 | 최소 4:4에서 최대 8:8까지 지원. 기기 성능과 품질 정의에 따라 다름 |
|  | 1:N 방송 | 지원 |
|  | 채팅 | 1:1만 Text 전송 지원 |
|  | TURN서버 | 지원. 글로벌 크라우드 기반 제공. Pricing에 따라 차별화 |
|  | 실시간 품질 확인 | 현재 통화 상태를 API로 실시간 제공 및 분석결과 제공 |
|  | 블루투스 헤드셋 | 지원 |
|  | 스피커모드 | 지원\(안드로이드\). 근접센서에 의해 자동 변환 제공 |
|  | 자동 재연결 | 지원 예정. 예기치못한 통화종료시 자동 재연결 기능 |
|  | 녹음,녹화 기능 | 지원. RemoteMonster 서버에서 파일 다운로드 지원. Pricing에 따라 차별화 |
| 음성 품질 | 지원 코덱 | G.711, Opus, ISAC |
|  | 최소 네트워크 환경 | 최소 50kbps 이상 |
| 영상 품질 | 지원 코덱 | H.264\(기본\), VP8, VP9 |
|  | 최소 네트워크 환경 | 최소 300kbps 이상 |
|  | 최소 PC 사양 | 듀얼코어 이상의 CPU 벤치마크 사이트 PassMark Software에서 제시한 점수 1000점 이상의 PC |
| 기타 품질 | Latency | 최소 0.2초 - 최대 1초. 네트워크와 환경에 따라 다를 수 있음 |
|  | Setup time | 웹: 1초 미만, 모바일: 1.5초 미만. 네트워크와 기타 환경에 따라 다를 수 있음 |
|  | 지원 국가 | 전세계\(전화 통화 제외\) |

### 활용 고객

* [튜터링](http://tutoring.kr/): 모바일 영어회화 어플
* [설레Go](https://play.google.com/store/apps/details?id=net.seole.seolego.user): 대리운전 앱
* [화상운세](https://play.google.com/store/apps/details?id=kr.co.xitech.www.videounse): 모바일 화상기반 역술인 채팅 서비스
* [심리상담](https://play.google.com/store/apps/details?id=com.humart.trost2): 트로스트 - 심리상담, 고민상담 서비스
* [설레는 아침](https://play.google.com/store/apps/details?id=kr.co.marshmallowstudio.seol_a): 소셜 모닝콜 서비스

## 적용 가능 서비스

* 영어회화, 공부방, 교육 서비스
* 뷰티 서비스
* 운세 서비스
* 상담 서비스
* IoT 등 기기연동 서비스
* O2O, 옴니채널 서비스

