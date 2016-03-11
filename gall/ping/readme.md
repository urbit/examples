`/ping`

This application demonstrates how to send typed information to an app on another ship by poking it with a 'mark.'

To run [from dojo], start the app on both urbits:

    |start examples-ping
    
    |start examples-ping

Then, from `~zod`'s dojo:

`:ping &examples-ping-message [~lec 'message-here']`

`~lec` should receive:

`[%receiving 'message here']`

Let's briefly step through what we just did:

- We poked `ping.hoon` with data of the `examples-ping-message` mark, which is simply a ship address and a text `@t` atom. 

- `mar/examples/ping/message.hoon` parses the data, and then passes it along to `++poke-examples-ping-message`.

- `++poke-examples-ping-message` then sends a move containing the text atom we submitted to the corresponding `/ping` app on the urbit we specified (`~lec`).

- `~lec`'s `mar/examples/atom.hoon` parses the atom, and passes it along to`++poke-atom`, which prints out the output above.

