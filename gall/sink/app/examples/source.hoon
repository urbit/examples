/?    314
!:
|%
++  move  {bone $diff mark *}
--
|_  {hid/bowl state/$~}
++  poke-noun
  |=  arg/*
  ^-  {(list move) _+>.$}
  :_  +>.$
  ~&  (prey /the-path hid)
  %+  turn  (prey /the-path hid)
  |=({o/bone *} [o %diff %noun arg])
++  peer
  |=  pax/path
  ^-  {(list move) _+>.$}
  ~&  [%subscribed-to pax=pax]
  [~ +>.$]
--
