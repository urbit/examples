# `:sum`

To run from `:dojo`:

```
> |start %sum
```

Then:

```
> :sum &atom 40
```

You should see:

```
[%sum 40]
```

Then:

```
> :sum &atom 2
```

The sum should now be:

```
> [%sum 42]
```

Here's what happened:

- We poked `sum.hoon` with an atom (a natural number, `@`)

- `mar/atom.hoon` parsed the atom and passed it to `sum.hoon`'s `++poke-atom`
arm, which adds the given number to the number stored in its state; the new
result is then printed out and then replaces the previous number in the app
state.
