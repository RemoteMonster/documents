Web - Getting Started
=====================

Prerequisites (System Requirements)
-----------------------------------

-   Web browser, front-end development environment

-   Modern browsers that support *WebRTC* (Web Real-Time Communication) 

Creating and Configuring a New Project
--------------------------------------

The *RemoteMonster SDK* works in a browser environment. Simply prepare
for common front-end web development.

    npm init
    npm i http-server
    touch index.html
    npx http-server
    # Open browser "localhost:8081"

SDK Installation - npm
----------------------

*npm* can be used to easily install the SDK..

    npm i @remotemonster/sdk

{% code-tabs %} {% code-tabs-item title="index.html" %}

    <script src="node_modules/@remotemonster/sdk/remon.min.js"></script>

{% endcode-tabs-item %} {% endcode-tabs %}

SDK Installation - Static Import
--------------------------------

[*jsDelivr CDN*](https://www.jsdelivr.com) can be used. Insert it into a
HTML file as shown below.

{% code-tabs %} {% code-tabs-item title="index.html" %}

    <!-- Latest -->
    <script src="https://cdn.jsdelivr.net/npm/@remotemonster/sdk/remon.min.js"></script>

    <!-- Specific version -->
    <script src="https://cdn.jsdelivr.net/npm/@remotemonster/sdk@2.0.8/remon.min.js"></script>

{% endcode-tabs-item %} {% endcode-tabs %}

Development
-----------

Now you are ready for development. Refer to the following for detailed
development methods

### Service Key

To access the *RemoteMonster* broadcast and communications
infrastructure through the SDK, a Service Id and Key are required. For
simple testing and demonstration, you can skip this step. In order to
develop and operate the actual service, refer to the following to
acquire and apply the Service Id and Key.

{% page-ref page="../common/service-key.md" %}

### Broadcast

`Remon`` `can make broadcasting functions easy and fast.

#### Broadcast Transmission

    <video id="localVideo" autoplay muted></video>
    <script>
    const config = {
      view: {
        local: '#localVideo'
      }
    }

    const caster = new Remon({ config })
    caster.createCast()
    </script>

#### Broadcast Viewing

    <video id="remoteVideo" autoplay></video>
    <script>
    const config = {
      view: {
        remote: '#remoteVideo'
      }
    }

    const watcher = new Remon({ config })
    watcher.joinCast('CHANNEL_ID')
    </script>

Or refer to the following for more details.

{% page-ref page="../common/livecast.md" %}

### Communication

`Remon`` `can make communication functions easy and fast.

    <video id="localVideo" autoplay muted></video>
    <video id="remoteVideo" autoplay></video>
    <script>
    const config = {
      view: {
        local: '#localVideo',
        remote: '#remoteVideo'
      }
    }

    const remonCall = new Remon({ config })
    remonCall.connectCall('CHANNEL_ID')
    </script>

Or refer to the following for more details.

{% page-ref page="../common/untitled.md" %}
