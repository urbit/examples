/+  *server
/=  tile-js
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/click/js/tile
  /|  /js/
      /~  ~
  ==
=,  format
|%
+$  effect  (pair bone syscall)
+$  poke
  $%  [%launch-action [@tas path @t]]
  ==
+$  syscall
  $%  [%poke wire dock poke]
      [%http-response =http-event:http]
      [%connect wire binding:eyre term]
      [%diff %json json]
  ==
--
|_  [bol=bowl:gall cis=@]
++  this  .
++  bound
  |=  [wir=wire success=? binding=binding:eyre]
  ^-  (quip effect _this)
  [~ this]
++  prep
  |=  old=(unit @)
  ^-  (quip effect _this)
  =/  launcha
    [%launch-action [%click /clicktile '/~click/js/tile.js']]
  :_
  ?~  old
    this
  this(cis (need old))
  :~
    [ost.bol %connect / [~ /'~click'] %click]
    [ost.bol %poke /click [our.bol %launch] launcha]
  ==
++  peer-clicktile
  |=  pax=path
  [[ost.bol %diff %json *json]~ this]
++  send-tile-diff
  |=  jon=json
  ^-  (list effect)
  %+  turn  (prey:pubsub:userlib /clicktile bol)
  |=  [=bone ^]
  [bone %diff %json jon]
++  poke-json
  |=  jon=json
  ^-  (quip effect _+>.$)
  ~&  (weld "Click recieved from Landscape! ~ Total Clicks: " (scow %ud cis))
  :_  +>.$(cis +(cis))
  %+  turn  (prey:pubsub:userlib /clicktile bol)
  |=  [=bone ^]
  [bone %diff %json jon]
++  poke-handle-http-request
  %-  (require-authorization:app ost.bol effect this)
  |=  =inbound-request:eyre
  ^-  (quip effect _this)
  =/  request-line  (parse-request-line url.request.inbound-request)
  =/  back-path  (flop site.request-line)
  =/  name=@t
    =/  back-path  (flop site.request-line)
    ?~  back-path
      ''
    i.back-path
  ?~  back-path
    [[ost.bol %http-response not-found:app]~ this]
  ?:  =(name 'tile')
    [[ost.bol %http-response (js-response:app tile-js)]~ this]
  [[ost.bol %http-response not-found:app]~ this]
--
