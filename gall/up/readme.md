# `/up`

This app continually pings a server at the 'target' URL, returning `[%all-is-well 200]` or  `[%we-have-a-problem {code}]`

# Overview

Refer to the root readme to set up a fake galaxy and start the app.

To set a target url, poke the app with a text atom (technically data of the atom mark) specifying a url: 

`www.example.com`

You should see:

`>=`, communicating success.

Then, turn the 'pinger' on:

`:examples-up &atom 'on'`

This data of the atom mark is received on the `++poke-atom` arm, which calls the `++wake-timer` arm, telling it to send a basic http request to the submitted url after 10 seconds:

`[%all-is-well 200]`

The `++sigh-httr` then receives the http response--data of the `httr` mark--parses it, and then calls the `++wake-timer` arm and tells it to wait 10 seconds before repinging the same url.

To turn off the 'pinger':

`:examples-up &atom 'on'`


