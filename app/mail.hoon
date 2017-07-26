::  Send simple msgs between ships  ::  short description
::
::  /hoon/mail/app
::
/-  mail-message, mail-send
[. mail-message mail-send]
::
!:
|%
++  move  {bone card}
++  card  $%  {$poke path dock mark *}
              {$diff mark *}
          ==
--
::
|_  $:  bow/bowl
        sen/(list mail-message)                         ::<  sent messages
        rec/(list mail-message)                         ::<  received messages
    ==
::
++  prep  _`.
::
++  peer
  |=  pax/path
  ^-  (quip move +>.$)
  =/  ordered-messages/(list mail-message)
    %+  sort
      rec
    |=  {a/mail-message b/mail-message}
    (gth tim.a tim.b)
  :_  +>.$
  :_  ~
  :^  ost.bow  %diff  %json
  (inbox-to-json ordered-messages)
::
++  inbox-to-json
  |=  box/(list mail-message)
  ^-  json
  :-  %a
  %+  turn  box
  |=  a/mail-message
  %-  jobe
  :~  tim+(jode tim.a)
      fom+s+(scot %p fom.a)
      to+s+(scot %p to.a)
      sub+s+sub.a
      bod+s+(role bod.a)
  ==
++  poke-mail-send
  |=  sen/mail-send                                     ::<  to, subject, body
  ^-  (quip move +>.$)
  =/  out/mail-message
    [now.bow our.bow to.sen sub.sen bod.sen]
  =.  ^sen
    [out ^sen]
  ~&  sending+'Sending message!'
  :_  +>.$
  :~  :*  ost.bow
          %poke
          /
          [[to.out %mail] %mail-message out]
      ==
  ==
++  poke-mail-message
  |=  mes/mail-message
  ?>  =(to.mes our.bow)
  ~&  received+'New message!'
  ~&  time+tim.mes
  ~&  from+fom.mes
  ~&  to+to.mes
  ~&  sub+sub.mes
  ~&  bod+bod.mes
  =.  rec
    [mes rec]
  =/  ord/(list mail-message)                           ::<  ordered messages
    %+  sort
      rec
    |=  {a/mail-message b/mail-message}
    (gth tim.a tim.b)
  :_  +>.$
  %+  turn  (~(tap by sup.bow))
  |=  {o/bone *}
  [o %diff %json `json`(inbox-to-json ord)]
 ::
++  coup
  |=  {wir/wire err/(unit tang)}
  ^-  (quip move +>.$)
  ?~  err
    ~&  success+'Message sent!'
    [~ +>.$]
  ~&  error+'Message failed to send. Error:'
  ~&  error+err
  [~ +>.$]
::
--
