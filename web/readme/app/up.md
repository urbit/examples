# `:up`

This app continually pings a server at the 'target' URL, returning `[%all-is-well 200]` or  `[%we-have-a-problem {status-code}]`

To run from `:dojo`:

```
> |start %up
```

Then:

```
> :up &atom 'https://www.example.com'
> :up &atom 'on'
```

You should receive one of the two outputs listed in the first sentence above.

Then, to turn the 'pinger' off:

```
> :up &atom 'off'
```

Let's walk through what happened, step by step:

- We poked `up.hoon` with a text atom (data with a mark of atom)

- `mar/atom.hoon` parsed the atom and passed it to `++poke-atom` in `up.hoon`

- `++poke-atom` saves the text url as `target` in the app state.

- We poked `up.hoon` again, this time with the text `on`, which pings the target url with an http request.

- `++sigh-httr` receives the http response and displays the result. It then calls `++wake-timer`, telling it to wait 10 seconds before pinging the target url again. This process repeats until you poke the app again with `off`
