`/sum`

Follow the instructions in the root readme to boot a fake galaxy and to start the app.

Then, poke the app with a number, more specifically data with the mark of 'atom':

`:examples-sum &atom 3`

You should see:

`[%so-far 3]`

`:examples-sum &atom 666`

`[%so-far 669]`

In short, `/sum` received our number on the `++poke-atom` arm, which simply adds that number to the current state (defaults/begins with `0`) and prints out the result.
