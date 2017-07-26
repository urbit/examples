# `:mesh`

`:mesh` is a simple distributed social network. The backend is a `%gall` app written from scratch, and the frontend uses `D3.js` to render a force-directed graph representing your `:mesh` network. `:mesh` is a reasonably complete demo that works well to highlight how `%gall` apps make distributed state synchronization a breeze for app developers, and how to serve reasonably complex app data to the web to render with the frontend UI library of your choice.

Contained in your `:mesh` app state are: your social network, containing your friends and friends-of-friends; and a HTML hex color that propagates to all of your friends and colors a node that represents you on your and all of your friends' graphs.

To try the demo, start the app in `:dojo` (or two ships' `:dojo`s, if you're running fake ships):

```
> |start %mesh
```

Then, visit in the browser:

```
http://localhost:8443/~~/pages/mesh
```

Your `:mesh` network will start empty. You can "friend" another ship by fetching them via the input box on the page. Note that the ship you try and fetch must be running the `:mesh` app themselves, or else no data will get returned. If they are running the app, you should link to them via a first-degree connection represented by a green edge line. You will also receive their friends if they have any, i.e. second-degree connections to you, which your node will link to represented by blue edge lines. Change your color by picking one of the six pre-chosen options, or get fancy and set your own from `:dojo`:

```
> :mesh &mesh-color '#000000'
```

Like `:feed`, the plan is to turn this example into a complete written-up tutorial, but we wanted to share the code with everyone first. For the time being, we're happy to answer questions in `:talk` or by a Github issue.
