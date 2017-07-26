# `:lead`

This app is a basic leaderboard that allows you to add contestants and
increment their scores.

To run in `:dojo`:

    |start %lead

Then, in the browser:

    http://localhost:8443/~~/pages/lead

Let's briefly trace what happens on each click:

- When you click 'Add', or when you increment a contestants score,
`web/pages/lead.hoon` catches the event and sends that json
information -- more specifically data with the mark of `json`--to `app/lead.hoon`.

- The `json` data is parsed by `mar/json.hoon`, and is then passed to
`++poke-json` (in `app/lead.hoon`).

- `++poke-json` reparses the `++json` to Hoon data structures, and updates the
app's state to include the latest result.

- Finally, `++poke-json` passes the updated state to `++deliver`, which sends
the new state back to `lead.js`, whose callback passes it to React, where our
DOM diff is calculated automatically.
