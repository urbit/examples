::  Simple social network
::
::  hoon/mesh/app
::
/-  mesh
[. mesh]
!:
|%
++  move  {bone card}
++  card  $%  {$peer wire dock path}
              {$pull wire dock $~}
              {$diff diff}
          ==
++  diff  $%  {$mesh-friends color friends}
              {$mesh-network color network}
          ==
--
::
|_  {bow/bowl {col/color net/network}}                  ::<  color, social net.
::
::++  prep  _`.
++  poke-mesh-color
  |=  col/color
  =.  ^col  col
  ~&  mesh+'Color set! Notifying subscribers:'
  ~&  mesh+color+col
  [spam +>.$]
::
++  poke-mesh-friend
  |=  fen/friend
  ^-  (quip move +>.$)
  ~&  :-  %mesh
    (crip (weld (weld "Friending " (scow %p fen)) "!"))
  :_  +>.$
  :_  ~
  :*  ost.bow
      %peer
      /subscribe
      [fen %mesh]
      /mesh-friends
  ==
::
++  reap
  |=  {wire err/(unit tang)}
  ?^  err  (mean u.err)
  ~!  +<.reap
  =.  net
    =/  my-net  (~(get ju net) our.bow)
    ?:  (~(has by my-net) src.bow)
      net
    =.  my-net  (~(put by my-net) src.bow '')
    (~(put by net) our.bow my-net)
  ~&  mesh+'Friend subscribe successful!'
  ~&  mesh+ship+src.bow
  [spam +>.$]
::
++  coup
  |=  {wire err/(unit tang)}
  ?^  err  (mean u.err)
  [~ +>.$]
::
++  diff-mesh-friends
  |=  {wir/wire col/color fes/friends}
  ^-  (quip move +>.$)
  ~&  mesh+diff+'Network update!'
  ~&  mesh+diff+[source+src.bow color+col friends+fes]
  =+  old-net=net
  =.  net  (~(put by net) src.bow fes)
  =.  net
    =/  my-net  (~(get ju net) our.bow)
    ?.  (~(has by my-net) src.bow)  net
    =.  my-net  (~(put by my-net) src.bow col)
    (~(put by net) our.bow my-net)
  ?:  =(net old-net)  [~ +>.$]
  [spam +>.$]
::
++  spam
  %+  murn  (~(tap by sup.bow))
  |=  {ost/bone shp/ship pax/path}
  %+  bind  ~+((peek shp pax))
  |=(dif/diff [ost %diff dif])
::
++  peek
  |=  {src/ship pax/path}
  ^-  (unit diff)
  ?~  pax   ~
  ?+  i.pax  ~
    $web
      `(peek-web src t.pax)
    $mesh-friends
      `(peek-mesh-friends src t.pax)
  ==
::
++  peek-web
  |=  ^
  [%mesh-network col net]
++  peek-mesh-friends
  |=  ^
  :-  %mesh-friends
  [col (~(get ju net) our.bow)]
::
++  peer-web
  |=  pax/path
  ~&  pax
  [[ost.bow %diff (peek-web src.bow pax)]~ +>.$]
::
++  peer-mesh-friends
  |=  pax/path
  ^-  (quip move +>.$)
  ~&  mesh+'Someone friended you!'
  ~&  mesh+ship+src.bow
  :_  +>.$
  :_  ~
  :*  ost.bow
      %diff
      (peek-mesh-friends src.bow pax)
  ==
::
--
