# `:square`

Source:

* `/app/square.hoon`

`:dojo`:
    ~your-urbit:dojo/examples> |start %square

    ~your-urbit:dojo/examples> :square &atom 10

<br />    

This app prints out the square of an atom.

Start the app from `:dojo` and poke it with an atom. You should see:

    [%square 100]

Here's what happened:

* The `:dojo` noun was type-checked by `mar/atom.hoon` and converted into an atom

* The validated atom was then passed to `++poke-atom` in the `square.hoon` app,
which printed out the square of the given number'.
