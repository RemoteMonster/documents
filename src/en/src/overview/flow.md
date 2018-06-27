Flow
====

Overview
--------

There is a common trend in the overall use of *RemoteMonster*. Please
refer to the following for the details

Livecast
--------

The broadcasting service is divided into the following cases: simply
creating a room to transmit a broadcast and connecting to a room to
receive a broadcast. It has the following flow.

-   Caster: the party transmitting a broadcast

-   Watcher: the party watching the broadcast

+-------------+-------------+-------------+-------------+-------------+
|             | Initializat | Channel     | Channel     | Termination |
|             | ion         | Creation    |             |             |
|             |             |             | Connection  |             |
+=============+=============+=============+=============+=============+
| Caster      | ready       | `create()`  | \-          | `close()`,  |
| Event       | RemoteMonst |             |             | disconnect  |
|             | er          |             |             |             |
+-------------+-------------+-------------+-------------+-------------+
| Caster      | `onInit`    | `onCreate`  | \-          | `onClose`   |
| Callback    |             |             |             |             |
+-------------+-------------+-------------+-------------+-------------+
| Watcher     | ready       | \-          | `join('chan | `clo``se()` |
| Event       | RemoteMonst |             | nelId')`    | ,           |
|             | er          |             |             | disconnect  |
+-------------+-------------+-------------+-------------+-------------+
| Watcher     | `onInit`    | \-          | `onJoin`    | `onClose`   |
| Callback    |             |             |             |             |
+-------------+-------------+-------------+-------------+-------------+

Communication
-------------

The communication service is divided into the following acts: requesting
a call and receiving a call. The calling party creates a channel and
waits for the other party. At this time, the other party is connected to
the same channel through the obtained *chid*, and mutual communication
is started.

-   Caller : the party making a communication request

-   Callee : the party responding to the communication request

+-------------+-------------+-------------+-------------+-------------+
|             | Initializat | Channel     | Channel     | Call        |
|             | ion         | Creation    |             |             |
|             |             |             | Connection  | Initiation  |
+=============+=============+=============+=============+=============+
| Caller      | ready       | `connect()` | Wait callee | Caller,     |
| Event       | RemoteMonst |             |             | Callee      |
|             | er          |             |             | Connected   |
+-------------+-------------+-------------+-------------+-------------+
| Caller      | `onInit`    | `onConnect` | \-          | `onComplete |
| Callback    |             |             |             | `           |
+-------------+-------------+-------------+-------------+-------------+
| Callee      | ready       | \-          | `connect('c | Caller,     |
| Event       | RemoteMonst |             | hannelId')` | Callee      |
|             | er          |             |             | Connected   |
+-------------+-------------+-------------+-------------+-------------+
| Callee      | `onInit`    | \-          | `onConnect` | `onComplete |
| Callback    |             |             |             | `           |
+-------------+-------------+-------------+-------------+-------------+
