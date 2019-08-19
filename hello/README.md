# hello

A Landscape tile that sends a hello with some JSON back to your Dojo. Copy /app into your ship, `|commit %home` and `|start %hello` to see your new tile in Landscape.

## Using Landscape

You'll find Landscape running on http://localhost:PORT, PORT being 80, 8080, 8081, 
and so on, depending on your operating system's free ports; see your ship's boot message
for a notification as to what port HTTP is available on. If you haven't used
Landscape before, you'll need to enter `+code` on your ship to get the password
to authenticate yourself with on the Landscape interface. 
See also the [Urbit documentation](https://urbit.org/docs/getting-started/booting-a-ship/#using-landscape)
for more information.

## How 'hello' works

The application is started with `hello.hoon` in the [/app](/app) folder on your ship.
It tells eyre, the HTTP vane of Arvo, where it's located, and the `launch` and `modulo`
applications to subscribe to it and present it as a tile in Landscape. Landscape provides
access to your ship with an `api` window object.

The 'hello' [tile.js](tile/tile.js), mounted in Landscape as part of the application, 
uses that api window object to poke the running hello application, which, when it receives
a poke with JSON, prints it to the Dojo. 

For the poke handler's code, see [here](app/hello.hoon#L54).

## Playing with 'hello'

Landscape tiles also use the [React](https://reactjs.org/) framework and require 
compilation if you want to change them -- find their source in the /src folder, 
`npm install` their dependencies, change the Urbit ship location in the `.urbitrc` file to your ship location, and `npm run serve`.