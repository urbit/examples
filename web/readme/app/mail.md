# `:mail`

This allows Urbits to send typed, email-like message over the network.

You will need to have two running Urbits to send a message--see the root README
for ways to do this.

To run on both ships from `:dojo`:

    |start %mail

    |start %mail

Then, from the browser:

    http://localhost:8443~~/pages/mail

And:

    http://localhost:8444/~~/pages/mail

Fill out the "to" field with the name of your other urbit (don't forget `@p`
syntax: prefix the name/address with a `~`!).

Then, fill out the "subject" and "body" forms with text.

Click "send."

The receiving urbit's web page should display the message.


Let's walk through what just happened:

- when we click 'send', foos.js uses `urb.send` from `urb.js` to send our
message as an 'mail-send' to the sending urbit's `mail.hoon` app.

- `mar/mail/send.hoon` parses our message and passes it to the
`++poke-mail-send` arm.

- `++poke-mail-send` saves the message in the `sent` part of its
state, then sends it with the current timestamp and sender --
as a `mail-message` -- to the `mail.hoon` app running on the other ship.

- the other ship's `mail.hoon` parses our message with
`mar/mail/message`, receiving it on the `++poke-mail-message` arm.

- `++poke-mail-message` saves the received `mail-message` in
its state, and then sends the updated version to the browser client for display.
