Android - Getting Started
=========================

Prerequisites (System Requirements)
-----------------------------------

-   Android IDE(Integrated Development Environment, *Android Studio*)

-   minSdkVersion 18 or higher

-   java 1.8 or higher

Creating and Configuring a New Project
--------------------------------------

### Create a project and set the API level

Set the Android version to *API Level 18 or higher*.

### Compatibility Settings

In the *Open Module Settings*, set the *Source Compatibility* and
*Target Compatibility* to 1.8 or higher.

### Module Gradle Settings

Edit the *build.gradle* (Module: app) to add the following in the
'*dependencies*' section.

    dependencies {
        /* RemoteMonster SDK */
        compile 'com.remotemonster:sdk:2.0.12'
    }

### Permission Settings

For the latest version of Android, the user will be directly asked about
the permissions when using the app for the first time. The permissions
to be handled are as follows:

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

Development
-----------

Now you are ready for development. Refer to the following for detailed
development methods.

### Service Key

To access the *RemoteMonster* broadcast and communications
infrastructure through the SDK, Service Id and Key are required. For
simple testing and demonstration, you can skip this step. In order to
develop and operate the actual service, please refer to the following to
acquire and apply the Service Id and Key.

{% page-ref page="../common/service-key.md" %}

### Broadcast

*RemonCast* can make broadcasting functions easy and fast.

#### Broadcast Transmission

    caster = RemonCast.builder()
        .context(CastActivity.this)
        .localView(surfRendererlocal)          // Self Video Renderer
        .build();
    caster.create();

#### Broadcast Viewing

    watcher = RemonCast.builder()
        .context(ViewerActivity.this)
        .remoteView(surfRendererRemote)        // broadcaster’s Video Renderer
        .build();
    watcher.join("CHANNEL_ID");                // The channel you want to join

Or refer to the following for more details.

{% page-ref page="../common/livecast.md" %}

### Communication

*RemonCall* can make communication functions easy and fast.

    remonCall = RemonCall.builder()
        .context(CallActivity.this)        
        .localView(surfRendererLocal)        //My Video Renderer
        .remoteView(surfRendererRemote)      //The other video Renderer
        .build();
    remonCall.connect("CHANNEL_ID")

Or refer to the following for more details.

{% page-ref page="../common/untitled.md" %}
