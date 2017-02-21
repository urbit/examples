::  Sends subscription updates to sink.hoon
::
::::  /hoon/source/examples/app
  ::
/?    310
!:
::
|%
++  move  {bone $diff mark *}
--
|_  {hid/bowl state/$~}
++  poke-noun
  |=  arg/*
  ^-  {(list move) _+>.$}
  :_  +>.$
  %+  turn  (prey /example-path hid)
  |=({o/bone *} [o %diff %noun arg])
++  peer-example-path
  |=  pax/path
  ^-  {(list move) _+>.$}
  ~&  [%subscribed-to pax=pax]
  [~ +>.$]
--
