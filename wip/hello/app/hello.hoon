/+  *server
/=  tile-js
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/hello/js/tile
  /|  /js/
      /~  ~
  ==
=,  format
|%
::
+$  effect  (pair bone syscall)
::
+$  poke
  $%  [%launch-action [@tas path @t]]
  ==
::
+$  syscall
  $%  [%poke wire dock poke]
      [%http-response =http-event:http]
      [%connect wire binding:eyre term]
      [%diff %json json]
  ==
::
--
::
|_  [bol=bowl:gall ~]
:: "this" is a shorthand for returning the state.
++  this  .
::
++  bound
  |=  [wir=wire success=? binding=binding:eyre]
  ^-  (quip effect _+>.$)
  [~ +>.$]
::
++  prep
  |=  old=(unit ~)
  ^-  (quip effect _this)
  =/  launcha
    [%launch-action [%hello /hellotile '/~hello/js/tile.js']]
  :_  this
  :~
    [ost.bol %connect / [~ /'~hello'] %hello]
    [ost.bol %poke /hello [our.bol %launch] launcha]
  ==
::
::
++  peer-hellotile
  |=  pax=path
  ^-  (quip effect _this)
  [[ost.bol %diff %json *json]~ this]
::
::
++  poke-json
  |=  jon=json
  ^-  (quip effect _+>.$)
  ~&  'Hello received from the Landscape interface!'
  ~&  jon
  :_  +>.$
  %+  turn  (prey:pubsub:userlib /testingtile bol)
  |=  [=bone ^]
  [bone %diff %json jon]
::
++  send-tile-diff
  |=  jon=json
  ^-  (list effect)
  %+  turn  (prey:pubsub:userlib /hellotile bol)
  |=  [=bone ^]
  [bone %diff %json jon]
::
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
  ::
  ?~  back-path
    [[ost.bol %http-response not-found:app]~ this]
  ?:  =(name 'tile')
    [[ost.bol %http-response (js-response:app tile-js)]~ this]
  [[ost.bol %http-response not-found:app]~ this]
::
--
