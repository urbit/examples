---
title: Web
---

# Web

Here you'll find the files for the example `%gall` applications that have a web
frontend, as well as standalone `%ford` web examples that show how to use the
Urbit build system to render data to the web.

Web files live under `/web` in a `%clay` desk. The Urbit example web pages here
are written in *Sail*, Hoon markup for XML. Using Sail for rendering web files
allows us to embed Hoon code in our XML and vice versa, offering a pure
functional programming boost to raw HTML (vaguely similar to JSX in the React
world). A Fora post overviewing Sail syntax can be found
[here](https://urbit.org/~~/fora/posts/~2017.7.6..21.27.00..bebb~/):

Each examples `%gall` app that has a web interface has a Sail file to render and
serve to the web. See the [`app`](/~~/examples/app) page for those.

This section contains simpler, more isolated `%ford` web examples to demonstrate
how to use Sail. These are being served at:

    http://localhost:8443/~~/pages/ford/{n}

where `{n}` is the number of the example, and the true `%clay` path is
`/~your-urbit/examples/{latest case or current date}/web/pages/ford/{n}` or
`/===/web/pages/{n}`. Your `%ford` build system will render the `{n}.hoon` Sail
file and serve that to the web at that URL.

Get started with a `%ford` web example by clicking below:

-   [`%ford 1`: Simple HTML](/~~/pages/ford/1)
-   [`%ford 2`: Call a Function](/~~/pages/ford/2)
-   [`%ford 3`: Assignment](/~~/pages/ford/3)
-   [`%ford 4`: Cores 1](/~~/pages/ford/4)
-   [`%ford 5`: Cores 2](/~~/pages/ford/5)
-   [`%ford 6`: Loops](/~~/pages/ford/6)
-   [`%ford 7`: Page Variables](/~~/pages/ford/7)
-   [`%ford 8`: Query String Parameters](/~~/pages/ford/8)
-   [`%ford 9`: Computing with Parameters](/~~/pages/ford/9)
-   [`%ford 10`: Breaking Code Into Parts](/~~/pages/ford/10)
-   [`%ford 11`: Computing with Parameters (and Libraries)](/~~/pages/ford/11)
-   [`%ford 12`: Loading Resources by Number](/~~/pages/ford/12)

<br />

> The examples pages that you're reading now are also in here, as well as the
> Docs if you cloned and copied them. :)
