# Admin API - Livecast - beta

관리자를 위한 목적의 Admin API를 제공합니다. 이를 통해 방송의 상태등을 확인 할 수 있습니다.

{% api-method method="put" host="https://signal.remotemonster.com:3002" path="/api/record/:serviceid/:enable" %}
{% api-method-summary %}
녹화 정책
{% endapi-method-summary %}

{% api-method-description %}
 녹화 기능을 사용할지 여부를 결정합니다. 이 값은 기본값으로 지정되며, 별도로 클라이언트에서 정책과 별게로 녹화 기능을 선택적으로 사용가능합니다.
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-path-parameters %}
{% api-method-parameter name="enable" type="string" required=false %}
0 \|\| 1. 활성화 여부
{% endapi-method-parameter %}

{% api-method-parameter name="serviceid" type="string" required=false %}
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
{% api-method-parameter name="serviceid" type="string" required=false %}
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
{% api-method-parameter name="url" type="string" required=false %}
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
{% api-method-parameter name="serviceid" type="string" required=false %}
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
{% api-method-parameter name="url" type="string" required=false %}
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

