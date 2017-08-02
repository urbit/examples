# `:ping`

Source:

* `/app/ping.hoon`
* `/mar/ping/message.hoon`
* `/sur/ping/message.hoon`

`:dojo` (you will need two running urbits to send and receive a message):

    ~your-urbit-1:dojo/examples> |start %ping

    ~your-urbit-2:dojo/examples> |start %ping

    ~your-urbit-1:dojo/examples> :ping &ping-message [~your-urbit-2 'Hey, neighbor!']

<br />    

This application demonstrates how to send typed information to an app on
another ship by poking it with a 'mark.'

Start the app on two urbits in `:dojo` and send a `ping-message` from your first urbit using the command above. Your second urbit's `:dojo` should print:

    [%ping 'Message received!']
    [%ping %message 'Hey, neighbor!']

Let's briefly step through what we just did:

* We poked `ping.hoon` with data of the `ping-message` mark, which is
simply a ship address and a text `@t` atom.

* `mar/ping/message.hoon` parses the data, and then passes it along to
`++poke-ping-message`.

* `++poke-ping-message` then sends a move containing the text atom we
submitted to the corresponding `/ping` app on the urbit we specified (your second one).

* Your second urbit's `mar/atom.hoon` parses the atom, and passes it along
to`++poke-atom`, which prints out the output above.
