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
  ^-  (quip move +>.$)
  ~&  echo+noun+non
  [~ +>.$]
::
--
