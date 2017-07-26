# `:feed`

`:feed` is a vanilla microblogging web UI built using `:talk` as the backend. This basic UI works well to highlight the core functionality of our current `urb.js` and `:talk` web API's.

`:feed` works by first creating a `%feed` `:talk` station, then loading that station through the `:feed` web UI which will present a chronological feed of public `:talk` posts by other ships. When you subscribe and unsubscribe to other ships' `%public` `:talk` stations (which boot with all urbits by default) through the web UI, you add those to your `%feed` station's list of subscriptions. New posts will push to the top of your feed in real time.

The goal of this demo was to show that building a Twitter replacement actually isn't that hard at all; and it can be done almost entirely on the frontend. As shown, you don't even have to use React/Redux. But that's probably the way to go if you want to build the real thing.

Anyways, enough *:talk*.

First you'll need to initialize your `%feed` station. Do this by visiting in the browser:

    http://localhost:8443/~~/pages/feed/init

When initialization is complete, the page will have finished loading and a button to load your feed will appear. Click it to get redirected to your feed, which brings you to:

    http://localhost:8443/~~/pages/feed

You can load any ship's `%public` station via the `Fetch` box at the top of the page, post a `%public` message and scroll through your feed when you're at your home page, and head back home whenever you're on another ship's page by clicking the `Home` button at the top of another ship's `%public` feed.

The plan is to turn this example into a complete written-up tutorial, but we wanted to share the code with everyone first.  For the time being, we're happy to answer questions in `:talk` or by a Github issue.
