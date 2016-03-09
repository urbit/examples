# `/lead`

This app is a basic leaderboard that allows you to add contestants, and to increment their scores by one.

## Overview

Follow the instructions in the root `readme.md` to get the app up and running in a fake pier. Submit a few results through the frontend. Try opening another tab and watch multiple clients stay in sync.

All of our example frontend code lives in `/web/pages/examples`. The logic is mostly in `/web/pages/examples/lead.js`, which is a simple [react](https://facebook.github.io/react/) app. We recommend using react when building webpages on top of urbit. You'll see why as you get familiar with how transacting data works. 

Let's briefly trace a request as it goes from your browser to our backend:

In lead.js, when you click 'Add', or when you increment a contestants score, it sends that json information--more specifically data with the mark of `json`--to the `++poke-json` arm in `app/examples/lead.hoon`, which then parses the information and saves the information. Since we updated our state, `++peek` is called automatically (this is a feature of `%gall`), which generates a list of moves to send to our subscribed clients with an updated state. On the frontend, this is received by the connection that we setup with `urb.subscribe`. The callback there passes the udpated state to react where our DOM diff is calculated automatically. 
