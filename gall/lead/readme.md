# `/lead`

This app is a basic leaderboard that allows you to add contestantsand increment their scores.

To run [in dojo]:

    |start %examples-leaderboard

Then, in the browser:

    http://localhost:8080/~~/pages/examples/lead

Let's briefly trace what happens on each click:

- When you click 'Add', or when you increment a contestants score, `web/pages/examples/lead.hoon` catches the event and sends that json information--more specifically data with the mark of `json`--to `lead.hoon`. 

- The `json` data is parsed by `/mar/json.hoon`, and is then passed to `++poke-json` (in `lead.hoon`).

- `++poke-json` reparses the `++json` to hoon data structures, and updates the app's state to include the latest result.

- Finally, `++poke-json` passes the updated state to `++deliver`, which sends the new state back to `foos.js`, whose callback passes it to react, where our DOM diff is calculated automatically.
