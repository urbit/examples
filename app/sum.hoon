::  Keeps track of the sum of all the atoms it has been poked with.
::
::  /hoon/up/app
::
!:
|_  {bow/bowl sum/@}                                    ::<  sum is our app state
::
++  poke-atom
  |=  tom/@
  ^-  (quip list +>.$)
  ~&  sum+(add sum tom)
  [~ +>.$(sum (add sum tom))]
::
++  coup
  |=  {wir/wire err/(unit tang)}
  ^-  (quip move +>.$)
  ?~  err
    ~&  success+'Poke succeeded!'
    [~ +>.$]
  ~&  error+'Poke failed. Error:'
  ~&  error+err
  [~ +>.$]
::
--
