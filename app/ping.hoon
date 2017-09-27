::  Allows one ship to ping another with a string of text
::
::::  /===/app/ping/hoon
  ::
/-  ping-message
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
