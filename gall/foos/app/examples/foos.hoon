::    store results of foosball games ::  short descripton
::    accessible at http://localhost:8080/home/pub/foos/fab/
::
::::  /hoon/foos/ape
  ::
/?  310                               ::  require hoon version 310 or below
::
::
::::  sivtyv-barnel                   ::  name(s) of author(s)
  ::
!:                                    ::  insert stack trace for this core
|%                                    ::  core with data structures
++  axle  (list result)               ::  app state: results of all past games
++  result  $:  bcons/@t  bscore/@ud  ::  record of result
              ycons/@t
            yscore/@ud
            ==
--
::
!:                                    ::  insert stack trace for this core
|_  {hid/bowl vat/axle}               ::  system data & app state data struct 
++  prep  _`.                        ::  wipe state when app code is changed
::
++  poke-json                         ::  receive JSON
  |=  jon/json
  ~&  poked+jon
  =+  ^-  parsedresult/result         ::  push on result of reparsing JSON
      ~|  bad-json+jon                ::  produce p in stack trace if q crashes
      %-  need                        ::  crash if ~ (on parse-fail)
      %-  =>  jo                      ::  from ++jo get "ot", obj-tuple parser
                                      ::  parse tuple from ++json object "jon".
      (ot bcons+so bscore+ni ycons+so yscore+ni ~)
      jon
  =.  vat  [parsedresult vat]         ::  change state to [newresult oldstate]
  :_  +>.$                            ::  return (changed) app core
  spam                                ::  and update subscribers
::
++  result-to-json                    ::  reassemble ++json to respond to client
  |=  result
  %-  jobe  :~                        ::  produce ++json object
    bcons+[%s bcons]                  ::  produce ++json string
    ycons+[%s ycons]
    bscore+(jone bscore)              ::  produce ++json number from @u
    yscore+(jone yscore)
  ==
::
++  spam                              ::  update subscribers
  %+  murn  (~(tap by sup.hid))       ::  ∀
  |=  {ost/bone his/ship pax/path}
  ?^  pax  ~  %-  some                ::  empty paths
  [ost %diff ~+((peek his pax))]      ::  update state
::
::  called whenever ther is a change in state.
::  sends the result to all subscribers.
++  peek
  |=  {his/ship pax/path}
  :-  %json 
  `json`[%a (turn vat result-to-json)]::  send all results as ++json to client
::
++  peer                              ::  subscription shim
  |=  pax/path
  ?^  pax  `+>
  [[ost.hid %diff (peek src.hid pax)]~ +>]
--

