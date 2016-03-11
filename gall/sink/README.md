#`/sink` & `/source`

These two apps demonstrate how to set up a subscription from one app to another.

To run [in dojo]:

    |start %examples-sink

    |start %examples-source

Then, turn the subscription on (note this is not a general syntax for starting a subscription):

    :examples-sink %on

Finally, submit some input to `examples-sink` on the path where `sink` is subscribed:

    :examples-source {insert any noun}

You should see a printf from `sink.hoon` confirming it received the subscription update.

Let's walk through what we did:

- when we poked `sink.hoon`, it received the noun `%on` with the `++poke-noun` arm, setting our state to 'available'. `++poke-noun` then sends out a subcription request to `source.hoon` on the path `/the-path`.

- `source.hoon` receives the subscription request with `++peer`. `%gall` then sends confirmation to `++reap` in `sink.hoon`

- Then we poked `source.hoon` with a noun, which `source.hoon` parses with `mar/noun.hoon`. `source.hoon` then receives this parsed data on its `++poke-noun` arm. 

- `++poke-noun` (in `source.hoon`) maps over the list of all clients subscribed to the path `/the-path`, sending a `%diff %noun` to all of them.

- `sink.hoon` receives the update on the `++diff-noun`, and printfs the noun we submitted.
