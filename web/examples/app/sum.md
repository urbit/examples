# `:sum`

Source:

* `/app/sum.hoon`

`:dojo`:

    ~your-urbit:dojo/examples> |start %sum

    ~your-urbit:dojo/examples> :sum &atom 40

    ~your-urbit:dojo/examples> :sum &atom 2

<br />    

This app prints out an accumulating sum of numbers stored in `:sum`'s app state.

Start the app from `:dojo` and poke it with an atom. You should see:

    [%sum 40]

Then, once more. The sum should now be:

    [%sum 42]

Here's what happened:

* The `:dojo` nouns were type-checked by `mar/atom.hoon` and converted into an atom

* The validated atoms were then passed to the `++poke-atom` arm in the `sum.hoon` app,
which added the given numbers to the number stored in its state; the new
result is then printed out and then replaces the previous number in the app
state.
