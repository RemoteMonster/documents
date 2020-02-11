# Admin API - Livecast - beta

관리자를 위한 목적의 Admin API를 제공합니다. 이를 통해 방송의 상태등을 확인 할 수 있습니다.

{% api-method method="put" host="https://signal.remotemonster.com:3002" path="/api/record/:serviceid/:enable" %}
{% api-method-summary %}
녹화 정책
{% endapi-method-summary %}

{% api-method-description %}
리모트몬스터는 방송서버 측 녹화 기능을 제공합니다. 이는 방송자의 비디오를 리모트몬스터가 받아 파일로 저장하는 것입니다. 방송서버 측 녹화 기능을 이용하기 전에 이메일로 사용 신청을 하십시오.  
이 API는 방송서버의 녹화 기능을 켜고 끕니다. 새 프로젝트\(서비스\)는 기본값으로 방송서버의 녹화 기능이 꺼져있습니다.  
방송서버의 녹화 기능은 앱\(클라이언트\)의 녹화 기능과 별개입니다.
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-path-parameters %}
{% api-method-parameter name="enable" type="string" required=true %}
0 \|\| 1. 활성화 여부
{% endapi-method-parameter %}

{% api-method-parameter name="serviceid" type="string" required=true %}
 접근하고자하는 Service Id
{% endapi-method-parameter %}
{% endapi-method-path-parameters %}

{% api-method-headers %}
{% api-method-parameter name="secret" type="string" required=true %}
발급받은 서비스 키
{% endapi-method-parameter %}
{% endapi-method-headers %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=200 %}
{% api-method-response-example-description %}

{% endapi-method-response-example-description %}

```

```
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}

{% api-method method="put" host="https://signal.remotemonster.com:3002" path="/api/recordhook/:serviceid" %}
{% api-method-summary %}
녹화 완료시 Webhook Url
{% endapi-method-summary %}

{% api-method-description %}
녹화가 완료될시 호출하고자 하는 Url. 해당 Url로 녹화가 완료되면 POST가 호출됩니다. 자세한 내용은 Record 항목을 살펴보세요.
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-path-parameters %}
{% api-method-parameter name="serviceid" type="string" required=true %}
 접근하고자하는 Service Id
{% endapi-method-parameter %}
{% endapi-method-path-parameters %}

{% api-method-headers %}
{% api-method-parameter name="Content-Type" type="string" required=true %}
application/json
{% endapi-method-parameter %}

{% api-method-parameter name="secret" type="string" required=true %}
발급받은 서비스 키
{% endapi-method-parameter %}
{% endapi-method-headers %}

{% api-method-body-parameters %}
{% api-method-parameter name="url" type="string" required=true %}
 웹훅을 받고자 하는 url
{% endapi-method-parameter %}
{% endapi-method-body-parameters %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=200 %}
{% api-method-response-example-description %}

{% endapi-method-response-example-description %}

```

```
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}

{% page-ref page="../common/record.md" %}

{% api-method method="put" host="https://signal.remotemonster.com:3002" path="/api/webhook/:serviceid" %}
{% api-method-summary %}
방송 종료시 Webhook Url
{% endapi-method-summary %}

{% api-method-description %}
 방송 종료시 호출하고자 하는 Url. 해당 Url로 방송이 종료되면 POST가 호출됩니다. 확실하게 방송이 종료됬는지 여부를 확인받기 위한 용도로 필요합니다.
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-path-parameters %}
{% api-method-parameter name="serviceid" type="string" required=true %}
 접근하고자하는 Service Id
{% endapi-method-parameter %}
{% endapi-method-path-parameters %}

{% api-method-headers %}
{% api-method-parameter name="Content-Type" type="string" required=true %}
application/json
{% endapi-method-parameter %}

{% api-method-parameter name="secret" type="string" required=true %}
발급받은 서비스 키
{% endapi-method-parameter %}
{% endapi-method-headers %}

{% api-method-body-parameters %}
{% api-method-parameter name="url" type="string" required=true %}
 웹훅을 받고자 하는 url
{% endapi-method-parameter %}
{% endapi-method-body-parameters %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=200 %}
{% api-method-response-example-description %}

{% endapi-method-response-example-description %}

```

```
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}

