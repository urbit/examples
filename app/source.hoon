::  Sends subscription updates to sink.hoon
::
::::  /===/app/source/hoon
  ::
!:
::
|%
++  move  {bone card}
++  card  $%  {$diff diff-contents}
          ==
++  diff-contents  $%  {$noun *}
                   ==
--
::
|_  {bow/bowl $~}                                       ::<  stateless
::
++  poke-noun
  |=  non/*
  ^-  {(list move) _+>.$}
  :_  +>.$
  %+  turn  (prey /example-path bow)
  |=({o/bone *} [o %diff %noun non])
::
++  peer-example-path
  |=  pax/path
  ^-  {(list move) _+>.$}
  ~&  source+peer-notify+'Someone subscribed to you!'
  ~&  source+[ship+src.bow path+pax]
  [~ +>.$]
::
++  coup
  |=  {wir/wire err/(unit tang)}
  ^-  {(list move) _+>.$}
  ?~  err
    ~&  source+success+'Poke succeeded!'
    [~ +>.$]
  ~&  source+error+'Poke failed. Error:'
  ~&  source+error+err
  [~ +>.$]
::
++  reap
  |=  {wir/wire err/(unit tang)}
  ^-  {(list move) _+>.$}
  ?~  err
    ~&  source+success+'Peer succeeded!'
    [~ +>.$]
  ~&  source+error+'Peer failed. Error:'
  ~&  source+error+err
  [~ +>.$]
::
--
