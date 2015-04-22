# `/tic`
This program allows two players to play tic-tac-toe on the same computer, recording the results as well as play-by-play history of each game. 

## Overview

Follow the instructions in the root `readme.md` to get the app up and running in a fake pier. Submit a few results through the frontend. Try opening another tab and watch multiple clients stay in sync.

Our dataflow here is nearly the same as foos. See that readme for a basic overview. 

In our `++poke-json`, after updating the board and checking for a victory or tie, it updates the client with the updated board or a notification that the game has concluded along with a blank board. However, unlike foos, tic uses `++peer` instead of `++peek` to send these updates.

`++peer` is activated when the app receives a subscriber on a certain path for the first time, at which point it does two things: 

1. sends the new subscriber whatever data `++peer` returns, which in this case is the state of the board; and 
2. adds the subscriber to the app's sup.hid, which keeps track of all of its subscribers.

After the initial `++peer`, tic sends its updates manually using `++spam`, which uses the list of subscribers in `sup.hid` to send updates.

