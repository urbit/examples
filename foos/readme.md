# `/foos`
This app records foosball scores (one wins by scoring 10) into its state and then uses them to calculate standings on the frontend. 

## Overview

Follow the instructions in the root `readme.md` to get the app up and running in a fake pier. Submit a few results through the frontend. Try opening another tab and watch multiple clients stay in sync.

All of our frontend code lives in `/pub/foos/`. The logic is mostly in `/pub/foos/src/main.js`, which is a simple [react](https://facebook.github.io/react/) app. We recommend using react when building webpages on top of urbit. You'll see why as you get familiar with how transacting data works. 

Let's briefly trace a request as it goes from your browser to our backend:

In `main.js`, when you click 'submit' we end up in the `AddFixture.submit` method. If everything validates properly we call `urb.send` with the data from the form. This is received in our `core.hook` file by the `++poke-json` arm. Here we reparse the json into a `++result` that we store in our state. Since we update our state, `++peek` is called automatically (this is a feature of `%gall`), which generates a list of moves to send to our subscribed clients with an updated state. On the frontend this is received by the connection we setup with `urb.subscribe`. The callback there passes the udpated state to react where our DOM diff is calculated automatically.
