# `:pong`

Source:

* `/app/pong.hoon`

`:dojo` (you will need two running urbits to send and receive a message):

    ~your-urbit-1:dojo/examples> |start %pong

    ~your-urbit-2:dojo/examples> |start %pong

    ~your-urbit-1:dojo/examples> :pong &urbit ~your-urbit-2

<br />    

This app demonstrates how to poke an app with an urbit name.

Start the app on two urbits in `:dojo` and send a pong to your second urbit from your first urbit using the command above. Your second urbit should receive:

    [%pong 'Incoming pong!']
    [%pong %received 'Pong']

Let's briefly walk through what we just did:

* We sent data of the `urbit` mark from dojo to the sender (your first urbit)'s `pong.hoon`
app.

* `mar/urbit` parses the data, and passes it to `++poke-urbit`

* `++poke-urbit` then sends a move with the message 'Pong' to your second urbit.

* Your second urbit received this data with its own `pong.hoon` app. `pong.hoon` parses it
with `mar/atom`, and then receives it on the `++poke-atom` arm, which simply
prints the message out.
