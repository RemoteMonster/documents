# Webhook API - Livecast - beta

기능개발시 필요에 따라 리모트몬스터로부터 특정 정보를 받을 필요가 종종 생깁니다. 리모트몬스터는 이를 Webhook 형태로 제공하고 있습니다. 호출 받고자하는 Webhook 주소는 아래를 참고하여 설정합니다.

{% page-ref page="admin-livecast.md" %}

{% api-method method="post" host="https://YOUR\_DOMAIN.COM/SLUG/" path=" " %}
{% api-method-summary %}
 record done
{% endapi-method-summary %}

{% api-method-description %}
 녹화가 완료되면 아래와 같이 JSON 몸체와 함께 POST를 호출 합니다. 
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-body-parameters %}
{% api-method-parameter name="id" type="string" required=true %}
녹화가 진행된 Channel Id
{% endapi-method-parameter %}

{% api-method-parameter name="url" type="string" required=true %}
녹화된 파일의 URL
{% endapi-method-parameter %}

{% api-method-parameter name="duration" type="string" required=false %}
녹화된 시간
{% endapi-method-parameter %}

{% api-method-parameter name="filesize" type="string" required=false %}
녹화된 파일의 크기\(Byte\)
{% endapi-method-parameter %}

{% api-method-parameter name="thumbnail" type="string" required=false %}
녹화된 파일의 썸네일 URL
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

자세한 내용은 아래를 확인하세요.

{% page-ref page="../common/record.md" %}

{% api-method method="get" host="https://YOUR\_DOMAIN.COM/SLUG/" path=" " %}
{% api-method-summary %}
 channel create, close
{% endapi-method-summary %}

{% api-method-description %}
 방송이 종료되면 아래와 같이 해당하는 값을 Query로 호출합니다. 
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-query-parameters %}
{% api-method-parameter name="action" type="string" required=false %}
close \|\| create
{% endapi-method-parameter %}

{% api-method-parameter name="chid" type="string" required=true %}
Channel Id
{% endapi-method-parameter %}
{% endapi-method-query-parameters %}
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



