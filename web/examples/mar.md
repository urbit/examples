---
title: Marks
---

# Marks

A mark is Urbit's version of a MIME type, if a MIME type was an executable specification.

Marks live under `/mar` in a `%clay` desk. A mark is just a label that's used as a path to one of these local source files in the Arvo filesystem. This source file defines a core that can mold untrusted data, diff and patch, convert to and from other marks, and more.

The syntax for molding data from one mark to another is similar to [casting](https://urbit.org/docs/hoon/twig/ket-cast) from a noun of one mold to another (and, in fact, mark cores use mold casting under the hood for their implementations; notice the distinction between type-checking data at the Hoon level versus validating data at the OS level). A simple example is converting an atom received as a noun (`*`) into an urbit (`@p`) name. This uses the following syntax in `:dojo`:

    ~your-urbit:dojo> &urbit &noun 0
    ~zod

Values in the `:dojo` are `&nouns` by default, so you don't need to convert your data to them explicitly in it:

    ~your-urbit:dojo> &urbit 0
    ~zod

`++poke` arms in `%gall` apps are named by the mark of the data they accept as samples. For example, `app/square` has a `++poke-atom` arm that takes an atom validated by the mark system and squares the value. In `:dojo`:

    ~your-urbit:dojo> |start %square
    ~your-urbit:dojo> :square &atom 10
    [%square 100]

A `mesh-color` works the same way:

    ~your-urbit:dojo> |start %mesh
    ~your-urbit:dojo> :mesh &mesh-color '#000000'
    'Color set! Notifying subscribers:'
    [%color '#000000']

Many app marks import the same molds from their corresponding structures in `/sur` that are used in the app. This keeps structure implementations in one place. See the `sur` page for more details on structures.

All of the example `%gall` apps have poke arms that take certain mark types as samples (in the case of `:feed`, `:feed` uses `:talk` as the backend; you can find the poke arms the web UI is calling by searching for `/app/talk.hoon` for the `++poke-mark-name` arms). View the source for some of these custom molds used by these example `%gall` apps and start to play around with them in your `:dojo`:

* `/mar/click/click.hoon`
* `/mar/click/clicks.hoon`
* `/mar/hello/world.hoon`
* `/mar/mail/message.hoon`
* `/mar/mail/send.hoon`
* `/mar/mesh/color.hoon`
* `/mar/mesh/friend.hoon`
* `/mar/mesh/friends.hoon`
* `/mar/mesh/network.hoon`
* `/mar/ping/message.hoon`
