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
  ~&  source+peer-notify+'Someone subscribed to you!'
  ~&  source+[ship+src.bow path+pax]
  [~ +>.$]
::
++  coup
  |=  {wir/wire err/(unit tang)}
  ^-  (quip move +>.$)
  ?~  err
    ~&  source+success+'Poke succeeded!'
    [~ +>.$]
  ~&  source+error+'Poke failed. Error:'
  ~&  source+error+err
  [~ +>.$]
::
++  reap
  |=  {wir/wire err/(unit tang)}
  ^-  (quip move +>.$)
  ?~  err
    ~&  source+success+'Peer succeeded!'
    [~ +>.$]
  ~&  source+error+'Peer failed. Error:'
  ~&  source+error+err
  [~ +>.$]
::
--
