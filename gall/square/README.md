`/square`

This app prints out the square of an atom.

To run [in dojo]:

`|start %examples-square`

`:examples-square &atom 5`

You should see:

`[%square 25]`

Here's what happened:

- the `square.hoon` app received our number

- The atom was parsed by `mar/atom.hoon`, and then passed to `++poke-atom`, which printed out the square of the given number'.
