::  store results of foosball games
::
::::  /===/app/foos/hoon
  ::
!:                                    ::  insert stack trace for this core
|%                                    ::  core with data structures
+=  move  [bone card]
+=  card  $%  [$diff diff-content]
          ==
+=  diff-content  $%  [$json json]
                  ==
+=  axle  (list result)               ::  app state: results of all past games
+=  result  $:  bcons=@t  bscore=@ud  ::  record of result
              ycons=@t
            yscore=@ud
            ==
--
::
::
|_  [bow=bowl:gall vat=axle]          ::  system data & app state data struct
::
++  prep  _`.                         ::  wipe state when app code is changed
::
++  poke-json                         ::  receive JSON
  |=  jon=json
  ^-  [(list move) _+>.$]
  ~&  poked+jon
  =+  ^-  parsedresult/result         ::  push on result of reparsing JSON
      ~|  bad-json+jon                ::  produce p in stack trace if q crashes
      %-  need                        ::  crash if ~ (on parse-fail)
      %-  =>  dejs-soft:format        ::  from ++jo get "ot", obj-tuple parser
                                      ::  parse tuple from ++json object "jon".
      (ot bcons+so bscore+ni ycons+so yscore+ni ~)
      jon
  =.  vat  [parsedresult vat]         ::  change state to [newresult oldstate]
  :_  +>.$                            ::  return (changed) app core
  spam                                ::  and update subscribers
::
++  result-to-json                    ::  reassemble ++json to respond to client
  |=  result
  ^-  json
  %-  pairs:enjs:format  :~           ::  produce ++json object
    bcons+[%s bcons]                  ::  produce ++json string
    ycons+[%s ycons]
    bscore+(numb:enjs:format bscore)  ::  produce ++json number from @u
    yscore+(numb:enjs:format yscore)
  ==
::
++  spam                              ::  update subscribers
  ^-  (list move)
  %+  murn  ~(tap by sup.bow)         ::  ∀
  |=  [ost=bone his=ship pax=path]
  ?^  pax  ~  %-  some                ::  empty paths
  [ost %diff ~+((peek his pax))]      ::  update state
::
::  called whenever ther is a change in state.
::  sends the result to all subscribers.
++  peek
  |=  [his=ship pax=path]
  ^-  diff-content
  :-  %json
  `json`[%a (turn vat result-to-json)]::  send all results as ++json to client
::
++  peer                              ::  subscription shim
  |=  pax=path
  ^-  [(list move) _+>.$]
  ?^  pax  `+>
  [[ost.bow %diff (peek src.bow pax)]~ +>]
::
--
