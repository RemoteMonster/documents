# Flow

## Overview

RemoteMonster를 사용하는 전반에 있어서 보편적인 흐름이 있습니다. 각각 아래를 참고하세요.

## Livecast

* Caster: 방송을 송출하는 행위자
* Watcher: 방송을 시청하는 행위자

|  | 초기화 | 방생성 | 방접속 | 해지 |
| --- | --- | --- | --- | --- |
| Caster Event | connect RemoteMonster | `createRoom()` | - | `close()`, disconnect  |
| Caster Callback | `onInit` | `onCreate`, `onComplete` | - | `onClose` |
| Watcher Event | connect RemoteMonster | - | `joinRoom('chid')` | `cloase()`, disconnect |
| Watcher Callback | `onInit` | - | `onComplete` | `onClose` |

## Communication

* Caller : 통신을 요청하는 행위자
* Callee : 통신을 응답하는 행위자

|  | 초기화 | 채널 생성 | 채널 접속 | 통화시작 | 해지 |
| --- | --- | --- | --- | --- |
| Caller Event | connect RemoteMonster | `connectChannel()` | - |  | `close()`, disconnect  |
| Caller Callback | `onInit` | `onConnect` | - | `onComplete` | `onClose` |
| Callee Event | connect RemoteMonster | - | `connectChannel('chid')` |  | `cloase()`, disconnect |
| Callee Callback | `onInit` | - | `onConnect` | `onComplete` | `onClose` |

