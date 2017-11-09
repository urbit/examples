::  Poke your urbit from the web
::
::::  /===/app/click/hoon
  ::
/-  click
[. click]
!:
|%
+=  move  [bone card]
+=  card  $%  [%diff diff-content]
          ==
+=  diff-content  $%  [%click-clicks clicks]
                  ==
--
::
|_  [bow=bowl:gall cis=clicks]
::
++  prep  _`.
::
++  poke-click-click
  |=  cik=^click                                        ::<  the sur not the core
  ^-  [(list move) _+>.$]
  ~&  click+clicked++(cis)
  :_  +>.$(cis +(cis))
  %+  turn  (prey:pubsub:userlib /click bow)
  |=  [o=bone *]
  [o %diff %click-clicks +(cis)]
::
++  peer-click
  |=  pax=path
  ^-  [(list move) _+>.$]
  [~[[ost.bow %diff %click-clicks cis]] +>.$]
::
++  coup
  |=  [wir=wire err=(unit tang)]
  ^-  [(list move) _+>.$]
  ?~  err
    ~&  click+success+'Poke succeeded!'
    [~ +>.$]
  ~&  click+error+'Poke failed. Error:'
  ~&  click+error+err
  [~ +>.$]
::
++  reap
  |=  [wir=wire err=(unit tang)]
  ^-  [(list move) _+>.$]
  ?~  err
    ~&  click+success+'Peer succeeded!'
    [~ +>.$]
  ~&  click+error+'Peer failed. Error:'
  ~&  click+error+err
  [~ +>.$]
::
--
