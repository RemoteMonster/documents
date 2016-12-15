# 크롬브라우저의 webrtc-internal을 이용하여 품질 정보 분석하기
- webrtc-internals는 WebRTC서비스에서 발생하는 이슈르 해결해야하 땔 굉장히 좋은 도구입니다. 이 도구에 익숙하지 않다면 크롬브라우저에서 WebRTC세션을 연결하고 다른 탭을 더 열어서 주소창에서 chrome://webrtc-internals/ 를 입력하면 webrtc-internals를 실행할 수 있습니다.

- webrtc-internals는 현재 연결되어서 통신하고 있는 여러 stat정보를 덩치 큰 JSON덩어리로 저장할 수 있고 이것을 이용하여 다음과 같이 살펴볼 수도 있습니다.

- 대다수의 사람들은 물어봅니다. 대체 이 숫자가 의미하는 게 무엇이냐고? 이제 하나씩 이 webrtc-internals의 항목을 살펴보겠습니다.
- 페이지의 가장 위에는 몇개의 탭이 있습니다. 하나는 getUserMedia 호출에 대한 것이고 나머지는 RTCPeerConnection 객체의 정보를 보여줍니다.
- 먼저 getUserMedia Reuqest 탭을 클릭해보면 getUserMedia를 통해 전달된 constraints값들이 기록되어 있습니다. 안타깝게도 MediaStreams의 id나 결과등을 확인할 수 없는 단순한 내용만 있네요.

## RTCPeerConnection stat
- 이제 RTCPeerConnection항목을 살펴볼 차례입니다. 크게 4개의 항목으로 구성되어 있습니다.
1. RTCPeerConnection이 어떻게 설정되어 있는지, 이를테면 어떤 STUN, TURN서버가 사용되고 그 옵션은 어떻게 설정되어 있는지 알려줍니다.
2. 왼쪽편은 PeerConnection 객체가 호출된 trace입니다. 즉, PeerConnection객체의 메소드가 호출된 순서대로 나열되어 있고 그 인자값(예: createOffer)등과 callback 이벤트 이를테면 onicecandidate 등도 모조리 기록합니다. 이것은 정말 강력하기 때문에 ICE 실패가 어디서 왜 일어났는지를 확인하거나 TURN서버를 어디에 설치해야하는 지 결정하는데에도 많은 영감을 줄 수 있습니다.
3. Stats Tables: getStats() 메소드로부터 받은 통계정보를 보여줍니다.
4. getStats() 의 값들을 그래프로 보여줍니다. webrtc-internals의 통계값들은 사실 크롬브라우저의 내부의 포맷이어서 현재의 표준과는 조금 다릅니다. 하지만 크게 다르지는 않고 점점 이 통계치들은 표준과 유사하게 맞춰지고 있는 상황입니다.

- 통계값을 webrtc-internals가 아닌 코드나 콘솔을 통해 확인하고 싶다면 다음과 같이 실행하면 됩니다.
```
RTCPeerConnection.getStats(function(stats) { console.log(stats.result()); )};
```
- RTCStatsReport 객체의 배열값이고 아래에서와 같이 매우 많은 key와 value쌍으로 이루어져 있습니다.
```
RTCPeerConnection.getStats(function(stats) {
   var report = stats.result()[0];
   report.names().forEach(function(name) {
       console.log(name, report.stat(name));
   });
)}
```
- 이들 Report객체를 읽는 방법 중 중요한 원칙 중 하나는 바로 끝에 Id로 끝나는 key 이름은 보통 다른 report의 id 속성을 가리킨다는 것입니다. 때문에 거의 모든 report 객체들은 서로간에 연결되어 있는 구조입니다. 또한 대부분의 값들은 string인것도 명심하세요.

- RTCStatsReport의 가장 중요한 속성은 report의 type입니다. 여기 그것들 중 중요한 것들을 소개합니다.
  - googTrack
  - googLibjingleSession
  - googCertificate
  - googComponent
  - googCandidatePair
  - localCandidate
  - remoteCandidate
  - ssrc
  - VideoBWE
- 이들 report들을 하나씩 살펴봅시다.

