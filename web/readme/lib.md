---
title: Libraries
---

# Libraries

This directory contains Hoon modules. To try one in `dojo`, you can do:

    ~your-urbit:dojo/examples> /+  name

to add the library `name` to the dojo subject. (Note the two spaces - this is a tall-form rune.) Each library contains a number of arms that take input samples and produce product outputs. For example, decrement a number in `:dojo` using the Nock `++dec` implementation in `/lib/nock`:

    ~your-urbit:dojo/examples> /+  nock
    ~your-urbit:dojo/examples> (dec:nock 43)
    42

Or [bubble sort](https://en.wikipedia.org/wiki/Bubble_sort) a list with `++bubble-sort` in `/lib/sorts`:

    ~your-urbit:dojo/examples> /+  sorts
    ~your-urbit:dojo/examples> (bubble-sort:sorts ~[5 2 8 3 1 13 1])
    ~[1 1 2 3 5 8 13]

When you're done, simply enter a blank `/+` to reset `:dojo` to the normal
subject.
