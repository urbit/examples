# Introduction

This repository consists of a list of directories, each intended to be copied on
top of the standard contents of a /=base= desk. These examples demonstrate three
different ways of executing code within urbit: generating values for [the
console(:dojo)](http://doznec.urbit.org/home/pub/doc/tools/dojo), [functionally
building(%ford)](http://doznec.urbit.org/home/pub/doc/arvo/ford) web pages, and
[application
environement(%gall)](http://doznec.urbit.org/home/pub/doc/arvo/gall).

# Environemnets

A directory __samp__ is usually(XX?) one of four types of examples:

1. dojo: entry point inside __samp__ is gen/__samp__.hoon, runnable as +__samp__. 

2. libs: entry point inside __samp__ is lib/__samp__.hoon, usable by 
adding it to your dojo context with /+  __samp__, then pulling arm:__samp__. test:__samp__ will demonstrate library functionality.

3. ford: entry point inside __samp__ is pub/__samp__/, accesible through
http://yourship.urbit.org/examples/pub/samp and/or
http://localhost:8080/examples/pub/samp

4. gall: entry point inside __samp__ is ape/__samp__.hoon, executable as |start
__samp__. These may also have a web front-end(a ford page, see previous type),
or generators gen/__samp__/__cmd__.hoon runnable with :__samp__+__cmd__

# Trying an example

An individual example can be copied to your ship.
```shell
> |merge /=examples= /=base=
> /=examples=
> |mount %
$ cp -r examples/$samp/ $pier/examples/
```

The dojo commands above initialize a `/=examples=` desk from your
`/=base=`(default distibution desk), direct :dojo to use it as the working
directory, and mount it to unix as __pier__/examples. Then, in unix, __samp__
contents are added to the base files.

# Sync over `%clay`

A live copy of all everything is also maintained at ~sampel-someship(XX). By
running `|sync /=examples= /~sampel-somehip/examples=`, a local copy of the
`%examples` desk will be created and automatically updated with any
changes/additions.

As above, `/=examples=` will allow app/generator examples to be run: a short
form of `=dir /=examples=`, it sets the working `dir` to the `%example` desk 
(`=`en interpolate the current ship and time).

(the ~sampel-someship mirror is maintained by running
`$ cp -r examples/*/ pier/examples/` as a commit hook; doing so locally will
produce equivalent results at any given version.)

# "Hello world" example

The [hello](tree/master/hello) example is a simple generator that returns
`%hello-world`.

In the `:dojo>` prompt(accessible by pressing `^X` repeatedly if you happen to have found yourself in e.g. talk)
```hoon
> |sync /=examples= /~sampel-someship/examples=
activated sync from %examples on ~sampel-someship to %examples
sync succeeded from %examples on ~sampel-someship to %examples
> /=examples=
=% /~pittyp-pittyp/examples/~2015.10.10..00.30.03..da73/
> +hello
%hello-world
```

## Feedback and contributions

We're really curious to hear about your experience using this stuff. All questions and comments are more than welcome. You can contact me at henry@tlon.io, or on `:talk` as `~sivtyv-barnel`.
