# Android - Channel

## 방송 및 통신 목록 검색 하기

Remon는 편리한 통신 및 방송 참여를 위하여 채널 검색 기능을 제공 합니다. 

RemonCall의 `searchCalls`, RemonCast의 `searchRooms`를 이용하여 방송 및 통신 목록을 검색할 수 있습니다.

### 통신 검색하기

{% code-tabs %}
{% code-tabs-item title="CallActivity.java" %}
```java
remonCall = RemonCall.builder().context(ListActivity.this).build();
remonCall.searchCalls();
remonCall.onSearch(calls -> {
    for (Room call : calls) {
        id = call.getId;
    }
});
```
{% endcode-tabs-item %}
{% endcode-tabs %}

### 방송 검색하기

{% code-tabs %}
{% code-tabs-item title="CastActivity.java" %}
```java
remonCast = RemonCast.builder().context(ListActivity.this).build();
remonCast.searchRooms();
remonCast.onSearch(calls -> {
    for (Room room : rooms) {
        id = room.getId;
    }
});
```
{% endcode-tabs-item %}
{% endcode-tabs %}

{% hint style="info" %}
검색은 같은 ServiceID를 가지는 채널을 대상으로 합니다.
{% endhint %}



