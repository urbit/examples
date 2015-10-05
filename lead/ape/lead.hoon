::  simple leaderboard
::  accessible at http://localhost:8080/gen/main/pub/lead/fab/
::
::::  /hook/core/lead/app
  ::
/?    314                                               ::  need urbit 314
::
::::  ~talsur-todres, ~fyr
  ::
|%
  ++  axle
    $%  [%0 p=(map ,@t ,@ud)]   
    ==
  ++  gilt                                              ::  subscription frame
    $%  [%hymn p=manx]                                  ::  html tree
        [%json p=json]                                  ::  json
    ==                                                  ::
  ++  gift                                              ::  output action
    $%  [%rust gilt]                                    ::  total update
        [%rush gilt]                                    ::  partial update
        [%mean (unit (pair term (list tank)))]          ::  Error, maybe w/ msg
        [%nice ~]                                       ::  Response message
    ==                                                  ::
  ++  kiss
    $%  [%new-lead name=cord]                           ::  new leader
        [%add-lead name=cord]                           ::  add to leader
    ==
  ++  move  ,[p=bone q=[%give gift]]                    ::  output operation
--
!:
|_  $:  hid=bowl
        vat=axle
    ==
::
++  prep
  |=  old=(unit)
  [~ +>.$]
::
++  peer
  |=  [pax=path]
  ^-  [(list move) _+>]
  ?~  pax
    [[ost.hid %give %rust %json vat-json]~ +>.$]
  :_  +>.$
  :_  ~
  ?+  -.pax
    =-  [ost.hid %give %mean -]
    `[%not-found [%leaf "you need to specify a path"]~]
    %data
      =-  [ost.hid %give %rush %json -]
      (joba %conn %b &)
  ==
::
++  vat-json
  :-  %o
  %-  ~(urn by p.vat)
    |=  [k=@t v=@ud]
  [%n (scot %ud v)]
::
++  deliver
  |=  pkg=[@tas json]
  %+  turn
    %+  skim  (~(tap by sup.hid)) 
    |=  [ost=bone his=ship pax=path]
    ?=([%data ~] pax)
  |=  [ost=bone his=ship pax=path]
  =-  [ost %give %rush %json -]
  (joba pkg)
::
++  poke-json
  |=  [jon=json]
  ^-  [(list move) _+>]
  =+  ^=  jop
      ^-  kiss
      %-  need  %.  jon
      =>  jo  %-  of
      :~  [%new-lead so]
          [%add-lead so]
      ==
  ?-  -.jop
    %new-lead
      ?~  (~(get by p.vat) +.jop)
        =+  newl=[+.jop 0]
        =.  p.vat
          (~(put by p.vat) newl)
        :_  +>.$
        :*  [ost.hid %give %nice ~]
            (deliver %upd-lead (joba -.newl [%n (scot %ud +.newl)]))
        ==
      :_  +>.$
        :_  ~
      =-  [ost.hid %give %mean -]
        `[%not-new [%leaf "That name is already in the leaderboard."]~]
    %add-lead
      =+  ledr=(~(get by p.vat) +.jop)
      ?~  ledr
        :_  +>.$
          :_  ~
        =-  [ost.hid %give %mean -]
          `[%not-new [%leaf "That name is not in the leaderboard."]~]
      =+  scor=(need ledr)
      =.  p.vat
        %-  ~(urn by p.vat)
        |=  [k=@t v=@ud]
          ?:(=(k +.jop) (add v 1) v)
      :_  +>.$
      :*  [ost.hid %give %nice ~]
          (deliver %upd-lead (joba +.jop [%n (scot %ud (add scor 1))]))
      ==
  ==
::
--
