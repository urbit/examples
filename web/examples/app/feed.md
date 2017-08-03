# `:feed`

Source:

* `/web/pages/feed/init.hoon`
* `/web/pages/feed/init.js`
* `/web/pages/feed.hoon`
* `/web/pages/feed/feed.js`
* `/web/pages/feed/feed.css`

Web:

    http://localhost:8443/~~/pages/feed/init

<br />

`:feed` is a vanilla microblogging web UI built using `:talk` as the backend. This basic UI works well to highlight the core functionality of our current `urb.js` and `:talk` web API's.

`:feed` works by first creating a `%feed` `:talk` station, then loading that station through the `:feed` web UI which will present a chronological feed of public `:talk` posts by other ships. When you subscribe and unsubscribe to other ships' `%public` `:talk` stations (which boot with all urbits by default) through the web UI, you add those to your `%feed` station's list of subscriptions. New posts will push to the top of your feed in real time.

The goal of this demo was to show that building a Twitter replacement actually isn't that hard at all; and it can be done almost entirely on the frontend. As shown, you don't even have to use React/Redux. But that's probably the way to go if you want to build the real thing.

Anyways, enough *:talk*.

You will need to have at least two running urbits for this demo. No need to `|start` any apps as `:feed` uses `:talk` which starts automatically on boot.

On your first urbit (the only one where you'll be accessing the web UI), you will need to initialize your `%feed` station. Do this by visiting in the browser:

    http://localhost:8443/~~/pages/feed/init

It might take a few seconds. When the page finishes loading, a button to load your feed will appear. Click it to get redirected to your feed, which brings you to:

    http://localhost:8443/~~/pages/feed

Next, fetch your second urbit's feed by typing the name of the second urbit into the `Fetch` text box (don't forget `@p` syntax: prefix the name/address with a `~`!).

The feed will be empty to start. On your second urbit, post a `%public` message by switching in its console from its `:dojo` prompt to its `:talk` prompt. This is done by pressing `Ctrl-X` on your keyboard in the terminal window of your second urbit:

    ~your-urbit-2:dojo/examples>
    ~your-urbit-2:talk[]

Next, switch the second urbit's `:talk` audience to its `%public` station with the following `:talk` command:


    ~your-urbit-2:talk[] ;%public

    --------------| ;%public

    ~your-urbit-2:talk[%public]

Type a public message and hit `Enter` on your keyboard to send it:

    ~your-urbit-2:talk[%public] is this thing on?

    ------------[0]
      your-urbit-2; is this thing on?

If you look back in the feed UI of your first urbit that you're viewing in the browser, the post should have loaded automatically.

Click `Subscribe` to subscribe to your second urbit's `%public` station, which will reload the page confirming you've subscribed. Then click the `Home` button to return to your home feed. Your second urbit's post should appear on the page.

Post a public message from your second urbit again:

    ~your-urbit-2:talk[%public] i guess this thing does work.

      your-urbit-2; i guess this thing does work.

The post should push to your first urbit's web feed in real time.

The plan is to turn this example into a complete written-up tutorial, but we wanted to share the code with everyone first.  For the time being, we're happy to answer questions in `:talk` or by a [Github issue](https://github.com/urbit/examples/issues).
