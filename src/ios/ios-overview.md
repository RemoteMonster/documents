---
description: RemoteMonster iOS SDK의 사용에 대해 안내합니다.
---

# iOS - Overview

## 쉽고 간편하게 방송 또는 통신 기능을 구현 하세요.

![](../.gitbook/assets/undefined.jpg)

Remon를 클래스는 Remon SDK 에서 가장 핵심이 되는 클래스 입니다. Remon 클래스를 사용하고, RemonDelegate를 직접 구현 하여 Remon이 제공하는 통신 기능과 방송 기능을 이용 할 수도 있지만 이는 복잡하고, 따분한 작업이 될 것입니다. 그래서 SDK 사용자가 좀 더 쉽고 빠르게 Remon를 이용 할 수 있도록 복잡 하고, 반복적인 기본 작업을 포함 하고 있는 RemonController 클래스와 Interface Builder\(이하 IB\) 지원을 위한 RemonIBController 클래스를 제공 합니다. RemonController 클래스를 이용한면 복잡한 RemonDelegate의 메소드들을 구현 할 필요 없이 필요한 부분 추가 적으로 구현 하면 됩니다.

이 장에서는 코드상에서 RemonCall 클래스와 RemonCast 클래스를 이용하는 방법을 간략 소개 합니다. IB를 이용하는 더 자세한 활용 방법은 **iOS - Getting Start** 장을 참조 하세요.

