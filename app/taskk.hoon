::
::
:::: /hoon/taskk/app
  ::
/?    310
/-  taskk
[taskk .]
|%
  ++  card  
  $%  {$info wire @p toro}                              :: write to clay
      {$warp wire sock riff}                            :: watch a dir
      {$diff $taskk-create-issue tape tape tape}        :: update subscribers
      {$diff $json json} 
  ==
  ++  move  {bone card}                                  
--                                               
!:                                               
|_  {hid/bowl state/{subp/path wpat/path}}                         
::
++  poke-taskk-create-issue
  |=  iss/issue
  ^-  (quip move +>.$)
  :_  +>.$
  %+  welp                                              
    %+  turn                                            :: notify all subscribers
      (prey subp.state hid)
    |=  {o/bone *}  
    :-  o  
    :+  %diff 
      %taskk-create-issue
    iss
  :~  :-  ost.hid                                       :: list of moves
      :^    %info                                       
          /writing
        our.hid
      %+  foal
        %+  welp 
          wpat.state
        :~  (crip pha.iss)
            (crip iss.iss)
            %md
        ==
      [%md !>((crip des.iss))]
  ==
::  delete issue
++  poke-taskk-delete-issue
  |=  iss/issue-ref
  ~&  %delete-issue-called
  ^-  (quip move +>.$)
  :_  +>.$
  :~  :-  ost.hid
      :^    %info
          /deleting
        our.hid
      %-  fray
      %+  welp
        wpat.state
      :~  (crip pha.iss)
          (crip iss.iss)
          %md
      ==
  ==
::
::  change board phase
++  poke-taskk-change-phase
  |=  iss/change-ref
  ~&  %change-phase-called
  ^-  (quip move +>.$)
  =/  inp/path
  %+  welp
    wpat.state
  :~  (crip fpha.iss)
      (crip iss.iss)
      %md
  ==
  :_  +>.$
  :~  :-  ost.hid
      :^    %info
          /moving
        our.hid
      %+  furl
        %-  fray
        inp
      %+  foal 
        %+  welp
          wpat.state
        :~  (crip fpha.iss)
            (crip iss.iss)
            %md
        ==
      [%md !>(.^(* %cx inp))]
  ==
::  request a board
++  poke-taskk-request-board
  |=  board/{ho/tape bo/tape}
  ^-  (quip move +>.$)
  :_  +>.$ 
  %+  turn  
    (prey subp.state hid)
  |=  {o/bone *}
  :-  o
  :+  %diff
    %json
  %-  jobe
  :~  ['action-completed' (jape "request-board")]
      ['response-data' (crawl-path wpat.state)]
  ==
::
++  crawl-path
  |=  pax/path
  |-  ^-  json
  =+  a=.^(arch cy+pax)
  ?~  fil.a
    :-  %a
      %+  turn
        (sort (~(tap by dir.a)) aor)
        |=  {p/@t $~}
          [%a [[%s p] (crawl-path (welp pax /[p])) ~]]
  =+  txt=.^(@t cx+pax)
  [%s txt]
::
::  subscribe to taskk front end
::
++  peer
  |=  pax/path
  ~&  [%subscribed-to pax]
  :_  %=  +>.$
        state  :-  pax
               %+  welp
                 %+  tope
                   [our.hid %home da+now.hid] 
                 (flop (limo ['app' 'taskk' ~]))
               pax
      ==
  %+  welp
    (watch-dir (welp /app/taskk pax))
  :~  :^    ost.hid 
          %diff 
        %json
      %-  jobe 
      ~[['action-completed' (jape "connect")]]
  ==
::
::  watch board dir for changes
++  watch-dir
  |=  a/path
  ::~&  [%watch-dir a]
  ^-  (list move)
  :~  :-  ost.hid
      :^    %warp
          a
        [our.hid our.hid]
      :-  %home 
      :-  ~ 
      [%next %z da+now.hid a]
  ==
::will update subscribers that node changed
::once that works reasonably
::++  writ                                         
::  |=  {way/wire rot/riot}
::  ~&  [%rot rot]
::  =/  car/card
::  :+  %diff
::    %json
::  %+  joba
::    'updated'
::  (jape "true")
::  :-  %+  welp
::        %+  turn 
::          (prey subp.state hid)
::        |=  {o/bone *}
::        [o car]
::  [(watch-dir way) +>.$]
++  prep  _`.
--
