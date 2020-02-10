# Managing Channels

리모트몬스터는 채널 관리를 위한 서버용 API를 제공합니다. 이 API는 채널 검색, 채널 강제 종료 기능을 제공합니다.   
서버용 API는 앱용\(클라이언트용\) API와 달리 비디오/오디오를 전송할 수 없습니다. 

## ※ 주의 사항

{% hint style="info" %}
타인의 Service ID, Secret Key를 무단으로 이용하면 처벌을 받을 수 있습니다.   
\(정보통신망 이용 촉진 및 정보보호에 관한 법률, 통신비밀보호법, 형법 등에 의거\)
{% endhint %}

{% hint style="info" %}
타인의 Service ID, Secret Key를 무단으로 이용하면 업무 방해에 대한 피해를 보상해야합니다.  
\(민법 등에 의거\)
{% endhint %}

## Service ID, Secret Key 확인

리모트몬스터 웹 콘솔의 Project Information 메뉴에서 Service ID, Secret Key를 확인할 수 있습니다.  
Secret Key는 \*\*\*\*\*\*\*\*\*\*\*\*\*\* 이 아닙니다. 우측 눈 아이콘을 누르면 표시됩니다.

![&#xC6F9; &#xCF58;&#xC194;&#xC758; &#xD504;&#xB85C;&#xC81D;&#xD2B8; &#xAE30;&#xBCF8;&#xC815;&#xBCF4; &#xD654;&#xBA74;](../.gitbook/assets/image-3%20%281%29.png)

## 채널 검색

{% api-method method="post" host="https://signal.remotemonster.com/lambda/broadcast-channel-list" path="" %}
{% api-method-summary %}
https://consoleapi.remotemonster.com/v1/search
{% endapi-method-summary %}

{% api-method-description %}
기간과 채널 이름 조건에 따라 채널을 검색합니다.  
  
새로 생성된 채널이 검색되려면 다소 시간이 걸릴 수 있습니다. 새로 생성된 채널을 확인하려면 앱으로부터 채널 정보를 받는 것이 좋습니다. 앱은 SDK의 onCreate, onComplete 콜백 함수를 이용하여 채널 ID를 확인할 수 있습니다.
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-headers %}
{% api-method-parameter name="Content-type" type="string" required=false %}
application/json
{% endapi-method-parameter %}
{% endapi-method-headers %}

{% api-method-body-parameters %}
{% api-method-parameter name="serviceId" type="string" required=false %}
Service ID
{% endapi-method-parameter %}

{% api-method-parameter name="secret" type="string" required=false %}
Secret Key
{% endapi-method-parameter %}

{% api-method-parameter name="keyword" type="string" required=false %}
채널 ID가 포함할 문자열
{% endapi-method-parameter %}

{% api-method-parameter name="starttime" type="integer" required=false %}
조회할 기간, Unix time, 초단위
{% endapi-method-parameter %}

{% api-method-parameter name="endtime" type="integer" required=false %}
조회할 기간, Unix time, 초단위
{% endapi-method-parameter %}
{% endapi-method-body-parameters %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=200 %}
{% api-method-response-example-description %}
peerCount 는 누적 세션수입니다. 
{% endapi-method-response-example-description %}

```
{
  "startTime": 1577862148,
  "currentTime": 1580454148,
  "totalCount": 1,
  "items": [
    {
      "chid": "20200110",
      "createTime": 1580281515,
      "endTime": 1580281577,
      "peerCount": 2
    }
  ]
}
```
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}



## 방송 중인 채널 조회

{% api-method method="post" host="https://signal.remotemonster.com/lambda/broadcast-channel-list" path="" %}
{% api-method-summary %}
https://signal.remotemonster.com/lambda/broadcast-channel-list
{% endapi-method-summary %}

{% api-method-description %}
방송 중인 채널을 조회합니다. 종료된 방송 채널은 조회되지 않습니다.
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-headers %}
{% api-method-parameter name="Content-type" type="string" required=false %}
application/json
{% endapi-method-parameter %}
{% endapi-method-headers %}

{% api-method-body-parameters %}
{% api-method-parameter name="serviceId" type="string" required=false %}
Service ID
{% endapi-method-parameter %}

{% api-method-parameter name="secret" type="string" required=false %}
Secret Key
{% endapi-method-parameter %}
{% endapi-method-body-parameters %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=200 %}
{% api-method-response-example-description %}
id 는 채널 ID 입니다.   
numOfWatchers 는 조회 시각의 시청세션수입니다, 누적 시청세션수가 아닙니다.
{% endapi-method-response-example-description %}

```
[
  {
    "id": "1581324488053_Dc5aQ",
    "serviceId": "a3333c-f333-4f9a-9a47-66f838ed44e2",
    "createTime": "2020-02-10T08:48:09.828Z",
    "numOfWatchers": 0
  },
  {
    "id": "1581324445005_s1c9g",
    "serviceId": "a3331c3c-f333-4f9a-9a47-66f838ed44e2",
    "createTime": "2020-02-10T08:47:27.011Z",
    "numOfWatchers": 0
  }
]

```
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}



## 채널 강제 종료

{% api-method method="post" host="https://signal.remotemonster.com/lambda/channel-force-termination" path="" %}
{% api-method-summary %}
https://signal.remotemonster.com/lambda/channel-force-termination
{% endapi-method-summary %}

{% api-method-description %}

{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-headers %}
{% api-method-parameter name="Content-type" type="string" required=false %}
application/json
{% endapi-method-parameter %}
{% endapi-method-headers %}

{% api-method-body-parameters %}
{% api-method-parameter name="serviceId" type="string" required=false %}
Service ID
{% endapi-method-parameter %}

{% api-method-parameter name="secret" type="string" required=false %}
Secret Key
{% endapi-method-parameter %}

{% api-method-parameter name="channelId" type="string" required=false %}
종료할 채널 ID
{% endapi-method-parameter %}
{% endapi-method-body-parameters %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=200 %}
{% api-method-response-example-description %}

{% endapi-method-response-example-description %}

```
{
  "send": true
}
```
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}







