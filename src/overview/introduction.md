---
description: 리모트 몬스터를 개발하기 위해 알아야할 기본적인 것들을 소개합니다.
---

# Introduction

## 개요

RemoteMonster는 실시간 방송통신 기능을 제공하고 있습니다.

이 기능을 개발 하기 위해서는  리모트몬스터 서버에서 제공되는 API와 리모트몬스터 서버를 활용하기 위한 클라이언트 SDK를 사용하게 됩니다.  개발시에는 대부분 SDK를 통해 개발을 진행하게 됩니다. SDK의 구성과 흐름을 전체적으로 살펴보고 싶으면 아래를 참고하세요.

{% page-ref page="flow.md" %}

{% page-ref page="structure.md" %}

## 개발 절차

### 서비스 등록 및 인증키 획득

리모트몬스터 홈페이지에서 서비스 개발을 위한 등록을 마칩니다. 리모트몬스터는 메일을 통해 인증키를 발급합니다.

{% embed data="{\"url\":\"https://remotemonster.com\",\"type\":\"link\",\"title\":\"RemoteMonster\",\"icon\":{\"type\":\"icon\",\"url\":\"https://uploads-ssl.webflow.com/5ae923e519474e392b0c80fc/5b02226459e4c8782a772e2f\_remon\_logo-09.png\",\"aspectRatio\":0},\"caption\":\"RemoteMonster Homepage\"}" %}

자세한 내용은 아래를 참고하세요.

{% page-ref page="../common/service-key.md" %}

### SDK 및 개발 환경 설정

Browser, Android, iOS 모두 각각에 맞는 패키매니저를 통해 매우 간단하게 준비 가능합니다.

아래를 통해 각 플랫폼별 세부적인 내용을 확인해 보세요.

{% page-ref page="../web/web-getting-start.md" %}

{% page-ref page="../android/android-getting-start.md" %}

{% page-ref page="../ios/ios-getting-start.md" %}

### 개발

리모트몬스터는 쉬운 개발을 위해 커뮤니티와 다양한 예제 코드를 제공하고 있습니다.

아래의 리모트 몬스터 Github에서 플랫폼별 예제와 데모 그리고 레퍼런스 문서를 직접 확인해 보세요.

{% embed data="{\"url\":\"https://github.com/remotemonster\",\"type\":\"link\",\"title\":\"remotemonster\",\"description\":\"GitHub is where people build software. More than 27 million people use GitHub to discover, fork, and contribute to over 80 million projects.\",\"icon\":{\"type\":\"icon\",\"url\":\"https://github.com/fluidicon.png\",\"aspectRatio\":0},\"thumbnail\":{\"type\":\"thumbnail\",\"url\":\"https://avatars1.githubusercontent.com/u/20677626?s=280&v=4\",\"width\":280,\"height\":280,\"aspectRatio\":1},\"caption\":\"RemoteMonster Github Repository\"}" %}

혹시 어려운 점이 생기면 리모트 몬스터의 커뮤니티를 둘러보세요. 아래의 커뮤니티에 질문을 올리면 쉽고 빠르게 답변을 얻을 수 있습니다.

{% embed data="{\"url\":\"https://community.remotemonster.com\",\"type\":\"link\",\"title\":\"Community\",\"description\":\"RemoteMonster Community Forums\",\"icon\":{\"type\":\"icon\",\"url\":\"//community.remotemonster.com/uploads/default/original/1X/d10bec2eae130debf322e6198e90175dd7920d72.png\",\"width\":144,\"height\":144,\"aspectRatio\":1},\"thumbnail\":{\"type\":\"thumbnail\",\"url\":\"//community.remotemonster.com/uploads/default/original/1X/d10bec2eae130debf322e6198e90175dd7920d72.png\",\"width\":144,\"height\":144,\"aspectRatio\":1},\"caption\":\"RemoteMonster Community\"}" %}

### 운영

서비스 개발이 끝나면 상용 버전의 서비스 시작 전 리모트몬스터에 통보합니다. 리모트몬스터는 보다 나은 품질과 안정성을 제공하기 위한 서버세팅과 관리자 화면을 제공합니다.

테스트용키가 아니라 운영 키를 사용하여 보안과 품질을 높이세요.

{% page-ref page="../common/service-key.md" %}

### 관리

리모트몬스터는 상용 서비스에 한하여 별도의 관리자 화면을 제공하여 트래픽 정보와 통화 품질에 대한 정보를 실시간으로 제공합니다.

이를 통해 어떤 고객에게 주로 문제가 발생하는지, 어떻게 개선하면 좋을지 점검할 수 있습니다.

