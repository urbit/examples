---
title: Applications
---

# Applications

`%gall` is the Urbit application driver.

Apps live under `/app` in a `%clay` desk. `%gall` apps hold state, respond to subscription requests and synchronizes state across ships.  

First apps need to be started, then you can "poke" their arms from either the `:dojo` or from the web.

Start an example app from your `:dojo` like this:

    ~your-urbit:dojo/examples> |start %name

and poke its `++poke-mark-name` arm like this:

    ~your-urbit:dojo/examples> :name &mark-name {insert noun of mark &mark-name}

where the mark is pointing to a mark source file in `/mar`. Some of these example apps use *structures* too, or shared molds stored in files in `/sur`. To understand how these work better, check out their pages:

* [Marks](/~~/examples/mar)
* [Structures](/~~/examples/sur)

In the case that the app has a web interface, its web UI will be served at the URL:

    http://localhost:8443/~~/pages/name

Visiting that page will subscribe, or `peer`, to the `%gall` app at the specified web path (in the arm `++peer-web-path-name`). Then, using the interface will send typed pokes or peers of the specified mark types through our `urb.js` web API.

Each individual app has its own set of instructions in `/examples/app/{app name}`. Click one below to get started!

<list>
