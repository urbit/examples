# Urbit - Examples

### Introduction

This repository contains some example code for Urbit. There are generators (short `:dojo` commands), libraries (to be loaded into `:dojo`), `%ford` web examples, `%gall` applications, and marks and structures that these example `%gall` applications use.

### Installation

Clone this repo somewhere. Let's call it `/examples/path`.

On a [running urbit](https://urbit.org/docs/using/install) (it's best to use comets or [fake ships](https://urbit.org/~~/fora/posts/~2017.1.5..21.31.04..20f3~/) for these examples) create an `%examples` desk (branch) in `:dojo`:

    ~your-urbit:dojo> |merge %examples our %home

Then set your current directory to `%examples`, `|serve` your `%examples` desk's `web` directory and mount your `%examples` desk to Unix:

    ~your-urbit:dojo> =dir /=examples
    ~your-urbit:dojo/examples> |serve %/web
    ~your-urbit:dojo/examples> |mount %

If your urbit was installed at `/urbit/path` now you can find your
`%examples` desk at `/urbit/path/your-urbit/examples`.

Copy in all the `examples` files to your `%examples` desk:

    for dir in {app,gen,lib,mar,sur,web}; do cp -r /examples/path/$dir* /urbit/path/your-urbit/examples; done

Your `%clay` filesystem should acknowledge the newly added files.

> We've found it also helps to have a clone of the docs on hand in case `urbit.org` experiences high traffic. You can copy these into your running urbit as well and self-host them locally.
>
> In your Unix shell, clone our [docs repo](https://github.com/urbit/docs) somewhere and copy the contents from your `/docs/path` into your `%examples` desk's `web` directory:
>
> ```
> cp -r /docs/path/docs* /urbit/path/your-urbit/examples/web
> ```
>
> And view them locally from the browser at:
>
> ```
> http://localhost:8443/~~/docs
> ```

### Contributing / Feedback

You're now free to play with these examples! Give us feedback in [`:talk`](https://urbit.org/docs/using/setup#-messaging-talk) or file a Github issue if you have any requests, ideas or problems. Pull requests and comments are more than welcome!

We'd love if this became a project driven by the Urbit open-source community. Contribute, ask lots of questions and build stuff in Hoon to show off to the world!
