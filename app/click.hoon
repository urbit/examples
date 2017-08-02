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
  ~&  click+clicked++(cis)
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
    ~&  click+success+'Poke succeeded!'
    [~ +>.$]
  ~&  click+error+'Poke failed. Error:'
  ~&  click+error+err
  [~ +>.$]
::
++  reap
  |=  {wir/wire err/(unit tang)}
  ^-  (quip move +>.$)
  ?~  err
    ~&  click+success+'Peer succeeded!'
    [~ +>.$]
  ~&  click+error+'Peer failed. Error:'
  ~&  click+error+err
  [~ +>.$]
::
--
