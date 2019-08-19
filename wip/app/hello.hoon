::  Get a hello from your urbit on the web and say 
::  hello back
::
::::  /===/app/hello/hoon
  ::
/-  hello                                               ::<  import /sur/hello
[. hello]                                               ::<  add core to subject
!:
|%
+=  move  [bone card]                                   ::<  arvo event
+=  card  $%  [%diff diff-contents]
          ==
+=  diff-contents  $%  [%hello-world hello-world]       ::<  arvo packet
                   ==
--
::
|_  [bow=bowl:gall elo=hello-world]                     ::<  app state
::
++  prep                                                ::<  called on |start
  |=  *
  ^-  [(list move) _+>.$]
  [~ +>.$(elo 'Hello, world!')]                         ::<  set the app state
::
++  peer-web
  |=  pax=path
  ^-  [(list move) _+>.$]
  ~&  hello+peered+'Peered from the web!'
  [~[[ost.bow %diff %hello-world elo]] +>.$]
::
++  poke-hello-world
  |=  elo=hello-world
  ^-  [(list move) _+>.$]
  ?>  =(elo 'Hello, world!')
  ~&  hello+poked+elo
  [~ +>.$]
::
++  reap
  |=  [wir=wire err=(unit tang)]
  ^-  [(list move) _+>.$]
  ?~  err
    ~&  hello+success+'Peer succeeded!'
    [~ +>.$]
  ~&  hello+error+'Peer failed. Error:'
  ~&  hello+error+err
  [~ +>.$]
::
++  coup
  |=  [wir=wire err=(unit tang)]
  ^-  [(list move) _+>.$]
  ?~  err
    ~&  hello+success+'Poke succeeded!'
    [~ +>.$]
  ~&  hello+error+'Poke failed. Error:'
  ~&  hello+error+err
  [~ +>.$]
::
--
