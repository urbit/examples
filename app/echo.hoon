::  Accepts any noun from dojo and prints it out
::
::  /hoon/echo/app
::
!:
|_  {bow/bowl state/$~}                                 ::<  stateless
::
++  poke-noun
  |=  arg/*
  ^-  (quip $~ +>.$)
  ~&  [%argument arg]
  [~ +>.$]
::
--
