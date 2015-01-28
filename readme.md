# urbit sample apps

This is a repo for the open source community to share simple apps and programs that are designed primarily to familiarize people with the different aspects of the system. 

Pull requests are welcome and encouraged. Please try your best to adhere to the stylistic conventions used in the apps already here. 

## How to use the repo

Some day these will all exist on urbit, but for the time being clone this repo outside of your pier somewhere and copy the files in as explained below. Since it's possible to corrupt your pier while doing dev it can be a good idea to use a fake ship. Check out the `dev` guide in `urbit-doc` for instructions on running a fake ship.

For the most part each folder in this repo contains folders indicating the path relative to the `/main` desk on your pier. For example, `todo/app/todo/core.hook` will end up as `/$URB_DIR/$PIER/$SHIP-NAME/main/app/todo/core.hook`. The exception to this is the `twit` app, whose folder should be placed directly in /main/app/twit, and can be accessed at `http://localhost:{port}/twit`.

If an app is just meant to be run as a script it'll be named something descriptive like `euler.hoon` and can be copied directly into the `/try` desk. For example, you would copy `math/euler.hoon` into `try/euler.hoon` and execute it with `~zod/try=> ^/%/euler`.

Some apps are accessed via %ford pages, which are hymn.hook files generally found in a /fab directory. To access a %ford page, go to `http://localhost:{port}/gen/desk/path/to/page`, where `port` is the port number shown upon booting into urbit. For example, `/=main=/pub/todo/fab/hymn.hook` would be served. For example, `/=main=/pub/todo/fab/hymn/hook` on an http 8.444 pier would serve `localhost:8444/gen/main/pub/todo/fab`.

## Feedback

As you play around, please let me know if you find any part of the system particularly difficult to understand so that I can both help you out and look to improve documentation in those areas. You can contact me at henry@tlon.is, or on chat (usually ~sivtyv-barnel). Also, don't hesitate to ask questions on :chat.

## Contents

`blazon`
`%gall` app that displays the profile information of a neighbor ship.

`blog`
simple blogging platform served by `%ford`.

`count`
`%gall` app that keeps track of the number of times it has been `++peer`ed (loaded).

`lead`
`%gall` app that keeps track of a leaderboard.

`helo`
`%gall` app that allows you to send a single message to another ship on the network.

`math`
Contains a few scripts that each solve one of the project euler problems.

`stat`
`%gall` app that allows you to post statuses.

`strings`
Scripts that perform string manipulations.

`timer`
`%gall` app that uses the `%time` vane to "ding" the terminal after a specified amount of time.

`todo`
`%gall` app that keeps track of a todo list.

`write`
`%gall` app that allows you to save multiple line input from the shell to a file in `%clay` upon exit.









