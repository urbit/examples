::  Accepts any noun from dojo and prints it out
::
::::  /hoon/echo/examples/app
  ::
/?    310
!:
|_  {bowl state/$~}
++  poke-noun
  |=  arg/*
  ^-  {(list) _+>.$}
  ~&  [%argument arg]
  [~ +>.$]

++  prep  ~&  'prep'  _`.  ::
--
