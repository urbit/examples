::  Sets up a simple subscription to source.hoon
::
::::  /===/app/sink/hoon
  ::
!:
|%
+=  move  [bone card]
+=  card  $%  [%peer wire dock path]
              [%pull wire dock ~]
          ==
--
::
|_  [bow=bowl:gall val=?]                                    ::<  available? (y or n)
::
++  poke-noun
  |=  non=*
  ^-  [(list move) _+>.$]
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
  |=  [wir=wire non=*]
  ^-  [(list move) _+>.$]
  ~&  sink+received-data+' You got something!'
  ~&  sink+data+non
  [~ +>.$]
::
++  coup
  |=  [wir=wire err=(unit tang)]
  ^-  [(list move) _+>.$]
  ?~  err
    ~&  sink+success+'Poke succeeded!'
    [~ +>.$]
  ~&  sink+error+'Poke failed. Error:'
  ~&  sink+error+err
  [~ +>.$]
::
++  reap
  |=  [wir=wire err=(unit tang)]
  ^-  [(list move) _+>.$]
  ?~  err
    ~&  sink+success+'Peer succeeded!'
    [~ +>.$]
  ~&  sink+error+'Peer failed. Error:'
  ~&  sink+error+err
  [~ +>.$]
::
--
