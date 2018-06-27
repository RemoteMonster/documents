Structure
=========

Overview
--------

It is very simple to use *RemoteMonster\'s SDK*. You only need to learn
how to use three classes.

Remon class
-----------

*Remon* performs all broadcasting and communication operations. This
*Remon* class is used in all the processes of initializing broadcasting,
communication status, opening a room, connecting to a room, and
terminating the service. It also performs additional functions such as
sending a message.

To create the *Remon* class, there should be two following
prerequisites. *Config* and *Observer*.

### Init

This is used for initializing an object. This connects to the
*RemoteMonster API* server. At the moment of connection, the
*RemoteMonster* server provides a disposable token for this *Remon*
object.

### Create, Join

This function is used for broadcasting. This is a command to create or
watch a broadcast. When creating a broadcast, the *Observer* callback
receives the actual unique *id* of the broadcast from *onCreate*. With
this *id* value, viewers can access the broadcast through the *Join*
method.

### Connect

This function is used for communication. This is a command to connect to
a channel or create a channel. It creates a channel if there is no
channel with the given name, and it connects to the channel if it
already exists. If there is no channel name, *RemoteMonster* generates
and returns a unique channel name.

### Close

Exit the room or destroy the room and do initialization.

### How to use

{% page-ref page="../common/livecast.md" %}

{% page-ref page="../common/untitled.md" %}

Config Class
------------

All necessary pre-configuration tasks are done through this *Config*
before initializing the *Remon* object. It is used to handle a variety
of tasks related to the authentication information (*Service Id*, and
*Key)*, media and network. Please refer to the following for the
details.

{% page-ref page="../common/config.md" %}

Observer Class
--------------

*Observer* is a class for receiving *Callback* messages if the *Remon*
class is intended to issue commands. By using events received from the
*Observer*, more detailed communication effects and active services can
be implemented. Please refer to the following for the details.

{% page-ref page="../common/callbacks.md" %}
