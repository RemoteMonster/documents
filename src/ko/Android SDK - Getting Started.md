# Android SDK - Getting Started

## 설치

* `project build.gradle`에서 repository url 설정

```groovy
allprojects {
  repositories {
    jcenter()
    maven {
      url 'https://remotemonster.com/artifactory/libs-release-local'
    }
  } 
}
module build.gradle
compile(group: 'com.remon', name: 'remondroid', version: '0.0.4', ext: 'aar')
```

## 설정

### `AndroidManifest.xml`에 추가

```xml
<uses-feature android:name="android.hardware.camera" />
<uses-feature android:name="android.hardware.camera2" />
<uses-feature android:name="android.hardware.camera.autofocus" />
<uses-feature android:name="android.hardware.camera.flash" />
<uses-feature android:glEsVersion="0x00020000" android:required="true" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.CHANGE_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.CHANGE_WIFI_STATE"/>
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.BLUETOOTH"/>
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN"/>
<uses-permission android:name="android.permission.BROADCAST_STICKY"/>
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
```

### Remon을 위한 local과 remote view를 layout에 추가

```xml
<com.remon.remondroid.PercentFrameLayout android:id="@+id/remote_video_layout"
 android:layout_width="match_parent"
 android:layout_height="match_parent">
 <org.webrtc.SurfaceViewRenderer
 android:id="@+id/remote_video_view"
 android:layout_width="wrap_content"
 android:layout_height="wrap_content" />
</com.remon.remondroid.PercentFrameLayout>
<com.remon.remondroid.PercentFrameLayout android:id="@+id/local_video_layout"
 android:layout_width="match_parent"
 android:layout_height="match_parent">
 <org.webrtc.SurfaceViewRenderer
 android:id="@+id/local_video_view"
 android:layout_width="wrap_content"
 android:layout_height="wrap_content" />
</com.remon.remondroid.PercentFrameLayout>
```

### RemonObserver implementation 생성

```java
public class MyObserver extends RemonObserver {
  @Override
  public void onError(Throwable t) {
    super.onError(t);
  }
}
```

### Create Remon의 Config Object

```java
Config config = new com.remon.remondroid.Config();
config.setKey("1234567890");
config.setServiceId("SERVICEID1");
config.setLocalView((SurfaceViewRenderer) findViewById(R.id.local_video_view));
config.setRemoteView((SurfaceViewRenderer) findViewById(R.id.remote_video_view));
```

## 초기화

```java
// create channel
remon = new Remon(MainActivity.this, config, new MyObserver());

// connect Channel with channel name
remon.connectChannel(“myroom”);
```

## onDestroy\(\) 처리

```java
remon.close();
```

## permissionRequest to client 처리

변수 선언

```java
public static final String[] MANDATORY_PERMISSIONS = {
  "android.permission.INTERNET",
  "android.permission.CAMERA",
  "android.permission.RECORD_AUDIO",
  "android.permission.MODIFY_AUDIO_SETTINGS",
  "android.permission.ACCESS_NETWORK_STATE",
  "android.permission.CHANGE_WIFI_STATE",
  "android.permission.ACCESS_WIFI_STATE",
  "android.permission.READ_PHONE_STATE",
  "android.permission.BLUETOOTH",
  "android.permission.BLUETOOTH_ADMIN",
  "android.permission.WRITE_EXTERNAL_STORAGE"
};

  if (android.os.Build.VERSION.SDK_INT >= 23) {
    checkPermission(MANDATORY_PERMISSIONS);
  }

  private final int MY_PERMISSION_REQUEST_STORAGE = 100;

  @SuppressLint("NewApi")
  private void checkPermission(String[] permissions) {
  requestPermissions(permissions, MY_PERMISSION_REQUEST_STORAGE);
}
```

