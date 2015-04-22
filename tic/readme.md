# tic
This app allows two players to play tic-tac-toe on the same computer, recording the results as well as play-by-play history of each game. It highlights many of the same concepts as foos, but adds complexity.

##how it works and what to pay attention to
Similar to foos, this app receives data with a JSON mark on its `++poke-json` arm. It then *reparses* the `++json` to a hoon representation of a tic-tac-toe move.

After updating the board and checking for a victory or tie, it updates the client with the updated board or a notification that the game has concluded along with a blank board. However, unlike foos, tic uses `++peer` instead of `++peek` to send these updates.

`++peer` is activated when the app receives a subscriber on a certain path for the first time, at which point it does two things: 1. sends the new subscriber whatever data `++peer` returns, which in this case is the state of the board; and 2. adds the subscriber to the app's sup.hid, which keeps track of all of its subscribers.

After the initial `++peer`, tic sends its updates manually using `++spam` (see lines 167, 175), which maps over `sup.hid` and sends updates to all the subscribers.

