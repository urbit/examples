> Since Urbit version 0.8.0, changes to [eyre](https://urbit.org/docs/learn/arvo/eyre/), the HTTP vane of the [Arvo](https://urbit.org/docs/learn/arvo/) operating system, have depricated a significant number of the examples in this repository, and the repository is currently being renovated accordingly.

>All examples in the top level directory have been updated or otherwise confirmed working -- everything in `wip` is for the intrepid only!

## Introduction

This is an open repository for Urbit example code.

There are generators (short Dojo commands), libraries (to be loaded into
Dojo), Landscape and Gall applications, and marks and structures that 
these example appilcations use.

Give these a try by following the installation instructions below, and
[peruse the list](#examples).

## Installation

First, you'll need a running urbit. [Install
Urbit](https://urbit.org/docs/getting-started/installing-urbit/), then
[boot a ship](https://urbit.org/docs/getting-started/booting-a-ship/).

For development purposes, [fake ships](https://urbit.org/docs/using/creating-a-development-ship/)
are best. If you need live network connectivity, comets are recommended.

## Get started!

Some applications are working examples of Landscape applications with specific
types of functionality you can play around with. 
Others are generators, libraries for Dojo, and more.

The top folder directory is listed per example; each example has folders you
copy into your Urbit ship (eg. /app, /lib, /mar). Once you've copied the
example into your ship, 
`|commit %home` (or whatever [%desk](https://urbit.org/docs/using/filesystem/#quickstart) you're using)
to update your ship filesystem.

### Getting started with Landscape tiles

Landscape tiles also use the [React](https://reactjs.org/) framework and require 
compilation if you want to change them -- find their source in the /src folder, 
`npm install` their dependencies, change the Urbit ship location in the `.urbitrc` file to your ship location, and `npm run serve`.

If you just want to try out the Landscape tile examples, then all you need
to do is copy the other folders into your ship.

You'll find Landscape running on http://localhost:PORT, PORT being 80, 8080, 8081, 
and so on, depending on your operating system's free ports; see your ship's boot message
for a notification as to what port HTTP is available on. If you haven't used
Landscape before, you'll need to enter `+code` on your ship to get the password
to authenticate yourself with on the Landscape interface.

See also the [Urbit documentation](https://urbit.org/docs/getting-started/booting-a-ship/#using-landscape)
for more information.

## Examples

Each example has more information in its directory -- click an example below
to learn more about it.

* [click](click)
* [hello](hello)
* [speakrune](speakrune)

## Learn a lot, and have fun!

The number one goal for this repository is for it to be fun! People are always
around on [Talk](https://urbit.org/docs/using/messaging/). Help each other out, and don't hesitate if
you have an idea for a contribution. We'd love to make this both a learning
resource and a record of what people in the community are coming up with.

Give us feedback [via email](mailto:support@urbit.org) after
you've played around with these for a little bit. Let us know about your ideas,
requests, and/or problems and we'll try and get back to you quickly. Pull
requests are more than welcome.