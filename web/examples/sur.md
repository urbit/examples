---
title: Structures
---

# Structures

A Hoon structure file is simply a module containing one or several cores defining any number of molds.

Structures live under `/sur` in a `%clay` desk. Keeping structures in one place allows for them to be used in multiple places, like apps, app marks and app libraries. Basically, libraries are for sharing code, and structures are for sharing data structures to use in Hoon code. See the [`lib`](/~~/examples/lib) page for more details on libraries.

Just like you can add library cores to your `:dojo` subject to access the code arms within them, you can add structure cores to your `:dojo` subject to access the mold arms within them. This uses the same library importing syntax except with the `%ford` rune `/-` for structures instead of `/+`.

Load a structure `/sur/name.hoon` into your current `:dojo` subject using the following command syntax:

    ~your-urbit:dojo/examples> /-  name

(Note the two spaces - this is a tall-form `%ford` rune)

Each structure arm maps to a [mold](https://urbit.org/~~/docs/hoon/basic/), an idempotent validator gate. You can cast a `:dojo` noun into the corresponding typed data of a structure mold, if the noun is in the mold's span. If the structure is a core with arms, the syntax used to access the arm is `arm:core`. For example, the `clicks` mold for the `:click` app (the value held in the app state of `:click`): this is just an unsigned decimal number (`@ud`) counting the number of times the app has been "clicked" (poked). From `:dojo`:

    ~your-urbit:dojo/examples> /-  click
    ~your-urbit:dojo/examples> `clicks:click`42
    42

If the structure file contains only a single, unarmed mold, you can simply use the structure file name to reference the single mold. A good example is the `ping-message` structure.

    ~your-urbit:dojo/examples> /-  ping-message
    ~your-urbit:dojo/examples> `ping-message`[~zod 'Hey, neighbor!']
    [to=~zod message='Hey, neighbor!']

When you're done, simply enter a blank `/-` to reset `:dojo` to the normal
subject.

<br />

View the source for some custom structures used by the example apps in this repository and start to play around with them in your `:dojo`:

* `/sur/click.hoon`
* `/sur/mail/message.hoon`
* `/sur/mail/send.hoon`
* `/sur/mesh.hoon`
* `/sur/ping/message.hoon`
