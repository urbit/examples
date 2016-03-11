`/click`

This app demonstrates how to send data from the browser to an urbit app.

To run [in dojo]:

    |start %examples-click

Then, in the browser:

    http://localhost:8080/~~/pages/examples/click

Click the button to increment the number stored in our state.  Even better: open another tab and watch the increments stay in sync.

Let's walk through what happens on each click:

- `/web/pages/examples/click.js` catches the click event and uses `urb.send` to send JSON to your urbit.

- Our data is sent as an `examples-click-clique` mark, which is parsed by `/mar/examples/click/clique.hoon`.

- Our parsed JSON is received in the `++poke-examples-click-clique` arm of `/app/examples/click.hoon` which increments our state and then sends the updated state to all connected clients.

