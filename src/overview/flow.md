# Flow

## Overview

RemoteMonster를 사용하는 전반에 있어서 보편적인 흐름이 있습니다. 각각 아래를 참고하세요.

## Livecast

방송시에는 간단하게 방을 생성하여 방송을 송출하고, 방에 접속하여 방송을 수신하는 경우로 나뉩니다. 아래와 같은 흐름을 가지고 있습니다.

* Caster: 방송을 송출하는 행위자
* Viewer: 방송을 시청하는 행위자

|  | 초기화 | 채널 생성 | 채널 접속 | 해지 |
| :--- | :--- | :--- | :--- | :--- |
| Caster Event | ready RemoteMonster | `create()` | - | `close()`, disconnect |
| Caster Callback | `onInit` | `onCreate` | - | `onClose` |
| Viewer Event | ready RemoteMonster | - | `join('channelId')` | `cloase()`, disconnect |
| Viewer Callback | `onInit` | - | `onJoin` | `onClose` |

## Communication

통신에서는 통화를 요청하고 이를 수신하는 행위로 구분됩니다. 통화를 요청하는 측은 채널을 생성하고 상대방을 기다리는 상태가 되며, 이때 얻은 chid를 통해 상대방이 같은 채널에 접속하게 되고 상호간 통화가 시작됩니다.

* Caller : 통신을 요청하는 행위자
* Callee : 통신을 응답하는 행위자

|  | 초기화 | 채널 생성 | 채널 접속 | 통화시작 | 해지 |
| :--- | :--- | :--- | :--- | :--- | :--- |
| Caller Event | ready RemoteMonster | `connect()` | Wait callee | Caller, Callee Connected | `close()`, disconnect |
| Caller Callback | `onInit` | `onConnect` | - | `onComplete` | `onClose` |
| Callee Event | ready RemoteMonster | - | `connect('channelId')` | Caller, Callee Connected | `close()`, disconnect |
| Callee Callback | `onInit` | - | `onConnect` | `onComplete` | `onClose` |

