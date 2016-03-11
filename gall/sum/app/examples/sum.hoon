::  Keeps track of the sum of all the atoms it has been poked with.
::
::::  /hoon/up/examples/app
  ::
/?    314
!:
|_  {bowl state/@}
++  poke-atom
  |=  arg/@
  ^-  {(list) _+>.$}
  ~&  [%so-far (add state arg)]
  [~ +>.$(state (add state arg))]
--
