::  Allows one ship to ping another with a string of text
::
::::  /hoon/ping/examples/app
  ::
/?    314
|%
  ++  move  {bone term wire *}
--
!:
|_  {bowl state/$~}
::
++  poke-examples-ping-message
  |=  {to/@p message/@t}
  ~&  'sent'
  ^-  {(list move) _+>.$}
  :-  ^-  (list move)
      :~  `move`[ost %poke /sending [to dap] %atom message]
      ==
  +>.$
::
++  poke-atom
  |=  arg/@
  ~&  'received'
  ^-  {(list move) _+>.$}
  ::
  ~&  [%receiving (@t arg)]
  [~ +>.$]
::
++  coup  |=(* `+>)
--

