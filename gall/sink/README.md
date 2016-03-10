#`/sink` & `/source`

These two apps demonstrate how to set up a description between two different running applications.

#Overview 

Follow the instructions in the root `readme.md` to get the app up and running in a fake pier.

Subscribe `/sink` to `/source` by poking it with the noun `%on` (note, this syntax is specific to this app--it is not the generic way to set up subscriptions):

`:examples-sink %on`

You should receive this output:

`%subscribed`

In short, poking `/sink` with `%on` sends a `%pull` message to `/source`, which sets up a subscription on the `/subscription` path.

Then:

`:examples-source {insert any noun}`

You receive:

`[%argument 4]`

When we poke `/source` with any noun, it sends a `diff-noun` update to its subscriber, which naturally receives the updated on `++diff noun`, which prints out the update.


