`/ping`

This application demonstrates how to send typed information to an app by poking it with a 'mark.'

## Overview

Follow the instructions in the root `readme.md` to get the app up and running on two fake piers, for example `~zod` and `~rex`.

From `~zod`:

`:ping &examples-ping-message [~lec 'message-here']`

`~lec` should receive:

`[%receiving 'message here']`

Let's briefly walk through the flow of what we did. We poked the `/ping` app with data of the `examples-ping-message` mark, which is simply a ship address and a text `@t` atom. This arm then sends a move containing the text atom--of mark atom--we submitted to the specified ship, `~lec`, which receives the data with the `++poke-atom`, which prints out the output above.
