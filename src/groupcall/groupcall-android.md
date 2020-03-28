# 그룹통화 만들기\(Android\)

## 그룹통화란?

다수의 참여자가 통화에 참여하는 서비스를 위한 기능입니다. 참여자는 앱을 이용하는 나와 그 외 참여자로 구분할 수 있습니다. 아래에서는 나와 참여자로 줄여서 표시합니다. 한 회기의 그룹통화는 RemonConference 클래스의 인스턴스로 대표됩니다. 나는 통화 연결, 참여자들의 입장/퇴장 알림 등 대부분의 일을 RemonConference 객체에게 위임합니다.

## RemonConference

안드로이드 SDK 버전 v2.7.0 이상  
그룹통화를 위해 RemonConference 객체를 생성하고, 설정을 진행합니다.

RemonConference 클래스는 그룹통화를 위해 아래 메소드를 제공합니다.

```kotlin
create( String roomName, Config config, OnEventCallback callback);
leave()
```



RemonConference 클래스는 콜백으로 사용하기 위해 아래 메소드를 제공합니다. 이하 콜백용 메소드라고 합니다. 콜백용 메소드는 위에서 언급한 메소드의 콜백으로만 호출하며, 일반적인 메소드처럼 호출하지 않습니다.

```kotlin
// 룸의 콜백용 메소드
on( "onRoomCreate" ) { participant:RemonParticipant
}on( "onUserJoined" ) { participant:RemonParticipant
}on( "onUserLeaved" ) { participant:RemonParticipant
}.close {
}.error { error:RemonException
}

// participant 콜백용 메소드
.on( "onComplete" ) { participant:RemonParticipant 
}
```

## 레이아웃 작업

그룹통화 화면을 나의 영상 한 개와 그룹 참여자의 영상 여러 개로 구성합니다. 레이아웃에 영상을 표시할 view를 만들고 인덱스를 지정하여 참여자의 영상을 원하는 위치에 표시할 수 있도록 합니다.

