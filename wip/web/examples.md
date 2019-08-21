---
anchor: none
title: Read Me
---

# Urbit examples

Let's get you running your first examples!

If you're viewing this from your Urbit, you're ready to try out the example
programs we have copied in to your ship. (If not, follow our [installation
instructions](https://github.com/urbit/examples) on Github).

## Examples library

We have examples of apps, generators, libraries and web pages here. More
formally, Urbit apps hold state and synchronize state and manage subscriptions;
generators are functional shell scripts; libraries present code modules to be
shared across the Urbit system; and Urbit web pages bring pure functional
programming and a powerful build system to conventional HTML.

-   [Applications](/~~/examples/app)
-   [Generators](/~~/examples/gen)
-   [Libraries](/~~/examples/lib)
-   [Web](/~~/examples/web)

Before diving all the way in, you can start with a few quick `Hello world`-style
examples below.

## Quickstart

#### `:hello` app

Start your first app, `:hello`, from `:dojo`:

    ~your-urbit:dojo/examples> |start %hello

`:hello` has a web interface that's being served now via `%eyre`, your Urbit web
server. Visit the URL in your web browser:

    http://localhost:8443/~~/pages/hello

Once the page loads with the `Hello, world!` delivered from `:hello`'s app
state, click the button to *poke* your running `:hello` app and see an output in
your `:dojo`.

    [%hello %poked 'Hello, world!']

You can find the source at `/app/hello.hoon` of this repo. Check out the
[`app`](/~~/examples/app) page for more on what just happened.

Onto your first generators!

#### `+hello` generator

Let's run your first generator, or Urbit shell script, from `:dojo`:

    ~your-urbit:dojo/examples> +hello/h1
    'Hello, world!'

Try the second `+hello` generator with a custom `cord` sample of your choice:

    ~your-urbit:dojo/examples> +hello/h2 'Mars'
    'Hello, Mars!'

Try the third with and without a sample where it will default:

    ~your-urbit:dojo/examples> +hello/h3, =txt 'Mars'
    'Hello, Mars!'

    ~your-urbit:dojo/examples> +hello/h3
    'Hello, universe!'

Generators offer a great combination of simplicity, flexibility and power. You
can find the source for the above examples in `/gen/hello` of this repo and more
information on generators at the [`gen`](/~~/examples/gen) page.

Let's look at libraries next.


### Contributing / Feedback

The number one goal for this repository is for it to be fun! People are always
around on [`:talk`](https://urbit.org/docs/using/setup#-messaging-talk) and
[`:fora`](https://urbit.org/~~/fora). Help each other out, and don't hesitate if
you have an idea for a contribution. We'd love to make this both a learning
resource and a record of what people in the community are coming up with.

Give us feedback in the comments of [this `:fora`
post](https://urbit.org/~~/fora/posts/~2017.8.3..20.53.26..c361~/) after you've
played around with these for a little bit. Let us know about your ideas,
requests, and/or problems and we'll try and get back to you quickly. Pull
requests are more than welcome.

<br />

Happy hacking!
