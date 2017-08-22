---
title: Libraries
---

# Libraries

This directory contains Hoon library modules.

Libraries live under `/lib` in a `%clay` desk. Each library core contains a
number of arms that take input samples and produce output products.

First, you need to load the library core into your current `:dojo` subject with
the `/+` `%ford` rune, then to call a library arm you must evaluate it against
the name of the library core. For example, load the `/lib/nock.hoon` library and
decrement a number in `:dojo` using the Nock `++dec` implementation:

    ~your-urbit:dojo/examples> /+  nock
    ~your-urbit:dojo/examples> (dec:nock 43)
    42

(Note the two spaces - this is a tall-form `%ford` rune)

You can also call the `++test` arm of the library without a sample to evaluate
the test expression in the library file. Here's `++test` in `/lib/sorts`:

    ~your-urbit:dojo/examples> /+  sorts
    ~your-urbit:dojo/examples> (test:sorts)
    [ [%insertion-sort ~[1 1 2 3 5 8 13]]
      [%bubble-sort ~[1 1 2 3 5 8 13]]
      %merge-sort ~[1 1 2 3 5 8 13]
    ]

When you're done, simply enter a blank `/+` to reset `:dojo` to the normal
subject.

<br />

Try them all!

#### L-99: Ninety-Nine Lisp Problems

**Command:**\\ `~your-urbit:dojo/examples> /+  lisp99`\\
`~your-urbit:dojo/examples> (test:lisp99)`

**Source**:\\ `/lib/lisp99.hoon`

#### Nock: Urbit's Nano-VM

**Command:**\\ `~your-urbit:dojo/examples> /+  nock`\\
`~your-urbit:dojo/examples> (test:nock)`

**Source**:\\ `/lib/nock.hoon`

#### S-Expression Parser

**Command:**\\ `~your-urbit:dojo/examples> /+  parse-sexpr`\\
`~your-urbit:dojo/examples> (test:parse-sexpr)`

**Source**:\\ `/lib/parse-sexpr.hoon`

#### SKI Combinator Calculus

**Command:**\\ `~your-urbit:dojo/examples> /+  ski`\\
`~your-urbit:dojo/examples> (test:ski)`

**Source**:\\ `/lib/ski.hoon`

#### Sorting algorithms

**Command:**\\ `~your-urbit:dojo/examples> /+  sorts`\\
`~your-urbit:dojo/examples> (test:sorts)`

**Source**:\\ `/lib/sorts.hoon`

#### Knuth-Morris-Pratt String Search

**Command:**\\ `~your-urbit:dojo/examples> /+  strings-kmp`\\
`~your-urbit:dojo/examples> (test:strings-kmp)`

**Source**:\\ `/lib/strings-kmp.hoon`

#### Pig Latin

**Command:**\\ `~your-urbit:dojo/examples> /+  strings-piglatin`\\
`~your-urbit:dojo/examples> (test:strings-piglatin)`

**Source**:\\ `/lib/strings-piglatin.hoon`
