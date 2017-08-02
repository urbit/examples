# `:up`

Source:

* `/app/up.hoon`

`:dojo`:

    ~your-urbit:dojo/examples> |start %up

    ~your-urbit:dojo/examples> :up &atom 'https://www.example.com'

    ~your-urbit:dojo/examples> :up &atom %on

<br />    

This app continually pings a server at the 'target' URL.

Start the app from `:dojo`, set the URL you want to ping and set your 'pinger' to `%on`. You should receive either:

    [%all-is-well 200]

or

    [%we-have-a-problem {status-code}]

Then, to turn the 'pinger' off:

    ~your-urbit:dojo/examples> :up &atom %off

Let's walk through what happened, step by step:

* The first URL `:dojo` nouns was type-checked by `mar/atom.hoon` and converted into an atom.

* The validated atom was then passed to the `++poke-atom` arm in the `up.hoon` app.

* `++poke-atom` saves the text url as `target` in the app state.

* We poked `up.hoon` again with the `%on` atom; `%on` also got type-checked and converted to an atom via `mar/atom.hoon` and got passed to `++poke-atom`. This time with the text `on`, this pinged the target url with an http request.

* `++sigh-httr` receives the http response and displays the result. It then calls `++wake-timer`, telling it to wait 10 seconds before pinging the target url again. This process repeats until you poke the app again with `off`.
