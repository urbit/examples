::    send simple msgs between ships  ::  short description
::
::
::::  /hoon/mail/ape fds
  ::
/?    310                             ::  require hoon version 310 or below
/-    examples-mail-message                         ::  import message structure
::
::
::::  sivtyv-barnel                   ::  name(s) of author(s)
  ::
!:                                    ::  insert stack trace for this core
|_  $:  hid/bowl                      ::  system data
      sent/(map @da examples-mail-message)         ::  app state data structures
    received/(map @da examples-mail-message)
    ==
++  prep  _`.                        ::  wipe state when app code is changed
::
++  peer                              ::  get 1st time subs. add them to sup
  |=  {pax/path}                      ::  path subscribed
  =+  ^=  ordered-messages            ::  push on ordered list of all messages
      %+  sort                            ::  map with quicksort..
        (~(tap by received))              ::  ..over listified map
      |=  $:  a/(pair @da examples-mail-message)       ::  comparing by time
          b/(pair @da examples-mail-message)
          ==
      (gth p.a p.b)
  :_  +>.$                            ::  return unaltered app state
  :-  :^  ost.hid  %diff  %json       ::  and send updated inbox
      (inbox-to-json ordered-messages)
  ~
::
++  inbox-to-json                     ::  convert received messages to ++json
  |=  messes/(list {@da examples-mail-message})    ::  accept map of time to message
  :-  %a  ^-  (list json)             ::  compose json array of msgs
  %+  turn  messes                    ::  map over listified map of @da to msg
  |=  {tym/time mez/examples-mail-message}          ::  func that makes json msgs
  %^  jobe                            ::  compose ++json object
    tym+(jode tym)                    ::  k-v pair of tym:time
    mez+(msg-to-json mez)             ::  k-v pair of mez:++json msg
  ~ ::
::
++  msg-to-json                       ::  convert msgs to json
  |=  mez/examples-mail-message                     ::  accept msg
  %^  jobe  to+s+(scot %p to.mez)     ::  compose ++json object of to:shipname
     subj+s+subj.mez                  ::  sub:subject
  :-  body+s+(role body.mez)          ::  body:body-of-msg
  ~                                   ::  jobe takes a list, needs ~ terminator
++  poke-examples-mail-message                      ::  receive data with mark of "message"
  |=  {mez/examples-mail-message}
  ?.  =(to.mez our.hid)               ::  unless we are receiving message:
    =.  sent                          ::  store sent message
      (~(put by sent) now.hid src.hid +.mez)   
    :_  +>.$                          ::  return new app stat
    :_  ~
    :^  ost.hid  %poke  /
    [`dock`[to.mez %examples-mail] %examples-mail-message mez]
  =.  received                        ::  if we're receiving: update received
    (~(put by received) now.hid src.hid +.mez) ::
  =+  ^=  ordered-msgs                ::  push on sorted list of messages
      %+  sort                        ::  call sort on
        (~(tap by received))          ::  listified map..
      |=  {a/(pair @da examples-mail-message) b/(pair @da examples-mail-message)} ::
      (gth p.a p.b)                   ::  and gate that compares by @da
  :_  +>.$                            ::  return new app state
  %+  turn  (~(tap by sup.hid))       ::  map over list of subscribers
  |=  {os/bone *}                     
  :+  os  %diff
  :-(%json `json`(inbox-to-json ordered-msgs))       ::  update of new inbox
 ::
++  coup                              ::  handle responses to requests we make
  |=  [sih/*]
  [~ +>]                              ::  ignore and return unaltered core
--
