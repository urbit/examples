::  Allows one urbit to send the string 'Pong' to another urbit.
::
::  /hoon/pong/app
::
!:
|%
++  move  {bone card}
++  card  $%  {$poke wire *}
          ==
--
|_  {bow/bowl $~}                                       ::<  stateless
::
++  poke-urbit
  |=  to/ship
  ^-  (quip move +>.$)
  ~&  'Outgoing pong!'
  :_  +>.$
  ~[[ost.bow %poke /sending [to dap.bow] %atom 'Pong']]
::
++  poke-atom
  |=  tom/@
  ^-  (quip move +>.$)
  ~&  'Incoming pong!'
  ~&  [%received `@t`tom]
  [~ +>.$]
::
++  coup  |=(* [~ +>.$])
::
--
