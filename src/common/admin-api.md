# Admin API - beta

## Admin REST API

해당 서비스의 녹화 기능과 webhook을 변경 하기 위한 api를 제공.

HOST : [https://signal.remotemonster.com:3002](https://signal.remotemonster.com:3002/api/webhook/waggle)

Common Header

* secret : 서비스 계정 생성시 발급 받은 secret 값
* Content-Type : application/json

PUT : [/api/record/](https://signal.remotemonster.com:3002/api/webhook/waggle):serviceid/:enable

* params
  * serviceid : 자신의  serviceid
  * enable : 녹화 활성화 여부. 0 or 1

PUT : [/api/recordhook/](https://signal.remotemonster.com:3002/api/webhook/waggle):serviceid

* params :
  * serviceid : 자신의  serviceid
* body : JSON 
  * url : hook url
  * ex :

    ```javascript
    {
      "url": "http://55.194.164.60:1090/hook/room"
    }
    ```

PUT : [/api/](https://signal.remotemonster.com:3002/api/webhook/waggle)webhook[/](https://signal.remotemonster.com:3002/api/webhook/waggle):serviceid

* params :
  * serviceid : 자신의  serviceid
* body : JSON 
  * url : hook url
  * ex :

    ```javascript
    {
      "url": "http://55.194.164.60:1090/hook/room"
    }
    ```

