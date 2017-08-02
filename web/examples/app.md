`%gall examples`

`%gall` is the urbit application driver.  `%gall` apps hold state, respond to
subscription requests and stuff like that.  

Assuming you have these files inside a running urbit pier, you'll need to
`|start` each app:

    |start %desk %app

Each of our examples lives inside of the `examples/` directory.  So, if you
want to start the `%click` app from your `%home` desk you'll run this:

    |start %examples-click

In the case that the app has a web interface its url will look something like:

    http://localhost:8443/~~/pages/examples/click

Each individual app has its own set of instructions.
