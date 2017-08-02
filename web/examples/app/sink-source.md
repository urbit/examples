# `:sink` & `:source`

Source:

* `/app/sink.hoon`
* `/app/source.hoon`

`:dojo`:

    ~your-urbit:dojo/examples> |start %sink

    ~your-urbit:dojo/examples> |start %source

    ~your-urbit:dojo/examples> :sink %on

    ~your-urbit:dojo/examples> :source {insert any noun}

<br />    

These two apps demonstrate how to set up a subscription from one app to another. This can be two apps on the same urbit, or two apps between different urbits. This demo only needs one running urbit.

To run, start both apps from `:dojo`. Then, turn the subscription on (note this is not a general syntax for starting a subscription). Submit some input to `sink` on the path where `sink` is subscribed. You should see a printf from `sink.hoon` confirming it received the
subscription update.

Let's walk through what we did:

* when we poked `sink.hoon`, it received the noun `%on` with the `++poke-noun`
arm, setting our state to 'available'. `++poke-noun` then sends out a
subcription request to `source.hoon` on the path `/example-path`.

* `source.hoon` receives the subscription request with `++peer`. `%gall` then
sends confirmation to `++reap` in `sink.hoon`

* Then we poked `source.hoon` with a noun, which `source.hoon` parses with
`mar/noun.hoon`. `source.hoon` then receives this parsed data on its
`++poke-noun` arm.

* `++poke-noun` (in `source.hoon`) maps over the list of all clients subscribed
to the path `/example-path`, sending a `%diff %noun` to all of them.

* `sink.hoon` receives the update on the `++diff-noun`, and printfs the noun we
submitted.
