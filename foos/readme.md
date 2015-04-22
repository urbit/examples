# foos

This app records foosball scores (one wins by scoring 10) into its state and then uses them to calculate standings. It is very simple, which makes it easy to familiarize yourself with the anatomy of %gall apps.

##how it works and what to pay attention to
We submit a score on the client which uses urb.js to send JSON to our app with a *mark* of JSON. Our JSON mark in `mar` parses the JSON we received to `++json`, hoon's JSON data structure. When apps receive data from %gall, they receive it on a `++poke` arm of the corresponding mark.  Since we are receiving data with a mark of json, it activates our `++poke-json` arm.

Although `++json` is a hoon data type, it is not one that we can easily manipulate. Thus, we have to *reparse* it to other types that are convenient to use. This is can be confusing, so pay special attention to it in lines 35-38. You can checkout all of the JSON reparsers in 3bD in `zuse.hoon`.

Once we successfully reparse the result of a game, we store it in state. Notice how there are no calls to a database--all we do to change the state is use a `=.` to alter our subject. The reason that we are able to do this is that urbit provides single-level store, which eliminates the headache of having to deal with databases. 

Every time our state changes, our `++peek` arm is activated. `++peek` sends its result to all of the app's subscribers. In this case it sends our entire state everytime.

