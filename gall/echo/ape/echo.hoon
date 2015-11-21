::  There is no love that is not an echo
::
::::  /hoon/echo/ape
  ::
/?    314
|%
  ++  move  ,*
--
!:
|_  [bowl state=~]
++  poke-noun
  |=  arg=*
  ^-  [(list move) _+>.$]
  ~&  [%argument arg]
  [~ +>.$]
--
