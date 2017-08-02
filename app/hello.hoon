/-  hello                                               ::<  import /sur/hello
[. hello]                                               ::<  add core to subject
!:
|%
++  move  {bone card}                                   ::<  arvo event
++  card  $%  {$diff $hello-world hello-world}          ::<  arvo packet
          ==
--
::
|_  {bow/bowl elo/hello-world}                          ::<  app state
::
++  prep                                                ::<  called on |start
  |=  *
  ^-  (quip move +>.$)
  [~ +>.$(elo 'Hello, world!')]                         ::<  set the app state
::
++  peer-web
  |=  pax/path
  ^-  (quip move +>.$)
  ~&  hello+peered+'Peered from the web!'
  [~[[ost.bow %diff %hello-world elo]] +>.$]
::
++  poke-hello-world
  |=  elo/hello-world
  ^-  (quip move +>.$)
  ?>  =(elo 'Hello, world!')
  ~&  hello+poked+elo
  [~ +>.$]
::
++  reap
  |=  {wir/wire err/(unit tang)}
  ^-  (quip move +>.$)
  ?~  err
    ~&  hello+success+'Peer succeeded!'
    [~ +>.$]
  ~&  hello+error+'Peer failed. Error:'
  ~&  hello+error+err
  [~ +>.$]
::
++  coup
  |=  {wir/wire err/(unit tang)}
  ^-  (quip move +>.$)
  ?~  err
    ~&  hello+success+'Poke succeeded!'
    [~ +>.$]
  ~&  hello+error+'Poke failed. Error:'
  ~&  hello+error+err
  [~ +>.$]
::
--