```markup
<layout>
<RelativeLayout
    android:id="@+id/rootLayout"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="#000">


    <androidx.constraintlayout.widget.ConstraintLayout
        android:id="@+id/constraintLayout"
        android:layout_width="match_parent"
        android:layout_height="match_parent">

        <!-- Local -->
        <RelativeLayout
            android:id="@+id/layout0"
            android:layout_width="0dp"
            android:layout_height="0dp"
            android:layout_margin="10dp"
            android:background="@drawable/view_shape"
            app:layout_constraintDimensionRatio="H,1:1.33"
            app:layout_constraintStart_toStartOf="parent"
            app:layout_constraintTop_toTopOf="parent"
            app:layout_constraintEnd_toEndOf="parent"
            app:layout_constraintBottom_toBottomOf="parent"
           >

            <org.webrtc.SurfaceViewRenderer
                android:id="@+id/surfRendererLocal"
                android:layout_width="match_parent"
                android:layout_height="match_parent"
                android:visibility="visible"
                />

        </RelativeLayout>



        <!-- Remote 1 -->
        <FrameLayout
            android:id="@+id/layout1"
            android:layout_width="80dp"
            android:layout_height="0dp"
            android:layout_margin="18dp"
            app:layout_constraintDimensionRatio="H,1:1.33"
            app:layout_constraintVertical_bias="0.1"
            app:layout_constraintEnd_toEndOf="parent"
            app:layout_constraintTop_toTopOf="parent"
            app:layout_constraintBottom_toBottomOf="parent"
            >


            <org.webrtc.SurfaceViewRenderer
                android:id="@+id/surfRendererRemote1"
                android:layout_width="match_parent"
                android:layout_height="match_parent"
                android:visibility="invisible"
                />
        </FrameLayout>


        <!-- Remote 2 -->
        <FrameLayout
            android:id="@+id/layout2"
            android:layout_width="80dp"
            android:layout_height="0dp"
            android:layout_margin="18dp"
            app:layout_constraintDimensionRatio="H,1:1.33"
            app:layout_constraintVertical_bias="0.3"
            app:layout_constraintEnd_toEndOf="parent"
            app:layout_constraintTop_toTopOf="parent"
            app:layout_constraintBottom_toBottomOf="parent"
            >


            <org.webrtc.SurfaceViewRenderer
                android:id="@+id/surfRendererRemote2"
                android:layout_width="match_parent"
                android:layout_height="match_parent"
                android:visibility="invisible"
                />

        </FrameLayout>


        <!-- Remote 3 -->
        <FrameLayout
            android:id="@+id/layout3"
            android:layout_width="80dp"
            android:layout_height="0dp"
            android:layout_margin="18dp"
            app:layout_constraintDimensionRatio="H,1:1.33"
            app:layout_constraintVertical_bias="0.5"
            app:layout_constraintEnd_toEndOf="parent"
            app:layout_constraintTop_toTopOf="parent"
            app:layout_constraintBottom_toBottomOf="parent"
            >


            <org.webrtc.SurfaceViewRenderer
                android:id="@+id/surfRendererRemote3"
                android:layout_width="match_parent"
                android:layout_height="match_parent"
                android:visibility="invisible"
                />

        </FrameLayout>


        <!-- Remote 4 -->
        <FrameLayout
            android:id="@+id/layout4"
            android:layout_width="80dp"
            android:layout_height="0dp"
            android:layout_margin="18dp"
            app:layout_constraintDimensionRatio="H,1:1.33"
            app:layout_constraintVertical_bias="0.7"
            app:layout_constraintEnd_toEndOf="parent"
            app:layout_constraintTop_toTopOf="parent"
            app:layout_constraintBottom_toBottomOf="parent"
            >


            <org.webrtc.SurfaceViewRenderer
                android:id="@+id/surfRendererRemote4"
                android:layout_width="match_parent"
                android:layout_height="match_parent"
                android:visibility="invisible"
                />

        </FrameLayout>



        <!-- Remote 5 -->
        <FrameLayout
            android:id="@+id/layout5"
            android:layout_width="80dp"
            android:layout_height="0dp"
            android:layout_margin="18dp"

            app:layout_constraintDimensionRatio="H,1:1.33"
            app:layout_constraintVertical_bias="0.9"
            app:layout_constraintEnd_toEndOf="parent"
            app:layout_constraintTop_toTopOf="parent"
            app:layout_constraintBottom_toBottomOf="parent"
            >


            <org.webrtc.SurfaceViewRenderer
                android:id="@+id/surfRendererRemote5"
                android:layout_width="match_parent"
                android:layout_height="match_parent"
                android:visibility="invisible"
                />

        </FrameLayout>


    </androidx.constraintlayout.widget.ConstraintLayout>
</RelativeLayout>
</layout>
```

## 레이아웃 초기화

레이아웃을 바인딩하고, 각 view를 배열에 담아 index 로 접근이 가능하도록 설정합니다.

```kotlin
var surfaceRendererArray:Array<SurfaceViewRenderer>

binding = DataBindingUtil.setContentView( this, R.layout.activity_name )
surfaceRendererArray = arrayOf(
    binding.surfRendererLocal,
    binding.surfRendererRemote1,
    binding.surfRendererRemote2,
    binding.surfRendererRemote3,
    binding.surfRendererRemote4,
    binding.surfRendererRemote5
)

// 비어있는 뷰를 처리하기 위한 배열입니다. 각 서비스에 따라 구
var availableView:Array<Boolean>
availableView = Array(mSurfaceViewArray.size) {false}
```

## RemonConference 객체 생성

RemonConference 객체를 생성하고, 나의 영상을 송출하기 위한 설정을 합니다.

```kotlin
private var remonConference = RemonConference()

var config = Config()
config.context = this
config.serviceId = "콘솔을 통해 발급 받은 Service Id"
config.key = "콘솔을 통해 발급 받은 Secret Key"

remonConference.create( "방이름", config) { participant ->
    // 마스터 유저(송출자,나자신) 초기화
    participant.localView = surfaceRendererArray[0]
    
    // 뷰 설정
    availableView[0] = true
}.close {
    // 마스터 유저가 연결된 채널이 종료되면 호출됩니다.
    // 송출이 중단되면 그룹통화에서 끊어진 것이므로, 다른 유저와의 연결도 모두 끊어집니다.
}.error { error:RemonException
    // 마스터 유저가 연결된 채널에서 에러 발생 시 호출됩니다.
    // 오류로 연결이 종료되면 error -> close 순으로 호출됩니다.
}
```

