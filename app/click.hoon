/-  click
[. click]
!:
|%
++  move  {bone $diff $click-clicks clicks}
--
::
|_  {bow/bowl cis/clicks}
::
++  poke-click-click
  |=  cik/^click                                        ::<  the sur not the core
  ^-  (quip move +>.$)
  ~&  [%poked +(cis)]
  :_  +>.$(cis +(cis))
  %+  turn  (prey /click bow)
  |=  {o/bone *}
  [o %diff %click-clicks +(cis)]
::
++  peer-click
  |=  pax/path
  ^-  (quip move +>.$)
  [~[[ost.bow %diff %click-clicks cis]] +>.$]
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
