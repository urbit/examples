::  Keeps track of the sum of all the atoms it has been
::  poked with and prints the sum out 
::
::::  /===/app/sum/hoon
  ::
!:
|%
++  move  {bone card}
++  card  $%  $~
          ==
--
|_  {bow/bowl sum/@}                                    ::<  sum is our app state
::
++  poke-atom
  |=  tom/@
  ^-  (quip move +>.$)
  ~&  sum+(add sum tom)
  [~ +>.$(sum (add sum tom))]
::
++  coup
  |=  {wir/wire err/(unit tang)}
  ^-  (quip move +>.$)
  ?~  err
    ~&  sum+success+'Poke succeeded!'
    [~ +>.$]
  ~&  sum+error+'Poke failed. Error:'
  ~&  sum+error+err
  [~ +>.$]
::
--
