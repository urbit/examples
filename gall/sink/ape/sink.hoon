/?    314
|%
++  move  ,[bone card]
++  card
  $%  [%peer wire [@p term] path]
      [%pull wire [@p term] ~]
  ==
--
!:
|_  [bowl available=?]
++  poke-noun
  |=  arg=*
  ^-  [(list move) _+>.$]
  ?:  &(=(%on arg) available)
    [[[ost %peer /subscribe [our %source] /the-path] ~] +>.$(available |)]
  ?:  &(=(%off arg) !available)
    [[[ost %pull /subscribe [our %source] ~] ~] +>.$(available &)]
  ~&  ?:(available %not-subscribed %subscribed)
  [~ +>.$]
++  diff-noun
  |=  [wir=wire arg=*]
  ^-  [(list move) _+>.$]
  ~&  [%recieved-data arg]
  [~ +>.$]
++  reap
  |=  [wir=wire error=(unit tang)]
  ^-  [(list move) _+>.$]
  ?~  error
    ~&  %successfully-subscribed
    [~ +>.$]
  ~&  [%subscription-failed error]
  [~ +>.$]
--
