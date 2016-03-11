# `/pong`

This app demonstrates how to poke an app with an urbit (planet/star/galaxy etc) name. 

From `~zod`'s dojo:

`:examples-pong &urbit ~lec`

`~lec` should display:

`[%receiving 'howdy']`

Let's briefly walk through what we just did:

- We sent typed data of the `urbit` (address) mark to `~zod`'s `/pong.hoon`, which sends a move with the message 'howdy'to `~lec`.

- `~lec` receives this data on the `++poke-atom` arm, which simply prints the message out.





