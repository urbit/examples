# Introduction

This repository consists of a list of directories, each intended to be copied on
top of the standard contents of a /=base= desk. These examples are divided
between [dojo generators](dojo), [libraries](libs), [ford pages](ford), and
[applications](gall). See local readmes for more information.

# Trying an example

An individual example can be copied to your ship.
```shell
> |merge /=examples= /=base=
> /=examples=
> |mount %
$ cp -r $example-type/$samp/ $pier/examples/
```

The dojo commands above initialize a `/=examples=` desk from your
`/=base=`(default distibution desk), direct :dojo to use it as the working
directory, and mount it to unix as __pier__/examples. Then, in unix, __samp__
contents are added to the base files.

# Sync over `%clay`

A live copy of all everything is also maintained at ~wactex-ribmex. By
running `|sync /=examples= /~wactex-ribmex/examples=`, a local copy of the
`%examples` desk will be created and automatically updated with any
changes/additions.

As above, `/=examples=` will allow app/generator examples to be run: a short
form of `=dir /=examples=`, it sets the working `dir` to the `%example` desk 
(`=`en interpolate the current ship and time).

(the ~wactex-ribmex mirror is maintained by running
`$ cp -r ~/examples/*/*/ wactex-ribmex/examples/` as a commit hook; doing so locally will
produce equivalent results at any given version.)

# "Hello world" example

The [hello](tree/master/hello) example is a simple generator that returns
`%hello-world`.

In the `:dojo>` prompt(accessible by pressing `^X` repeatedly if you happen to have found yourself in e.g. talk)
```hoon
> |sync /=examples= /~wactex-ribmex/examples=
activated sync from %examples on ~wactex-ribmex to %examples
sync succeeded from %examples on ~wactex-ribmex to %examples
> /=examples=
=% /~pittyp-pittyp/examples/~2015.10.10..00.30.03..da73/
> +hello
%hello-world
```

## Feedback and contributions

We're really curious to hear about your experience using this stuff. All questions and comments are more than welcome. You can contact me at henry@tlon.io, or on `:talk` as `~sivtyv-barnel`.
