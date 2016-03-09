`/pong`

This app demonstrates how to send an atom of text between two ships.

##Overview

Follow the instructions in the root `readme.md` to get the app running in two fake galaxies--for example, `~lec` and `~zod`.

Then, from `~zod`:

`:examples-pong &urbit ~lec`

`~lec` should display:

`[%receiving 'howdy']`

Let's briefly walk through what we just did: we sent typed data of the `urbit` (address) mark to `~zod`'s `/pong` app, which sends a move with data of the atom mark to `~lec`. `~lec` receives this data on the `++poke-atom` arm, which simply prints it out.


