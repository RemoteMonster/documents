iOS - Getting Started
=====================

Prerequisites (System Requirements)
-----------------------------------

-   Xcode IDE(Integrated Development Environment)

-   iOS 9.2 or later

Creating and Configuring a New Project
--------------------------------------

Create a new *Swift*-based project in Xcode.

You need to set *No* to the *Enable Bitcode* option in the *Build
Settings* after project creation.

Bitcode

Bitcode

You also need to add or change the following items in *Info.plist.*

-   Privacy: Bluetooth, Microphone, Camera

Settings

Settings

SDK Installation - Cocoapods
----------------------------

Add *pod \'RemoteMonster\', \'\~\> 2.0\'* to the *Podfile* of the
project in which you want to install the SDK.

{% code-tabs %} {% code-tabs-item title="Podfile" %}

    target 'MyApp' do
      pod 'RemoteMonster', '~> 2.0'
    end

{% endcode-tabs-item %} {% endcode-tabs %}

Then run *pod install* on the terminal. If *pod install* does not work,
run *pod update*.

    $ pod install

SDK Installation - Direct Import
--------------------------------

First, download the latest version of the iOS SDK via the link below.

{% embed
data="{\"url\":\"https://github.com/remotemonster/ios-sdk\",\"type\":\"link\",\"title\":\"RemoteMonster/ios-sdk\",\"description\":\"ios-sdk
- RemoteMonster iOS SDK &
examples\",\"icon\":{\"type\":\"icon\",\"url\":\"https://github.com/fluidicon.png\",\"aspectRatio\":0},\"thumbnail\":{\"type\":\"thumbnail\",\"url\":\"https://avatars2.githubusercontent.com/u/20677626?s=400&v=4\",\"width\":400,\"height\":400,\"aspectRatio\":1}}"
%}

There are two frameworks when I unzip the downloaded *RemoteMonster iOS
SDK*.

Drag and drop each *Framework* from the *Finder* to the *Project Tree*
pane. You will then see the *RemoteMonster SDK* recognized as a
framework.

Framework

Framework

Remon Setup and Layout Configuration
------------------------------------

With *InterfaceBuilder*, *Remon* can be configured by using
*RemonIBController*.

-   Add a subobject of RemonIBController (RemonCall or RemonCast) to the
    storyboard.

    -   *RemonCall* supports 1: 1 communication and *RemonCast* supports
        1: N broadcasting.

    -   Use *Utilities view* to configure *Remon* in *InterfaceBuilder*.

-   Set *ServiceID* and *Service Key*.

    -   If you want to run a test simply, you do not need to enter
        anything.

    -   If you consider actual service, please refer to the following
        and get the service key to use..

{% page-ref page="../common/service-key.md" %}

-   Place *View* at the desired location in the desired scene in the
    storyboard, and bind it to the *remoteView* and *localView* of the
    *RemonIBController*.

-   Import the *RemoteMonster SDK* into the *ViewContoller* using
    *Remon*, and bind the *RemonIBController* object to an outlet
    variable.

Development
-----------

Now you are ready for development. Refer to the following for detailed
development methods.

### Broadcast

*RemonCast* can make broadcasting functions easy and fast.

#### Broadcast Transmission

    let caster = RemonCast()
    caster.create()

#### Broadcast Viewing

    let watcher = RemonCast()
    watcher.join("CHANNEL_ID")

Or refer to the following for more details.

{% page-ref page="../common/livecast.md" %}

### Communication

*RemonCall* can make communication functions easy and fast

    let remonCall = RemonCall()
    remonCall.connect("CHANNEL_ID")            // Communication

Or refer to the following for more details.

{% page-ref page="../common/untitled.md" %}

Known Caveats
-------------

### Audio Types

There are two types of audio in *Remon*: *voice* and *music*. The
default operation mode is *voice*, and you can use the *music* mode if
you want to use various sounds rather than voice. In particular, the
*music* mode tends to be more suitable for the broadcast.

Add the *RemonSettings.plist* file to your project and change the
*AudioType* value to the desired mode.

### Background Mode Support

If you need to constantly connect to the SDK in the background, you can
set the option in the following menu: *Project\> Targets\>
Capabilities\> Background Modes*. If you do not set the background mode,
the connection with *RemoteMonster* will be terminated and the broadcast
and call will be ended when the app moves to the background.

Please refer to the following for background mode support.

{% embed
data="{\"url\":\"https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/BackgroundExecution/BackgroundExecution.html\",\"type\":\"link\",\"title\":\"Background
Execution\",\"description\":\"Introduces iOS and describes the
development process for iOS
applications.\",\"icon\":{\"type\":\"icon\",\"url\":\"https://developer.apple.com/favicon.ico\",\"aspectRatio\":0}}"
%}
