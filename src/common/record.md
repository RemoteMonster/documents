# Record

## Overview

방송, 통신간 영상을 녹화, 녹음 하는 기능을 제공하고 있습니다.

### 지원범위

|  | Web | Android | iOS | Server |
| :--- | :--- | :--- | :--- | :--- |
| Communication - Video | O | X | X | X |
| Communication - Audio | O | O | O | X |
| Livecast - Video | O | X | X | O |
| Livecast - Audio | O | O | O | X |

### Client \(Beta\)

클라이언트에서 녹음 혹은 녹화 기능을 제공합니다.

{% tabs %}
{% tab title="Web" %}

{% endtab %}

{% tab title="Android" %}

{% endtab %}

{% tab title="iOS - Swift" %}

{% endtab %}

{% tab title="iOS - ObjC" %}

{% endtab %}
{% endtabs %}

### Server \(Beta\)

방송기능 사용시 서버를 통해 영상 녹화 기능이 제공됩니다. 방송이 진행되면 서버에서 녹화가 되며 방송이 종료되어 녹화가 완료된 순간, 사용자가 지정한 주소로 webhook GET이 호출됩니다. 이 전문안의 규격을 갖고 사용자는 영상을 다운로드 받을 수 있습니다. 영상은 6시간 후 리모트몬스터 서버에서 삭제됩니다.

서버를 통한 영상녹화 기능은 현재 베타기능이며 향후 별도의 과금체계와 함께 공식지원될 예정입니다.

#### Setting Webhook URL

REST GET이 호출될 URL 주소를 리모트몬스터에게 알립니다. 리모트몬스터에서 해당 설정이 완료 아래와 같이 지정된 주소로 GET이 호출됩니다. URL Parameter로 해당 방송의 Channel ID와 다운로드 URL이 제공됩니다. 이 Channel ID를 통해 어떤 방송인지를 구분가능합니다.

```text
GET http://MYWEBHOOKURL/slug?chid=CHANNELID&url=https://s3.amazonaws.com/__SERVICEID__/__CHANNELID__.mp4
```

만약 채널에 대한 것이 궁금하면 아래를 참고하세요.

{% page-ref page="channel.md" %}

#### Downloading Media

제공받은 URL에 접근함으로써 녹화된 영상을 다운로드 받을 수있습니다. 영상은 정상적으로  Webhook이 호출 된 이후 6시간 후 삭제되며 그 이전에는 언제든지 다운로드가 가능합니다.

간단하게 아래와 같이 `curl`, `wget`으로 테스트가 가능하며 이 기능을 서비스의 서버에서 구현하여 사용할 수 있습니다.

```text
curl -O https://s3.amazonaws.com/__SERVICEID__/__CHANNELID__.mp4
wget https://s3.amazonaws.com/__SERVICEID__/__CHANNELID__.mp4
```