## 그룹통화 콜백

그룹통화가 생성되면 송출이 시작되고, 각 콜백이 호출됩니다. 콜백은 create\(\) 호출후 on\("이벤트"\){} 형태로 등록할 수 있습니다.  
새 참여자가 그룹통화에 입장하면 연결된 on 메소드의 콜백이 호출됩니다. on 메소드 콜백에서 참여자의 RemonParticipant 객체가 제공되므로, 해당 정보를 사용해 설정을 진행합니다. 

```kotlin
remonConference.create( "방이름", config) {
    .
    .
}.on( "onRoomCreated" ) { participant ->
    // 마스터 유저가 접속된 이후에 호출(실제 송출 시작)
    // TODO: 실제 유저 정보는 각 서비스에서 관리하므로, 서비스에서 채널과 실제 유저 매핑 작업 진행

    // tag 객체에 holder 패턴 형태로 객체를 지정해 사용할 수 있습니다.
    // 예제에서는 뷰설정을 위해 단순히 view의 index를 저장합니다.
    participant.tag = 0
}.on( "onUserJoined" ) { participant ->
    Log.d( TAG, "Joined new user" )
    // 그룹통화에 새로운 잠여자가 입장했을 때 호출됩니다.
    // 다른 사용자가 입장한 경우 초기화를 위해 호출됨
    // TODO: 실제 유저 매핑 : it.id 값으로 연결된 실제 유저를 얻습니다.


    // 뷰 설정
    val index = getAvailableView()
    if( index > 0 ) {
        participant.config.localView = null
        participant.config.remoteView = mSurfaceViewArray[index]
        participant.tag = index
    }
    
    // 피어가 연결이 완되었을때 처리할 작업이 있는 경우
    participant.on( "onComplete" ) { participant ->
        // updateView()
    }
}.on( "onUserLeaved" ) { participant ->
    // 상대방이 그룹통화에서 퇴장한 경우 or 연결이 종료된 경우 호출됩니다.
    // id 와 tag 를 참조해 어떤 사용자가 퇴장했는지 확인후 퇴장 처리를 합니다.
    val index = participant.tag as Int
    availableView[index] = false
}


// 비어있는 뷰는 아래처럼 얻어올 수 있습니다.
// 서비스에 해당하는 부분이므로 각 서비스 UI에 맞게 구성합니다.
private fun getAvailableView(): Int {
    for( i in 0 until this.mAvailableView.size) {
        if(!mAvailableView[i]) {
            mAvailableView[i] = true
            return i
        }
    }
    return -1
}
```

## 그룹통화 종료

그룹통화에서 퇴장하면 나와 그룹통화의 연결이 종료됩니다. 나와 참여자들 간의 연결도 종료됩니다.

```kotlin
remonConference.leave()
```

## RemonParticipant

각 참여자들과의 연결은 RemonConference 내부의 RemonParticipant 객체를 통해 이루어집니다. RemonParticipant 객체는 RemonClient를 상속받은 객체이므로, 공통적인 기능은 RemonCall, RemonCast 와 동일합니다. 각 이벤트마다 RemonParticipant 객체가 전달되므로 각 연결은 해당 객체를 통해 제어할 수 있으며, 마스터 객체의 경우 RemonConference 객체에서 얻어올 수 있습니다.

```kotlin
// 마스터 유저 얻기
RemonParticipant participant = remonConference.me

```

{% hint style="warning" %}
RemonParticipant 객체는 RemonClient를 상속받은 객체입니다. onCreate, onClose, onError 콜백은 on으로 재정의되어 RemonConference에서 관리, 사용되고 있으므로, 해당 콜백을 변경하지 마시기 바랍니다.
{% endhint %}

