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
|_  {bow/bowl val/?}                                    ::< available? (y or n)
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
        unsubscribed+'You are now unsubscribed!'
      subscribed+'You are now subscribed!'
  [~ +>.$]
::
++  diff-noun
  |=  {wir/wire non/*}
  ^-  (quip move +>.$)
  ~&  received-data+'%sink: You got something!'
  ~&  data+non
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
