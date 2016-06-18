::  Allows one urbit to send the string 'howdy' to another urbit.
::
::::  /hoon/pong/examples/app
  ::
/?    314
|%
  ++  move  {bone term wire *}
--
!:
|_  {bowl state/$~}
::
++  poke-urbit
  |=  to/@p
  ^-  {(list move) _+>.$}
  [[[ost %poke /sending [to dap] %atom 'howdy'] ~] +>.$]
::
++  poke-atom
  |=  arg/@
  ^-  {(list move) _+>.$}
  ~&  [%receiving (@t arg)]
  [~ +>.$]
::
++  coup  |=(* [~ +>.$])
--
