Real-time Quality Statistics Report
===================================

Overview
--------

During a video and voice call, you can check its current quality in
levels from 1 to 5.

Users sometimes complain about their service problems even if the call
quality is poor or disconnected because of their network problems.
Therefore, it is possible to inform users of their network problems in
advance or to handle various UIs.

Currently, this call quality data can be received once every 5 seconds.

  levels   Quality                   Remarks   
  -------- ------------------------- --------- --
  1        Very Good                           
  2        Good                                
  3        Poor                                
  4        Very Poor                           
  5        Broadcast/call disabled             

Usage
-----

{% tabs %} {% tab title="Web" %}

    const listener = {
      onStat(result){
        const stat = `State: l.cand: ${result.localCandidate} /r.cand: ${result.remoteCandidate} /l.res: ${result.localFrameWidth} x ${result.localFrameHeight} /r.res: ${result.remoteFrameWidth} ${result.remoteFrameHeight} /l.rate: ${result.localFrameRate} /r.rate: ${result.remoteFrameRate} / Health: ${result.rating}`
        console.log(stat)
      }
    }

You can get the quality data by implementing *onStat (),* one of the
methods of *listener,* which you input as an input argument when you
create a *Remon* object. The *result.rating* data obtained from the
above *result* is the integrated call quality information according to
the network situation. {% endtab%}

{% tab title="Android" %}

      @Override
      public void onStatReport(RemonStatReport report) {
          Logger.i(TAG, "report: " + report.getHealthRating());
          String stat = "health:" + report.getHealthRating().getLevel() + "\n";
      }

{% endtab %}

{% tab title="iOS" %}

    let remonCall = RemonCall()
    remoCall.onRemonStatReport{ (stat) in 
        let rating = stat.getRttRating()
        // Do something
    }

{% endtab %} {% endtabs %}
