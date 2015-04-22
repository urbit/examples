# urbit sample apps

This repo contains simple applications meant to familiarize you with the different aspects of the system. Each app has its own readme that will explain what each app is intended to highlight. As each app builds in some way on the previous one, it is recommended that you read them in order. While it is by no means essential to do this, the readmes are written under the assumption that you are doing so.

## How to use the repo

Some day these will all exist on urbit, but for the time being clone this repo outside of your pier somewhere and copy the files in as explained below. Since it's possible to corrupt your pier while doing dev it can be a good idea to use a fake ship. You can start a fake zod by typing `bin/vere -c -FI ~zod PIERNAME` while in your urbit folder. Check out the `dev` guide in `doc` for more detailed instructions on running a fake ship. 

For the most part each folder in this repo contains folders indicating the path relative to the `/main` desk on your pier. For example, `foos/app/foos/core.hook` will end up as `/$URB_DIR/$PIER/$SHIP-NAME/main/app/foos/core.hook`.

All of the apps currently in this repo are accessed via their %ford pages, which are hymn.hook files generally found in a /fab directory. To access a %ford page, go to `http://localhost:{port}/main/path/to/page`, where `port` is the port number shown upon booting into urbit. For example, `/=main=/pub/foos/fab/hymn/hook` on an http 8444 pier would serve `localhost:8444/main/pub/foos/fab`.

## Feedback/Contributions

As you play around, please let me know if you have any questions and/or comments. You can contact me at henry@tlon.io, or on chat (usually ~sivtyv-barnel). If interested in contributing by building a similar app that showcases a different part of the system, please get in touch!

## Contents

`foos`: keeps track of foosball fixtures and standings.
most basic app in the repo. clearly displays the framework that all %gall apps must follow. also shows the type of react frontend that we recommend.

covers: json parsing & reparsing, talking to subscribers in an elementary way using ++peek, how to store data using our single-level store.

`tic-tac-toe`: allows two users to play tic-tac-toe on one screen. records play-by-play of each game in state.
similar to foos, but more complex.

covers: talking to subscribers in a more sophisticated way using ++peer, more complex backend logic

`mail`:allows ships to send simple email-like messages to each other. 

covers: sending typed data over the network









