::  Accepts any noun from dojo and prints it out
::
::::  /hoon/echo/examples/app
  ::
/?    314
!:
|_  {bowl state/$~}
++  poke-noun
  |=  arg/*
  ^-  {(list) _+>.$}
  ~&  [%argument arg]
  [~ +>.$]

++  prep  ~&  'prep'  _`.  ::
--
