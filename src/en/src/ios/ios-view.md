iOS -- View
===========

With *Interface Builder*, you can use *StoryBoards* for configuration
and development. You can configure a View with your individual code
through the provided SDK.

For information on how to use *Interface Builder, r*efer to the
following.

{% page-ref page="ios-getting-start.md" %}

If you don't use *Interface Builder*, refer to the following code.

    let remonCall = RemonCall()
    remonCall.remoteView = myRemoteView
    remonCall.localView = myLocalView

If you specify a *remoteView* or *localView* in {% hint style =
\"info\"%} RemonController, *RemonController* will add the video
rendering view to the specified view and track the changes in the
specified view to set the video rendering view suitable for the size of
the specified view. {% endhint%}
