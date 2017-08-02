`/mail`

This allows urbits to send typed, email-like message over the network.

You will need to have two running urbits to send a message--see the root README
for ways to do this.

To run on both ships from `:dojo`:

    |start %examples-mail

    |start %examples-mail

Then, from the browser:

    http://localhost:8443~~/pages/examples/mail

And:

    http://localhost:8444/~~/pages/examples/mail

Fill out the "to" field with the name of your other urbit (don't forget `@p`
syntax: prefix the name/address with a `~`!).

Then, fill out the "subject" and "body" forms with text.

Click "send."

The receiving urbit's web page should display the message.


Let's walk through what just happened:

- when we click 'send', foos.js uses `urb.send` from `urb.js` to send our
message as an 'examples-mail-message' to the sending urbit's `mail.hoon` app.

- `mar/examples/mail/message.hoon` parses our message and passes it to the
`++poke-examples-mail-message` arm.

- `++poke-examples-mail-message` saves the message in the `sent` part of its f
state, then sends it--again as a `examples/mail/message`--to the `mail.hoon`
app running on the other ship.

- the other ship's `mail.hoon` also parses our message with
`mar/examples/mail/message`, receiving it on the same
`++poke-examples-mail-message` arm.

- `++poke-examples-mail-message` saves the received `examples-mail-message` in
its state, and then sends the updated version to the browser client for display.
