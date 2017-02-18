`/click`

This app demonstrates how to send data from the browser to an urbit app.

First, make sure you're logged into your ship (both
[*comets*](https://urbit.org/docs/byte/0)
and [fake ~zods](https://github.com/urbit/urbit/blob/master/CONTRIBUTING.md)
work great for these kinds of examples). You can do this by visiting, in the
browser:

    http://localhost:8443/

> Note: If you have multiple ships running, your second ship will run on port
8444, your third on 8445, etc. We say these are "secure", as our crypto hasn't
been audited yet. You can also just use http://localhost:8080/ if it's easier
as you're just accessing your Web UI's on localhost.

and clicking the `Log in` button towards the top right. You'll be presented with
a prompt to enter a password, which you can compute by entering a +code command
in the `:dojo`.

To run in `:dojo`:

    |start %examples-click

Then, in the browser:

    http://localhost:8443/~~/pages/examples/click

Click the button to increment the number stored in our state.  Even better: open another tab and watch the increments stay in sync.

Let's walk through what happens on each click:

- `/web/pages/examples/click.js` catches the click event and uses `urb.send` to send JSON to your urbit.

- Our data is sent as an `examples-click-clique` mark, which is parsed by `/mar/examples/click/clique.hoon`.

- Our parsed JSON is received in the `++poke-examples-click-clique` arm of `/app/examples/click.hoon` which increments our state and then sends the updated state to all connected clients.
