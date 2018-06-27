Channel
=======

Overview
--------

*RemoteMonster* provides resources shared by users during broadcasting
and communication under the name channel. This channel is created the
first time you create it, provides each unique Id, and gets or retrieves
a list of them to connect to a specific channel. In addition, you can
assign a nickname, *Name,* to your channel in order to make it easier to
use.

                  Class       Id(unique)
  --------------- ----------- ------------
  Livecast        remonCast   ChannelId
  Communication   remonCall   ChannelId

Please refer to the following for the overall flow and corresponding
*Callback*s.

{% page-ref page="../overview/flow.md" %}

{% page-ref page="callbacks.md" %}

Livecast
--------

Here is how to get a list of broadcasts on the air. It is commonly used
in UIs to find broadcasts to enter from the list.

{% tabs %} {% tab title="Web" %}

    const remonCast = new Remon()
    const casts = await remonCast.fetchCasts()    // Return Promise

{% endtab %}

{% tab title="Android" %}

    remonCast = RemonCast.builder().context(ListActivity.this).build();
    remonCast.fetchCasts();
    remonCast.onFetch(casts -> {
        for (Channel cast : casts) {
            myChannelId = cast.getId;
        }
    });

    remonCast.join(myChannelId);

{% endtab %}

{% tab title="iOS" %}

    remonCast.fetchCasts { (err, results) in
        if let err = err {
            // If there is an error during the search, remonCast.onError () will not be called.
            print(err.localizedDescription)
        } else if let results = results {
            for cast:RemonSearchResult in results {
                myChannelId = cast.id
            }
        }
    }

    remonCast.join(myChannelId)

{% endtab %} {% endtabs %}

Communication
-------------

Here\'s how to get a list of calls from your communications. It is used
in situations such as a random chat and is not generally used.

{% tabs %} {% tab title="Web" %}

    const remonCall = new Remon()
    const calls = await remonCall
      .fetchCasts()                             // Return Promise
      .filter(item => item.status === "WAIT")

{% endtab %}

{% tab title="Android" %}

    remonCall = RemonCall.builder().build();
    remonCall.fetchCalls();
    remonCall.onFetch(calls -> {
        for (Channel call : calls) {
            if (call.getStatus.equals("WAIT")) {   // Only WAIT channels
                myChannelId = call.getId;
            }
        }
    });

    remonCall.connect(myChannelId)

{% endtab %}

{% tab title="iOS" %}

    let remonCall = RemonCall()
    remonCall.fetchCalls { (err, results) in
        if let err = err {
            // If there is an error during the search, remonCall.onError() will not be called.
            print(err.localizedDescription)
        } else if let results = results {
            for call:RemonSearchResult in results {
                if itme.status == "WAIT" {        // Only WAIT channels
                    myChannelId = call.id
                }
            }
        }
    }

    remonCall.connect(myChannelId)

{% endtab %} {% endtabs %}
