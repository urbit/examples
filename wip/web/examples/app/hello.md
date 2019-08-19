# `:hello`

Source:

-   `/app/hello.hoon`
-   `/mar/hello/world.hoon`
-   `/sur/hello.hoon`
-   `/web/pages/hello.hoon`
-   `/web/pages/hello/hello.js`
-   `/web/pages/hello/hello.css`

`:dojo`:

    ~your-urbit:dojo/examples> |start %hello

Web:

    http://localhost:8443/~~/pages/hello

<br />

This app sends a `Hello, world!` from the app's state to the browser. Then upon
clicking a web button, the web app pokes the `:hello` app which prints a
`Hello, world!` in the `:dojo`.

Let's walk through what happens in a more detailed way:

-   `/web/pages/hello/hello.js` sends an `urb.bind` request to app `:hello` at
    the `/web` path on page load

-   `:hello` sends the web page (via `%eyre`) the `Hello, world!` stored in its
    app state

-   The web pages loads the `Hello, world!` in a heading

-   Upon clicking the `Poke me!` button, `hello.js` catches the click event and
    uses `urb.send` to send JSON to your urbit containing a `'hello'`

-   Our data is sent as a `hello-world` mark, so the JSON is parsed by
    `/mar/hello/world.hoon` and converted to a `cord`

-   Our parsed JSON-to-cord is received in the `++poke-hello-world` arm of
    `/app/hello.hoon` which printf's the `Hello, world!` and produces no
    additional moves (events) or new app state
