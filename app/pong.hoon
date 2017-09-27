::  Allows one urbit to send the string 'Pong' to 
::  another urbit.
::
::::  /===/app/pong/hoon
  ::
!:
|%
++  move  {bone card}
++  card  $%  {$poke wire dock poke-contents}
          ==
++  poke-contents  $%  {$atom @}
                   ==
--
|_  {bow/bowl $~}                                       ::<  stateless
::
++  poke-urbit
  |=  to/ship
  ^-  {(list move) _+>.$}
  ~&  pong+'Outgoing pong!'
  :_  +>.$
  ~[[ost.bow %poke /sending [to dap.bow] %atom 'Pong']]
::
++  poke-atom
  |=  tom/@
  ^-  {(list move) _+>.$}
  ~&  pong+'Incoming pong!'
  ~&  pong+received+`@t`tom
  [~ +>.$]
::
++  coup  |=(* [~ +>.$])
::
--
