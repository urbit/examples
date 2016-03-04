::  Up-ness monitor. Accepts atom url, 'on', or 'off'
::
::::  /hoon/up/examples/app
  ::
/?    314
|%
++  move  {bone card}
++  card
  $%  {$hiss wire $~ $httr {$purl p/purl}}
      {$wait wire @da}
  ==
++  action
  $%  {$on $~}            ::  enable polling('on')
      {$off $~}           ::  disable polling('off)
      {$target p/cord}    ::  set poll target('http://...')
  ==
--
|_  {hid/bowl on/_| in-progress/_| target/@t}
++  poke-atom
  |=  url-or-command/@t  ^-  (quip move +>)
  =+  ^-  act/action
      ?:  ?=($on url-or-command)  [%on ~]
      ?:  ?=($off url-or-command)  [%off ~]
      [%target url-or-command]
  ?-  -.act
    $target  [~ +>.$(target p.act)]
    $off  [~ +>.$(on |)]
    $on
      :-  ?:  |(on in-progress)  ~
          [ost.hid %hiss /request ~ %httr %purl (need (epur target))]~
      +>.$(on &, in-progress &)
  ==
::

::  ~&  'i get here'
::  ^-  {(list move) _+>.$}
::  ?:  =('off' url)
::    [~ +>.$(on |)]
::  ?:  =('on' url)
::    :_  +>.$(on &, in-progress &)
::    ?:  |(on in-progress)
::      ~
::    [ost.hid %them /request ~ (need (epur target)) %get ~ ~]~
::  [~ +>.$(target url)]
++  sigh-httr
  |=  {wir/wire code/@ud headers/mess body/(unit octs)}
  ~&  'arrive here'
  ^-  {(list move) _+>.$}
  ?:  &((gte code 200) (lth code 300))
    ~&  [%all-is-well code]
    :_  +>.$
    [ost.hid %wait /timer (add ~s10 now.hid)]~
  ~&  [%we-have-a-problem code]
  ~&  [%headers headers]
  ~&  [%body body]
  :_  +>.$
  [ost.hid %wait /timer (add ~s10 now.hid)]~
++  wake-timer
  |=  {wir/wire $~}  ^-  (quip move +>)
  ?:  on
    :_  +>.$
    [ost.hid %hiss /request ~ %httr %purl (need (epur target))]~
  [~ +>.$(in-progress |)]
::
++  prep  ~&  target  _`.  ::
--
