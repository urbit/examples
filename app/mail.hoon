::  Send simple messages between urbits
::
::::  /===/app/mail/hoon
  ::
/-  mail-message, mail-send
[. mail-message mail-send]
::
!:
|%
++  move  {bone card}
++  card  $%  {$poke path dock poke-contents}
              {$diff diff-contents}
          ==
++  poke-contents  $%  {$mail-message mail-message}
                   ==
++  diff-contents  $%  {$json json}
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
  ^-  {(list move) _+>.$}
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
  ^-  {(list move) _+>.$}
  =/  out/mail-message
    [now.bow our.bow to.sen sub.sen bod.sen]
  =.  ^sen
    [out ^sen]
  ~&  mail+sending+'Sending message!'
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
  ~&  mail+received+'New message!'
  ~&  mail+time+tim.mes
  ~&  mail+from+fom.mes
  ~&  mail+to+to.mes
  ~&  mail+sub+sub.mes
  ~&  mail+bod+bod.mes
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
  ^-  {(list move) _+>.$}
  ?~  err
    ~&  mail+success+'Message sent!'
    [~ +>.$]
  ~&  mail+error+'Message failed to send. Error:'
  ~&  mail+error+err
  [~ +>.$]
::
--
