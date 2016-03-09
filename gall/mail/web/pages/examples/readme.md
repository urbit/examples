# `/mail`
This program allows a ship to send an email-like message to another ship over the network.

## Overview

Follow the instructions in the root `readme.md` to get the app up and running in a fake pier. In this case it is useful to set up two fake piers, since we're going to send messages between them. Try setting up a `~zod` and `~del`. Visit the frontend as usual, and you should be able to send a message to the other. Don't forget to prefix the fax galaxy name with a `~`.

The data flow from frontend to backend is similar to the other examples, but there are two major differences. We send our JSON from the browser with an explicit mark--`++message`--which causes it to be parsed by our `/sur/examples/message.hoon` such that we are delivered a well-typed `++message` as defined in `/mar/examples/message.hoon`. These typed ship-to-ship messages are also caught in our `++poke-message` arm on the receiving end. 

This is also the first time we've defined a data type for our system calls: `++move`. Although there is no formal definition for `++move` in `%zuse` or `%gall`, is is convention to do so in more complicated apps.

Here's what the message flow looks like:

```

Ship A
---
mail.js sends JSON with type 'message'  => 
/sur/examples/message.hoon parses ++json to ++message    =>
app/examples/mail.hoon receives in ++poke-message, and sends a move with the desired message to ship b. =>

Ship B
--
mail.hoon receieves move in ++poke-message, updates state, and sends new state to client =>

```
