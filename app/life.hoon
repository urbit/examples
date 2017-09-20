:: Game of life as app
/?  314
::
!:
::
|%
++  action
  $%  {$start size/(unit @)}                            :: reset game state
      {$toggle s/(list spot)}
      {$step n/(unit @)}
      {$debug $~}
  ==
::
++  game   $:  size/@
               steps/@
               b/board
           ==
++  board  (list (list ?))
++  spot   {r/@ c/@}
--
::
::
|_  {bowl g/game}
::
::  ++  prep  ~&  'prep life'  _`.
::
++  poke-noun
  |=  a/action
  ^-  {(list move) _+>.$}
  ?-  -.a
    $start
      =+  size=?~(size.a 10 u.size.a)
      ~&  [%starting-at-size size]
      [~ +>.$(g (~(new go g) size))]
    $toggle
      ~&  [%toggling-spots s.a]
      :-   ~
      +>.$(g (~(toggle go g) s.a))
    $step
      =+  n=?~(n.a 1 u.n.a)
      ~&  [%stepping-times n]
      [~ +>.$(g (~(step go g) n))]
    $debug
      ~&  [%debug g]
      [~ +>.$]
  ==
::
:::: game operations
::
++  go
  |_  mag/game
  ++  new  |=(size/@ `game`[size 0 (empty:bo size)])    ::
  ::
  ++  step
    |=  n/@
    |-  ^-  game
    ?:  =(0 n)
      mag
    :: Is there a way to accomplish this with other glyphs and no variable?
    =+  nu=b:(toggle (skim all swap:bo))                ::  toggle all that should swap states
    $(mag mag(b nu, steps +(steps.mag)), n (dec n))
  ::
  ++  all                                               :: all spots
    ^-  (list spot)
    ~+                                                  :: cache
    %-  zing                                            :: flatten
    %+  turn  (range size.mag)                          :: (list (list spot))
    |=  r/@
    %+  turn  (range size.mag)
    |=  c/@
    `spot`[r c]
  ::
  ++  toggle                                            :: new game w/ spots toggled
    |=  spots/(list spot)
    |-  ^-  game
    ?~  spots
      mag
    $(spots t.spots, mag mag(b ~(toggle so:bo i.spots)))
  ::
  :: board operations
  ::
  ++  bo
    |%
    ++  empty  |=(size/@ (reap size (reap size |)))     :: empty board
    ++  get    |=(s/spot (snag c.s (snag r.s b.mag)))   :: val at spot
    ++  swap   |=(s/spot !=(~(next so s) (get s)))      :: needs to be toggled?
    ::
    :: spot operations
    ::
    ++  so
      |_  s/spot
      ++  toggle
        ^-  board
        (weld (weld head (limo ~[trow])) tail)
      ++  next                                          :: should be alive?
        =+  l=(skid adj |=(a/? a))
        ?.  (get s)                                     :: if not alive (if dead)
          =(3 (lent p.l))                               :: dead -> alive
        |(=(3 (lent p.l)) =(2 (lent p.l)))              :: alive -> still alive
      ::
      ++  adj                                           :: list of adjacent
        (limo ~[nw nc ne cw ce sw sc se])
      ::
      ::  adjacent sides
      ::
      ++  nw
        ?:  |(max-n max-w)  |
        (get (spot (dec r.s) (dec c.s)))
      ++  nc
        ?:(max-n | (get (spot (dec r.s) c.s)))
      ++  ne
        ?:  |(max-n max-s)  |
        (get (spot (dec r.s) +(c.s)))
      ++  cw
        ?:(max-w | (get (spot r.s (dec c.s))))
      ++  ce
        ?:(max-s | (get (spot r.s +(c.s))))
      ++  sw
        ?:  |(max-e max-w)  |
        (get (spot +(r.s) (dec c.s)))
      ++  sc
        ?:(max-e | (get (spot +(r.s) c.s)))
      ++  se
        ?:  |(max-e max-s)  |
        (get (spot +(r.s) +(c.s)))
      ::
      ++  max-n  (lte r.s 0)                            :: off top
      ++  max-w  (lte c.s 0)                            :: off left
      ++  max-e  (gte +(r.s) size.mag)                  :: off right
      ++  max-s  (gte +(c.s) size.mag)                  :: off bottom
      ::
      ::  TODO: better names
      ::
      ++  head  (scag r.s b.mag)
      ++  tail  (slag +(r.s) b.mag)
      ::
      ++  trow                                          :: toggled row
        =|  i/@
        =+  r=(snag r.s b.mag)
        |-  ^-  (list ?)
        ?~  r
          ~
        :-  ?:(=(i c.s) !i.r i.r)
        $(i +(i), r t.r)
      --
    --
  --
::
++  range                                                :: range exclusive
  |=  n/@
  =|  i/@
  |-  ^-  (list @)
  ?:  (gte i n)
    ~
  [i $(i +(i))]
::
--
