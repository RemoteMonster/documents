# 통화 키 발급

## 개요

RemoteMonster를 이용하려면 Service ID와 Key를 반드시 발급 받아야 합니다. Service ID는 리모트몬스터 사용자가 만드는 앱에 부여됩니다. Key는 사용자가 만든 앱의 리모트몬스터 플랫폼 이용 권한을 확인하는데 사용됩니다. 한 사용자가 여러 앱을 만들 경우 Service ID와 Key 또한 여러 개가 필요합니다. ServiceID는 사용량과 과금액을 구분하는 데에도 사용됩니다.

## 리모트몬스터 웹 콘솔

리모트몬스터 웹 콘솔을 이용하면 앱에서 통화가 잘 이루어지고 있는지 확인할 수 있습니다.  
새로운 통화 앱을 만들 때, 이 앱을 위한 새로운 Service ID와 Key를 생성할 수 있습니다.

웹 콘솔은 아래 주소에서 이용할 수 있습니다.

[https://console.remotemonster.com/](https://console.remotemonster.com/)

### 프로젝트\(서비스\) 생성

웹 콘솔에 로그인하면 아래와 같은 화면이 표시됩니다. "새 프로젝트 추가" 카드를 클릭하면 새 프로젝트\(서비스\)를 생성할 수 있습니다. 각각의 프로젝트\(서비스\)는 고유한 Service ID와 Secret Key를 갖고 있습니다.

![](https://github.com/RemoteMonster/documents/tree/86188abf462170321bc5ebe2a7f5421ffb9799fb/.gitbook/assets/image%20%287%29.png)

프로젝트명은 각각의 프로젝트\(서비스\)를 사람이 구분할 수 있도록 하기위해 입력합니다. 프로젝트 생성 시 Service ID가 자동으로 생성됩니다. Service ID는 각각의 프로젝트\(서비스\)를 앱이 구분할 수 있도록 합니다.

![](https://github.com/RemoteMonster/documents/tree/86188abf462170321bc5ebe2a7f5421ffb9799fb/.gitbook/assets/image%20%2812%29.png)

프로젝트\(서비스\)를 생성하지 않아도 기본 프로젝트가 이미 만들어져있습니다. 기본 프로젝트의 이름을 바꾸어 사용하면 아주 조금 빨리 시작할 수 있습니다.

![](https://github.com/RemoteMonster/documents/tree/86188abf462170321bc5ebe2a7f5421ffb9799fb/.gitbook/assets/image%20%2811%29.png)

새로 만든 프로젝트\(서비스\) 카드를 클릭하면 프로젝트의 상세 정보와 Service ID, Secret Key를 확인 할 수 있습니다.

![](https://github.com/RemoteMonster/documents/tree/86188abf462170321bc5ebe2a7f5421ffb9799fb/.gitbook/assets/image%20%2816%29.png)

Secret Key를 확인하려면 우측의 눈 아이콘을 클릭하십시오.

![\(&#xADF8;&#xB9BC; &#xC18D;&#xC758; Service ID&#xC640; Secret Key&#xB294; &#xC720;&#xD6A8;&#xD558;&#xC9C0; &#xC54A;&#xC2B5;&#xB2C8;&#xB2E4;.\)](https://github.com/RemoteMonster/documents/tree/86188abf462170321bc5ebe2a7f5421ffb9799fb/.gitbook/assets/image%20%284%29.png)

## Service ID와 Secret Key 사용

프로젝트\(서비스\) 마다 사용량이 구분됩니다. 새로운 통화 앱을 만들 때 새로운 프로젝트\(서비스\)를 생성하길 권장합니다.

앱 소스코드에 Service ID와 Key를 Config의 적절한 위치에 삽입합니다. 자세한 내용은 다음 가이드를 참고합니다.

[새 프로젝트 설정\(Web\)](new-project-web.md)

[새 프로젝트 설정\(Android\)](https://github.com/RemoteMonster/documents/tree/86188abf462170321bc5ebe2a7f5421ffb9799fb/src/drafts/new-project-android.md)

[새 프로젝트 설정\(iOS\)](https://github.com/RemoteMonster/remon-devguide-ko-2019/tree/eb0c6572bc39b0b2570a633d77a6749d62fef12a/videocallplatform/tutorial-simplevideocall/new-project-ios.md)

