`/pong`

This app demonstrates how to poke an app with an urbit (planet/star/galaxy etc)
name.

To run from `:dojo`, start the app on both ships:

    |start examples-pong

    |start examples-pong

Then, from `~zod`'s `:dojo`:

`:examples-pong &urbit ~lec`

`~lec` should display:

`[%receiving 'howdy']`

Let's briefly walk through what we just did:

- We sent data of the `urbit` mark from dojo to the sender `~zod`'s `pong.hoon`
app.

- `mar/urbit` parses the data, and passes it to `++poke-urbit`

- `++poke-urbit` then sends a move with the message 'howdy'to `~lec`.

- `~lec` receives this data with its own `pong.hoon` app. `pong.hoon` parses it
with `mar/atom`, and then receives it on the `++poke-atom` arm, which simply
prints the message out.
