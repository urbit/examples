# urbit sample-apps

This repo contains simple programs meant to show off how to build simple things in urbit. Our approach here is casual. We expect that you'll use the docs that came with your urbit as supporting material.

Each folder has its own `readme.md` that explains what the program highlights. Since each program builds on the previous one it is recommended that you read them in order. It is by no means essential to do this, but the readmes build on one another.

## How to use the repo

Soon we'll host these examples inside of urbit and all development will happen on your main ship. For the time being, these instructions should work:

1. Clone this repo outside of your pier somewhere.
2. We recommend doing development on a fake network. Start a fake `~zod` with `bin/vere -FI ~zod -c $PIER`. 
3. Each program's subdirectories indicate where the files need to be copied. For example: put `sample-apps/foos/app/foos` in `/$URB_DIR/$PIER/$SHIP-NAME/main/app/foos`. 
4. By convention the program's main page is accessed from its `%ford` page. For example: `http://localhost:8081/main/pub/foos/fab` is where you'll find the `foos` program if you copied everything in correctly. Your port number may vary. It is printed out when you start your pier.

## Feedback and contributions

We're really curious to hear about your experience using this stuff. All questions and comments are more than welcome. You can contact me at henry@tlon.io, or on `:talk` as `~sivtyv-barnel`.

## Contents

### `/foos`
Keeps track of foosball fixtures and standings

Topics: json parsing & reparsing, talking to subscribers in an elementary way using `++peek`, single-level storage.

### `/tic`
Allows two people to play tic-tac-toe

Topics: talking to subscribers in a more sophisticated way using `++peer`, more complex backend logic.

### `/mail`
Send simple email-like messages to each other

Topics: sending typed data over the network.









