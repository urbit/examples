::  Accepts any noun from dojo and prints it out
::
::::  /===/app/echo/hoon
  ::
!:
|%
++  move  {bone card}
++  card  $%  $~
          ==
--
::
|_  {bow/bowl $~}                                       ::<  stateless
::
++  poke-noun
  |=  non/*
  ^-  {(list move) _+>.$}
  ~&  echo+noun+non
  [~ +>.$]
::
--
