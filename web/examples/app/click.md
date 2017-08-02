# `:click`

Source:

* `/app/click.hoon`
* `/mar/click/click.hoon`
* `/mar/click/clicks.hoon`
* `/sur/click.hoon`
* `/web/pages/click.hoon`

`:dojo`:

    ~your-urbit:dojo/examples> |start %click

Web:

    http://localhost:8443/~~/pages/click

<br />    

This app demonstrates how to send data from the browser to an urbit app.

Start the app and visit the web page to click the button to increment the number stored in our state. Even better, open another tab and watch the click count stay in sync.

Let's walk through what happens on each click:

* `/web/pages/click/click.js` catches the click event and uses `urb.send` to
send JSON to your urbit.

* Our data is sent as an `click-click` mark, which is parsed by
`/mar/click/click.hoon`.

* Our parsed JSON is received in the `++poke-click-click` arm of
`/app/click.hoon` which increments our state and then sends the
updated state to all connected clients.
