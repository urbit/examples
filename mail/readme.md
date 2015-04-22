# `/mail`
This program allows a ship to send an email-like message to another ship over the network.

## Overview

Follow the instructions in the root `readme.md` to get the app up and running in a fake pier. We're going to also need to move the contents of `/mar` and `/sur` into their respective places. In this case it is useful to set up two fake piers, since we're going to send messages between them. Try setting up a `~zod` and `~del`. Visit the frontend as usual, and you should be able to send a message to the other. 

The data flow from frontend to backend is similar to the other examples. There are two major difference here. We send our JSON from the browser with an explicit mark, which causes it to be parsed by our `/sur/message/door.hook` such that we are delivered a well-typed `++message` as defined in `/mar/message/gate.hook`. Also, `/mail` sends typed messages between ships over the network using the `%pass` move in `app/mail/core.hook`. These ship-to-ship messages are also caught in our `++poke-message` arm on the receiving end. 

This is also the first time we've defined a data type for our system calls: `++move`. Although there is no formal definition for `++move` in `%zuse` or `%gall`, is is convention to do so in more complicated apps.

Another thing to take note of is `++pour`, which is the arm that receives the response from messages that we `%pass`. In this case the only response we receive is positive acknowledgement, a `%nice`, which we acknowledge with another `%nice`. It can be a bit confusing to think about this, since this same program will run on separate ships. 

Here's what the message flow looks like:

```

Ship A
---
main.js sends JSON with type 'message'  => 
door.hook parses ++json to ++message    =>
core.hook receives in ++poke-message, produces a %pass move  =>

Ship B
--
core.hook receieves in ++poke-message, updates state, sends a %nice =>

Ship A
--
core.hook receives in ++pour, sends a %nice on the original bone to the browser

```