## googCertificate report
- googCertificate report는 local에서 사용하고 certificate 자체 용도로도 사용하는 DTLS certificate 정보를 담고 있습니다. 이것에 대한 자세한 내용은 [RTCCertificateStats dictionary](https://w3c.github.io/webrtc-stats/#certificatestats-dict) 에서 확인할 수 있습니다.

## googComponent report
- certificate 통계와 connection간의 접착제 역할을 수행합니다. 즉, 현재 active한 candidate 쌍들에 대한 링크를 가지고 있습니다.

## googCandidatePair report
- ICE Candidate 쌍을 다룹니다. 이 report를 통해 아래와 같은 정보를 얻을 수 있습니다.
  - 송수신된 패킷과 bytes의 전체 수(bytesSent, bytesReceived, packetsSent; packetsReceived는 알수없는 이유로 missing). 이것들은 RTP헤더를 포함한 raw형태의 UDP 혹은 TCP bytes가 기본값입니다.
  - 현재 active한 connection인지 여부를 googActiveConnection항목을 통해 알 수 있습니다. 대부분의 시간동안 active candidate 쌍의 통계에 대해서만 관심이 있을 겁니다. 이 정보에 대한 자세한 내용은 [여기](https://w3c.github.io/webrtc-stats/#transportstats-dict) 를 통해 확인하세요.
  - 송수신된 STUN 요청 및 수신의 수(requestsSent, responsesReceived, requestsReceived, responsesSent). 즉, ICE 과정 중 사용된 송수신 STUN요청의 count정보입니다.
  - googRtt를 통해 마지막 STUN 요청의 round trip time을 알 수 있습니다. ssrc report의 googRtt와는 다른 겁니다.
  - localCandidateId와 remoteCandidateId를 통해 localCandidate와 remoteCandidate 객체의 id를 알 수 있습니다.
  - googTransportType을 통해 전송 type을 알 수 있습니다. 대부분 udp이나 TURN서버 사용시 TURN over TCP가 사용될 수 있습니다. [ICE-TCP](https://webrtcglossary.com/ice-tcp/)가 사용되면 tcp로 설정됩니다.
## localCandidate와 remoteCandidate report
- ip 주소, 포트번호, candidate의 종류등을 확인할 수 있습니다.

## Ssrc report
- 가장 중요합니다. peerconnection을 통해서 송수신되는 음성 혹은 영상 트랙 하나를 담당하고 있습니다. 표준에서는 이를 [MediaStreamTrackStats](https://w3c.github.io/webrtc-stats/#mststats-dict)과 [RTPStreamStats](https://w3c.github.io/webrtc-stats/#streamstats-dict)로 구분하여 정의하고 있습니다. 이 report는 그것이 다루고 있는 것이 음성인지 영상인지 혹은 송신인지 수신인지에 영향을 받고 있습니다. 일단 공통적인 값들부터 살펴봅시다.
- mediaType: 음성인지 영상인지를 알려줍니다.
- ssrc: 송신하는 것인지 수신하는 것인지 등의 고유값을 나타냅니다.
- googTrackId: 이 통계가 대상으로 하는 트랙의 id를 나타냅니다. 이는 SDP의 local 혹은 remote media 스트림 트랙부분에서 역시 찾을 수 있습니다. 원래 원칙상 끝에 Id가 붙는 것들은 다른 report를 가리켜야하지만 이것만은 예외입니다.
- googRtt: rount-trip time인데 이것은 RTCP에서 측정된 값입니다.
- transportId: 이 RTP 스트림을 전송하는데 사용한 컴포넌트를 가리킵니다. 만약 Bundle을 사용중이라면 음성과 영상 스트림 모두 동일한 값으로 지정되어 있을 것입니다.
- googCodecName: codec의 이름입니다. opus, VP8, VP9, H264 등등. codec의 구현체를 codecImplementationName stat을 통해 확인할 수도 있습니다.
- bytesSent, bytesReceived, packetsSent, packetsReceived (해당 ssrc가 송신인지 수신인지에 따라 차이): bitrates 계산값입니다. 이는 누적값이기 때문에 이전에 측정한 getStats로부터 걸린 시간과 함께 적절한 계산을 해주어야 합니다. 표준에 나와있는 [샘플코드](http://w3c.github.io/webrtc-pc/#example)는 비교적 훌륭합니다만 가끔 크롬은 이 값을 리셋하기 때문에 때때로 마이너스값이 나올 수 있음을 명심하세요.
- packetsLost: 잃어버린 패킷수. 송신자입장에선 RTCP를 통해, 수신자입장에서는 로컬기반으로 수집합니다. 통화 상태를 나타내는 가장 중요한 값 중 하나입니다.

## Voice
- 음성 트랙을 위해 audioInputLevel과 audioOutputLevel(표준에서는 이를 [audioLevel](https://w3c.github.io/webrtc-stats/#dom-rtcmediastreamtrackstats-audiolevel)이라 칭합니다)값이 있습니다. 음성 신호가 마이크에서 오는지 스피커를 통해서 오는지 등을 알려줍니다. 이는 크롬의 [음성 처리 버그](https://bugs.chromium.org/p/webrtc/issues/detail?id=4799)를 감지하는 데 사용됩니다.
- googJitterReceived와 googJitterBufferReceived: [수신된 Jitter의 양](https://webrtcglossary.com/jitter/)에 대한 정보 그리고 [jitter buffer state](https://webrtcglossary.com/jitter-buffer/)에 대한 정보를 제공합니다.

## Video
- googNacksSent: [NACK](https://webrtcglossary.com/nack/)에 대한 정보
- googPLIsSent: [PLI](https://webrtcglossary.com/pli/)에 대한 정보
- googFIRsSent: [FIR](https://webrtcglossary.com/fir/)에 대한 정보
- 위 정보들은 패킷손실(packetloss)가 영상 품질에 미치는 영향을 이해하는 데 도움을 줍니다.
- googFrameWidthInput, googFrameHeightInput, googFrameRateInput: 입력된 frame size와 frame rate등을 알려주며
- googFrameWidthSent, googFrameHeightSent, googFrameRateSent: 실제 네트워크를 통해 보내어진 수치입니다.
- googFrameWidthReceived, googFrameHeightReceived: 수신한 frame size이고
- googFrameRateReceived, googFrameRateDecoded, googFrameRateOutput: 수신한 framerate 정보입니다.
- 영상을 인코딩하는 입장에서는 이들 값들의 차이를 확인하고 왜 영상의 resolution이 낮아졌는지에 대한 정보를 확인할 수 있습니다. 일반적으로 충분하지 않은 CPU 혹은 bandwidth가 원인인 경우가 많습니다.
- 낮아진 framerate에 대한 비교는 googFrameRateInput와 googFrameRateSent값을 비교하여 알 수 있는데, 이에 더하여 낮아진 해상도의 원인이 CPU때문인지(googCpuLimitedResolution값이 true 인 경우) 혹은 불충분한 bandwidth때문인지(googBandwidthLimitedResolution값이 true)들을 여러 정보들을 통하여 확인할 수 있습니다. 이들중 어떤 조건이 변경이 되면 googAdaptionChanges의 counter가 증가합니다.

- 패킷손실(packet loss)을 인위적으로 발생시켜 보았습니다. 응답쪽에서 크롬은 googFrameWidthSent와 googFrameWidthInput값이 달라지는 t=184에서 해상도를 낮추려 합니다. t=186일 때 input framerate이 30에서 0에 가깝게 변하는 것을 알 수 있습니다.

## VideoBWE report
- bandwidth를 예측합니다. 다음과 같은 정보를 가지고 있습니다.
- googAvailableReceiveBandwidth: 수신중인 영상 데이터를 위해 가용한 bandwidth 입니다.
- googAvailableSendBandwidth: 송신중인 영상데이터를 위해 가용한 bandwidth 입니다.
- googTargetEncBitrate: 영상 인코더가 목표로 하는 bitrate입니다. 가용한 bandwidth를 최대한 사용하려 합니다.
- googActualEncBitrate: 영상 인코더의 실제 수행하는 초기 bitrate입니다. 목표 bitrate와 대응해야 합니다.
- googTransmitBitrate: 실제 전송하는 bitrate입니다. googActualEncBitrate와 차이가 심하다면 아마 [forward error correction](https://webrtcglossary.com/fec/) 때문일 것입니다.
- googRetransmitBitrate: RTX가 사용된다면 재전송의 bitrate을 측정을 허용합니다. 패킷손실을 측정하는 데 유용합니다.
- googBucketDelay: 큰 프레임과 관련된 구글의 "leaky bucket" 전략의 측정입니다. 크게 중요하지 않습니다.

참고링크: http://testrtc.com/webrtc-internals-parameters/#comment-32
