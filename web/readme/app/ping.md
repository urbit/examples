# `:ping`

This application demonstrates how to send typed information to an app on
another ship by poking it with a 'mark.'

To run from `:dojo`, start the app on both urbits:

```
>~zod:dojo/examples |start %ping

>~nec:dojo/examples |start %ping
```

Then, from `~zod`'s dojo:

```
> :ping &ping-message [~nec 'Hey, neighbor!']
```

`~nec` should receive:

```
'Message received!'
[%message 'Hey, neighbor!']
```

Let's briefly step through what we just did:

- We poked `ping.hoon` with data of the `ping-message` mark, which is
simply a ship address and a text `@t` atom.

- `mar/ping/message.hoon` parses the data, and then passes it along to
`++poke-ping-message`.

- `++poke-ping-message` then sends a move containing the text atom we
submitted to the corresponding `/ping` app on the urbit we specified (`~nec`).

- `~nec`'s `mar/atom.hoon` parses the atom, and passes it along
to`++poke-atom`, which prints out the output above.
