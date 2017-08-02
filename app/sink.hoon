::  Sets up a simple subscription to source.hoon
::
::  /hoon/sink/app
::
!:
|%
++  move  {bone card}
++  card
  $%  {$peer wire {@p term} path}
      {$pull wire {@p term} $~}
  ==
--
::
|_  {bow/bowl val/?}                                    ::<  available? (y or n)
::
++  poke-noun
  |=  non/*
  ^-  (quip move +>.$)
  ?:  &(=(%on non) val)
    :_  +>.$(val |)
    :~  :*  ost.bow
            %peer
            /subscribe
            [our.bow %source]
            /example-path
        ==
    ==
  ?:  &(=(%off non) !val)
    :_  +>.$(val &)
    ~[[ost.bow %pull /subscribe [our.bow %source] ~]]
  ~&  ?:  val
        sink+unsubscribed+'You are now unsubscribed!'
      sink+subscribed+'You are now subscribed!'
  [~ +>.$]
::
++  diff-noun
  |=  {wir/wire non/*}
  ^-  (quip move +>.$)
  ~&  sink+received-data+' You got something!'
  ~&  sink+data+non
  [~ +>.$]
::
++  coup
  |=  {wir/wire err/(unit tang)}
  ^-  (quip move +>.$)
  ?~  err
    ~&  sink+success+'Poke succeeded!'
    [~ +>.$]
  ~&  sink+error+'Poke failed. Error:'
  ~&  sink+error+err
  [~ +>.$]
::
++  reap
  |=  {wir/wire err/(unit tang)}
  ^-  (quip move +>.$)
  ?~  err
    ~&  sink+success+'Peer succeeded!'
    [~ +>.$]
  ~&  sink+error+'Peer failed. Error:'
  ~&  sink+error+err
  [~ +>.$]
::
--
