# `:pong`

This app demonstrates how to poke an app with an urbit (planet/star/galaxy etc)
name.

To run from `:dojo`, start the app on both ships:

```
>~zod:dojo/examples |start %pong

>~nec:dojo/examples |start %pong
```

Then, from `~zod`'s dojo:

```
> :pong &urbit ~nec
```

`~nec` should display:

```
'Incoming pong!'
`[%received 'Pong']`
```

Let's briefly walk through what we just did:

- We sent data of the `urbit` mark from dojo to the sender `~zod`'s `pong.hoon`
app.

- `mar/urbit` parses the data, and passes it to `++poke-urbit`

- `++poke-urbit` then sends a move with the message 'Pong' to `~nec`.

- `~nec` receives this data with its own `pong.hoon` app. `pong.hoon` parses it
with `mar/atom`, and then receives it on the `++poke-atom` arm, which simply
prints the message out.
