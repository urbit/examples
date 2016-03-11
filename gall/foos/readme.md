# `/foos`
This app records foosball scores (one wins by scoring 10) into its state. It then sends the updated state back to frontend, which then calculates and displays the standings.

To run [in dojo]:

    |start %examples-click

Then, in the browser:

    http://localhost:8080/~~/pages/examples/click

Fill in a valid result (each name must be a string, each score must be between 0-10, and the winner must have 10). You can open another tab and watch the standings remain in sync.

Let's walk through what happens when a valid result is submitted:

- `web/pages/examples/foos.js` catches the click event and checks that the data is valid. If it is, `foos.js` uses `urb.send` to send JSON to your urbit.

- Our data is sent as the hoon mark `json`, which is parsed by /mar/json.hoon

- Our parsed JSON is received by the `++poke-json` arm of `app/examples/foos.hoon`, which updates our state with the latest result and then `spam`s the update all connected clients.

In `foos.js`, when you click 'submit' we end up in the `AddFixture.submit` method. If everything validates properly we call `urb.send` with the data from the form. This is received in our `app/examples/foos.hoon` file by the `++poke-json` arm. Here we reparse the json into a `++result` that we store in our state. Since we update our state, `++peek` is called automatically (this is a feature of `%gall`), which generates a list of moves to send to our subscribed clients with an updated state. On the frontend this is received by the connection we setup with `urb.subscribe`. The callback there passes the udpated state to react where our DOM diff is calculated automatically.
