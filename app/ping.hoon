::  Allows one ship to ping another with a string of text
::
::  /hoon/ping/app
::
/-  ping-message
::
!:
|%
++  move  {bone $poke wire *}
--
|_  {bow/bowl $~}                                       ::<  stateless
::
++  poke-ping-message
  |=  ping-message
  ~&  ping+'Message sent!'
  ^-  (quip move +>.$)
  :_  +>.$
  :_  ~
  [ost.bow %poke /sending [to dap.bow] %atom message]
::
++  poke-atom
  |=  arg/@
  ~&  ping+'Message received!'
  ^-  (quip move +>.$)
  ~&  ping+message+(@t arg)
  [~ +>.$]
::
++  coup  |=(* `+>)
--
