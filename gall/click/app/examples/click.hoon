::  Counts the number of clicks received on the 'Poke!' button on the frontend.
::
::::  /hoon/click/examples/app
  ::
/?    314
!:
|%
++  move  {bone $diff $mark *}
--
!:
|_  {hid/bowl clicks/@}
++  poke-examples-click-clique
  |=  {click/$examples-click}
  ~&  [%poked +(clicks)]
  :_  +>.$(clicks +(clicks))
  %+  turn  (prey /the-path hid)
  |=({o/bone *} [o %diff %examples-click-cliques +(clicks)])
++  peer-the-path
  |=  {pax/path}
  [[[ost.hid %diff %examples-click-cliques clicks] ~] +>.$]
--
