::  Up-ness monitor. Accepts atom url, 'on', or 'off'
::
::::  /===/app/up/hoon
  ::
!:
::
|%
+=  move  [bone card]
+=  card
  $%  [$hiss wire $~ $httr [$purl p=purl:eyre]]
      [$wait wire @da]
  ==
+=  action
  $%  [$on $~]            ::  enable polling('on')
      [$off $~]           ::  disable polling('off)
      [$target p=cord]    ::  set poll target('http:==...')
  ==
--
|_  [bow=bowl:gall on=_| in-progress=_| target=@t]
::
++  poke-atom
  |=  url-or-command=@t
  ^-  [(list move) _+>.$]
  =+  ^-  act=action
      ?:  ?=($on url-or-command)  [%on ~]
      ?:  ?=($off url-or-command)  [%off ~]
      [%target url-or-command]
  ?-  -.act
    $target  [~ +>.$(target p.act)]
    $off  [~ +>.$(on |)]
    $on
      :-  ?:  |(on in-progress)  ~
          :~  :*  ost.bow
                  %hiss
                  /request
                  ~
                  %httr
                  %purl
                  (need (de-purl:html target))
              ==
          ==
      +>.$(on &, in-progress &)
  ==

++  sigh-httr
  |=  [wir=wire code=@ud headers=mess:eyre body=(unit octs)]
  ~&  'arrive here'
  ^-  [(list move) _+>.$]
  ?:  &((gte code 200) (lth code 300))
    ~&  [%all-is-well code]
    :_  +>.$
    [ost.bow %wait /timer (add ~s10 now.bow)]~
  ~&  [%we-have-a-problem code]
  ~&  [%headers headers]
  ~&  [%body body]
  :_  +>.$
  [ost.bow %wait /timer (add ~s10 now.bow)]~
++  wake-timer
  |=  [wir=wire $~]  ^-  [(list move) _+>.$]
  ?:  on
    :_  +>.$
    :~  :*  ost.bow
            %hiss
            /request
            ~
            %httr
            %purl
            (need (de-purl:html target))
        ==
    ==
  [~ +>.$(in-progress |)]
::
++  prep  ~&  target  _`.
::
--
