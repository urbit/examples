::  Sends subscription updates to sink.hoon
::
::  /hoon/source/app
::
!:
::
|%
++  move  {bone $diff mark *}
--
::
|_  {bow/bowl $~}                                       ::<  stateless
::
++  poke-noun
  |=  non/*
  ^-  (quip move +>.$)
  :_  +>.$
  %+  turn  (prey /example-path bow)
  |=({o/bone *} [o %diff %noun non])
::
++  peer-example-path
  |=  pax/path
  ^-  (quip move +>.$)
  ~&  [%subscribed-to pax=pax]
  [~ +>.$]
::
++  coup
  |=  {wir/wire err/(unit tang)}
  ^-  (quip move +>.$)
  ?~  err
    ~&  success+'Poke succeeded!'
    [~ +>.$]
  ~&  error+'Poke failed. Error:'
  ~&  error+err
  [~ +>.$]
::
++  reap
  |=  {wir/wire err/(unit tang)}
  ^-  (quip move +>.$)
  ?~  err
    ~&  success+'Peer succeeded!'
    [~ +>.$]
  ~&  error+'Peer failed. Error:'
  ~&  error+err
  [~ +>.$]
::
--
