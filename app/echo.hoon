::  Accepts any noun from dojo and prints it out
::
::  /hoon/echo/app
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
