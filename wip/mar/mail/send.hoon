::  Required sample needed to send a mail-message
::
::::  /===/mar/mail/send/hoon
  ::
/-  mail-send
!:
|_  mail-send
++  grab
  |%
  +=  noun
    mail-send
  ++  json
    |=  jon/^json
    ^-  mail-send
    %-  need
    %.  jon
    =>  dejs-soft:format
    (ot to+(ci (slat %p) so) sub+so bod+(cu to-wain:format so) ~)
  --
--