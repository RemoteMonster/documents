# 통화품질을 실시간으로 확인하기

* 영상 및 음성 통화 중에 현재 통화의 품질이 어떠한지를 1에서 5까지의 단계로 항상 확인할 수 있습니다.
* 사용자는 간혹 자신 혹은 상대방의 네트워크 문제로 인하여 통화 품질이 안좋거나 끊어진 상황에서도 서비스회사의 문제라고 생각하고 불만을 제기할 수 있습니다. 때문에 사용자의 문제가 네트워크의 문제임을 사전에 알려줄 수 있습니다.
* 현재 이 통화 품질 정보는 5초에 한번씩 받을 수 있습니다.

  **Javascript에서 통화품질 정보를 얻기**

* Remon 객체를 생성할 때 입력 인자로 넣는 listener의 메소드 중 onStat\(\) 을 구현하여 품질 정보를 받을 수 있습니다.

  ```javascript
  // listener 구현
  const rtcListener = {
  onInit(token) {
    l(`EVENT FIRED : onInit: ${token}`);
  },
  onCreateChannel(channelId) {
    l(`EVENT FIRED : onCreateChannel: ${channelId}`);
    appTitleElement.innerHTML = roomName+" - "+ "Waiting";
  },
  onStat(result){
    const stat = `State: l.cand: ${result.localCandidate} /r.cand: ${result.remoteCandidate} /l.res: ${result.localFrameWidth} x ${result.localFrameHeight} /r.res: ${result.remoteFrameWidth} ${result.remoteFrameHeight} /l.rate: ${result.localFrameRate} /r.rate: ${result.remoteFrameRate} / Health: ${result.rating}`;
    console.log(stat);
  }
  };
  ```

* 위의 result에서 받을 수 있는 여러 정보 중 result.rating 이 바로 네트워크 상황에 따른 통합적인 통화 품질 정보입니다.
* 1:매우 좋음, 2: 좋음 3: 나쁨 4: 매우 나쁨 5: 통화불능 으로 나누어집니다.

  **Android에서 통화품질 정보를 얻기**

* RemonObserver를 상속받은 클래스에서 onStatReport 메소드를 오버라이드하여 정보를 얻습니다.

  ```java
    @Override
    public void onStatReport(RemonStatReport report) {
        Logger.i(TAG, "report: " + report.getHealthRating());
        String stat = "health:" + report.getHealthRating().getLevel() + "\n";
    }
  ```

* RemonStatReport 객체의 getHealthRating메소드의 getLevel 메소드를 통해 1에서 5까지의 숫자를 얻을 수 있습니다.
* 1에서 5까지의 정의는 위의 자바스크립트에서의 정의와 동일합니다.

