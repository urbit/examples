---
title: Generators
---

# Generators

Generators are short Urbit shell scripts.

Generators live under `/gen` in a `%clay` desk, and are invoked with `+name` at
the `:dojo` prompt.

We've grouped generators by section, like `hello`. To run one you'll need the
directory prefix:

    ~your-urbit:dojo> +hello/h1
    'Hello, world!'

Get started with one below!

#### Hello, world!

**Command:**\\ `~your-urbit:dojo/examples> +hello/h1`

**Source**:\\ `/gen/hello/h1.hoon`

#### Hello, Mars!

**Command:**\\ `~your-urbit:dojo/examples> +hello/h2 'Mars'`

**Source**:\\ `/gen/hello/h2.hoon`

#### Hello, {default}!

**Commands:**\\ `~your-urbit:dojo/examples> +hello/h3, =txt 'Mars'`\\
`~your-urbit:dojo/examples> +hello/h3`

**Source**:\\ `/gen/hello/h3.hoon`

#### Project Euler 1

> [Multiples of 3 and 5](https://projecteuler.net/problem=2)

**Commands:**\\ `~your-urbit:dojo/examples> +project-euler/p1`

**Source**:\\ `/gen/project-euler/p1.hoon`

#### Project Euler 2

> [Even Fibonacci numbers](https://projecteuler.net/problem=2)

**Commands:**\\ `~your-urbit:dojo/examples> +project-euler/p2`

**Source**:\\ `/gen/project-euler/p2.hoon`

#### Project Euler 3

> [Largest prime factor](https://projecteuler.net/problem=3)

**Commands:**\\ `~your-urbit:dojo/examples> +project-euler/p3`

**Source**:\\ `/gen/project-euler/p3.hoon`

#### Project Euler 4

> [Largest palindrome product](https://projecteuler.net/problem=4)

**Commands:**\\ `~your-urbit:dojo/examples> +project-euler/p4`

**Source**:\\ `/gen/project-euler/p4.hoon`

#### Project Euler 5

> [Smallest multiple](https://projecteuler.net/problem=5)

**Commands:**\\ `~your-urbit:dojo/examples> +project-euler/p5`

**Source**:\\ `/gen/project-euler/p5.hoon`

#### Project Euler 6

> [Sum square difference](https://projecteuler.net/problem=6)

**Commands:**\\ `~your-urbit:dojo/examples> +project-euler/p6`

**Source**:\\ `/gen/project-euler/p6.hoon`

#### Project Euler 9

> [Special Pythagorean triplet](https://projecteuler.net/problem=9)

**Commands:**\\ `~your-urbit:dojo/examples> +project-euler/p9`

**Source**:\\ `/gen/project-euler/p9.hoon`

#### Project Euler 14

> [Special Pythagorean triplet](https://projecteuler.net/problem=14)

**Commands:**\\ `~your-urbit:dojo/examples> +project-euler/p14`

**Source**:\\ `/gen/project-euler/p14.hoon`

#### Brainf\*\*k &gt; [Wikipedia](https://en.wikipedia.org/wiki/Brainfuck) &gt; &gt; [Esolangs](https://projecteuler.net/problem=14)

**Commands:**\\ `~your-urbit:dojo/examples> +fun/bf 42`

**Source**:\\ `/gen/fun/bf.hoon`
