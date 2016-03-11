`/sum`

To run [from dojo]:

`|start %examples-sum`

Then:

`:examples-sum &atom 3`

You should see:

`[%so-far 3]`

Then:

`:examples-sum &atom 666`

`[%so-far 669]`

Here's what happened:

- We poked `sum.hoon` with an unsigned decimal atom (`@ud`)

- `mar/atom.hoon` parsed the atom and passed it to `sum.hoon`'s `++poke-atom` arm, which adds the given number to the number stored in its state; the new result is then printed out and then replaces the previous number in the app state.

