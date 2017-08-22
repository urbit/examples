# Urbit examples

### Introduction

This repository contains some example code for Urbit.

There are generators (short `:dojo` commands), libraries (to be loaded into
`:dojo`), `%ford` web examples, `%gall` applications, and marks and structures
that these example `%gall` applications use.

### Installation

First, you'll need a running urbit. Follow our [install
instructions](https://urbit.org/docs/using/install) to create a comet, or use a
[fake ship](https://urbit.org/~~/fora/posts/~2017.1.5..21.31.04..20f3~/). For
development, it's usually a good idea to use a disposable ship (either a comet
or a fake one).

On your Urbit, create an `%examples` desk (branch) in `:dojo`:

    ~your-urbit:dojo> |merge %examples our %home

Then set your current directory to `%examples`, `|serve` your `%examples` desk's
`web` directory and mount your `%examples` desk to Unix:

    ~your-urbit:dojo> =dir /=examples=
    ~your-urbit:dojo/examples> |serve %/web
    ~your-urbit:dojo/examples> |mount %

If your urbit was installed at `/urbit/path` now you can find your `%examples`
desk at `/urbit/path/your-urbit/examples`.

Clone this repo somewhere. Let's call it `/examples/path`.

Copy in all the `examples` files to your `%examples` desk. In Unix:

    $ for dir in {app,gen,lib,mar,sur,web}; do cp -r /examples/path/$dir* /urbit/path/your-urbit/examples; done

Your `%clay` filesystem should acknowledge the newly added files.

> We've found it also helps to have a clone of the docs on hand in case
> `urbit.org` experiences high traffic. You can copy these into your running
> urbit as well and self-host them locally.
>
> In your Unix shell, clone our [docs repo](https://github.com/urbit/docs)
> somewhere and copy the contents from your `/docs/path` into your `%examples`
> desk's `web` directory:
>
>     cp -r /docs/path/docs* /urbit/path/your-urbit/examples/web
>
> And view them locally from the browser at:
>
>     http://localhost:8443/~~/docs

### Have fun!

You're now free to play with these examples! Each example section has its own
page as well as each `%gall` app. There are in `/web` of your `%examples` desk
now; view them in your browser at:

    http://localhost:8443/~~/examples

### Contributing / Feedback

Give us feedback in
[`:talk`](https://urbit.org/docs/using/setup#-messaging-talk) or [file a Github
issue](https://github.com/urbit/examples/issues) if you have any ideas,
requests, or problems. Pull requests and comments are more than welcome!

The number one goal for this repository is for it to be fun! Ask lots of
questions, help each other out, and let's help make this a great resource for
newcomers to Urbit.
