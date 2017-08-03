# `:mesh`

Source:

* `/app/mesh.hoon`
* `/mar/mesh/message.hoon`
* `/mar/mesh/send.hoon`
* `/sur/mesh/message.hoon`
* `/sur/mesh/send.hoon`
* `/web/pages/mesh.hoon`

`:dojo` (you will need three running urbits to demo a full `:mesh` social network):

    ~your-urbit-1:dojo/examples> |start %mesh

    ~your-urbit-2:dojo/examples> |start %mesh

    ~your-urbit-3:dojo/examples> |start %mesh

Web:

    http://localhost:8443/~~/pages/mesh

    and

    http://localhost:8444/~~/pages/mesh

> Running in an incognito tab might help keep your cookies clean here.

<br />    


`:mesh` is a simple distributed social network. The backend is a `%gall` app written from scratch, and the frontend uses `D3.js` to render a force-directed graph representing your `:mesh` network. `:mesh` is a reasonably complete demo that works well to highlight how `%gall` apps make distributed state synchronization a breeze for app developers, and how to serve reasonably complex app data to the web to render with the frontend UI library of your choice.

Contained in your `:mesh` app state are: your social network, containing your friends and friends-of-friends; and a HTML hex color that propagates to all of your friends and colors a node that represents you on your and all of your friends' graphs.

Load up your first urbit's web interface at the link above. The `:mesh` networks of your urbit will start empty. "Friend" your second urbit by typing their name in the text box and hitting `Enter` on your keyboard (don't forget `@p` syntax: prefix the name/address with a `~`!).

After a seconds, a network graph should be drawn showing the new first-degree connection, represented by a green line edge.

Both node colors default to grey. Click one of the six preselected color options, or get fancy and set your own in the `:dojo` of your first urbit:

    ~your-urbit-1:dojo/examples> :mesh &mesh-color '#000000'  

Your first urbit's node on the graph should now be the new color. Now if you load your second urbit's web UI at the second link above and "friend" your first urbit back, the connection you make with them will display the correct updated color. Change your second urbit's color, and the change will push to your first urbit's UI in real time.

In your second urbit's UI, friend your third running urbit, which will create a second first-degree connection in your second urbit's graph. But if you look back in your first urbit's graph, the connection won't be direct; it will be second-degree, as the third urbit is the friend of your friend, represented by a blue line edge. Friending the third urbit directly will change this back to a first-degree connection. Colors changes on any of the ships will propagate to all subscribed friends and their friends.

Like `:feed`, the plan is to turn this example into a complete written-up tutorial, but we wanted to share the code with everyone first. For the time being, we're happy to answer questions in `:talk` or by a Github issue.
