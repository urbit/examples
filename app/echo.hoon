::  Accepts any noun from dojo and prints it out
::
::::  /===/app/echo/hoon
  ::
!:
|_  {bow/bowl $~}                                       ::<  stateless
::
++  poke-noun
  |=  non/*
  ^-  (quip $~ +>.$)
  ~&  echo+noun+non
  [~ +>.$]
::
--
