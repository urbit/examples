::  Tic-Tac-Toe
::
/-  *toe, sole
/+  sole, *server, *toe
::
:: This imports the tile's JS file from the file system as a variable.
::
/=  tile-js
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/toe/js/tile
  /|  /js/
      /~  ~
  ==
::
=,  format
=,  sole
::
=>  |%
    ::
    +|  %models
    ::
    +$  state
      $:  ::  (see %/sur/toe/hoon)
          ::
          toers=players
          subs=subscribers
          game=game-state
          board=board-state
          ::  $who: player that can perform a move
          ::
          who=ship
          ::  $next: flag to indicate a replay
          ::
          next=?
          ::
          ::  $consol: console state
          ::
          ::     $conn:  id for console connection
          ::     $state: data in the console
          ::
          consol=[conn=bone state=sole-share]
      ==
    ::
    +$  move  (pair bone card)
    ::
    +$  card
      $%  [%diff diff-data]
          [%peer wire dock path]
          [%pull wire dock ~]
          [%poke wire dock poke-data]
          [%wait wire p=@da]
          [%http-response =http-event:http]
          [%connect wire binding:eyre term]
      ==
    ::
    +$  diff-data
      $%  ::  See %/mar/toe/* for specific details
          ::    * = [turno, player, winner]
          ::
          [%toe-turno toe-turno]
          [%toe-player toe-player]
          [%toe-winner toe-winner]
          [%sole-effect sole-effect]
          [%json json]
       ==
    ::
    +$  poke-data
      $%  [%toe-cancel toe-cancel]
          [%launch-action [@tas path @t]]
      ==
    ::
    ::  FIXME: $spot has to be redefined
    ::     even though it's already in sur...
    ::     it gave nest fails in +-moves-start
    ::     ?:  (~(has by board.sat) (spot-val u.try))
    ::     -find.get
    ::
    +$  spot  [coord coord]
    --
::
::  %app
::
::    Our app is defined as a "door" (multi-armed core with a sample).
::    Arms are grouped in chapters (+|) based on common functionality
::
|_  [bol=bowl:gall %0 sat=state]
::
::  %alias: rewording of commonly used nouns
::
+|  %alias
::
::  %me: alias for our ship
::
++  me  our.bol
::
::  %ze: alias for the origin of an incoming request
::
++  ze  src.bol
::
::
::  %this: common idiom to refer to our whole %app door and its context
::
++  this  .
::
::  Aliasing arms declared within cores (requiered by gall)
::
++  poke-sole-action          poke-sole-action:co:view
++  peer-sole-action          peer-sole-action:co:view
++  peer-sole                 peer-sole:co:view
++  peer-toetile              peer-toetile:fe:view
++  poke-json                 poke-json:fe:view
++  bound                     bound:fe:view
++  poke-handle-http-request  poke-handle-http-request:fe:view
::
::  %state
::
::    Arms to innitialize (and restart) our app's state
::
+|  %state
::
++  prep
  =>  |%
      ++  states
        $%  [%0 s=state]
        ==
      --
  |=  old=(unit states)
  ^-  (quip move _this)
  =/  launcha=poke-data
    [%launch-action [%toe /toetile '/~toe/js/tile.js']]
  =/  moves=(list move)
    :~  :: %connect here tells %eyre to mount at the /~toe endpoint.
        ::
        [ost.bol %connect / [~ /'~toe'] %toe]
        [ost.bol %poke /toe [our.bol %launch] launcha]
    ==
  ?~  old
    ::  we haven't modified the previous state
    ::
    [moves wipe]
  ::  the old state needs to be adapted to the new one
  ::
  ?-  -.u.old
    %0  [~ this(sat s.u.old)]
  ==
::
++  wipe
  ^-  _this
  %=  this
      subs.sat   ~
      toers.sat  ~
      board.sat  ~
      next.sat   %.n
      game.sat   %select-opponent
  ==

::
::  %core
::
::    Game engine logic
::
+|  %core
::
++  ge
  ::
  |_  buf=(list @c)
  ::
  ::  %processes user action based on current state
  ::
  ++  action
    ?-    game.sat
        ::  Game Engine Step 1: selects opponent
        ::
        %select-opponent  select-opponent
        ::  Game Engine Step 2: waits for confirmation
        ::
        %confirm          wait-confirmation
        ::  Game Engine Step 3: moves start
        ::
        %start            moves-start
        ::  Game Engine Step 4: game ends, waits for end/continue?
        ::
        %replay           continue-replay
    ==
  ::
  ::  $select-opponent: step 1
  ::    sends a request to play to opponent (e.g. ~zod)
  ::
  ::    FIXME:  error when app is not running
  ::            gall: %toe: move: invalid card (bone 0)
  ::            mack
  ::
  ++  select-opponent
    ^-  (quip move _this)
    =/  try  (rust (tufa buf) ;~(pfix sig fed:ag))
    ?~  try
      [~ this]
    ?:  =(u.try me)
      =/  front-error
        :~  [%status s+'error']
            [%message (tape:enjs:format txt:frowned-upon)]
        ==
      :_  this
      :~  (send:co:view frowned-upon)
          (send:fe:view front-error)
      ==
    =^  edit  state.consol.sat  (to-sole:co:view reset)
    =/  new-prompt
      (prompt:co:view "{waiting}{(scow %p u.try)} {abort} | ")
    ::  $in=0: we haven't received a subscribe back yet so
    ::  by convention we assign 0 to the incoming subscription
    ::
    :_  this(subs.sat (snoc subs.sat [u.try [in=0 out=ost.bol]]))
    :~  [ost.bol %peer /join-game [u.try dap.bol] /invite]
        ::  console
        ::
        (send:co:view mor+~[det+edit new-prompt])
        ::  frontend
        ::
        %-  send:fe:view  ^-  (list [@t json])
          :~  [%message s+(scot %p u.try)]
              [%status s+'select-opponent']
    ==    ==
  ::
  ::  $wait-confirmation: step 2
  ::    after reaciving a request to play, we block until
  ::    the console receives a comfirmation [Y/N] answer
  ::
  ++  wait-confirmation
    ^-  (quip move _this)
    =/  try  (rust (cass (tufa buf)) (mask "yn"))
    ?~  try
      [~ this]
    ?:  =(u.try 'n')
      ::  don't play with this player
      ::
      crash-current-game
    ?~  subs.sat
      ::  current player might have crashed zir game
      ::
      crash-current-game
    ::  confirms game with 1st incoming sub in the queue
    ::
    =*  guest  i.subs.sat
    ::  by default, player's icons are harcoded
    ::    (me = [X green], ze = [O red])
    ::
    =/  defaults=(list [ship player])
      ~[me^[%'X' %g] ze.guest^[%'O' %r]]
    =/  new-opos   [[ze.guest [in.conns.guest ost.bol]] t.subs.sat]
    =.  toers.sat  (~(gas by toers.sat) defaults)
    ::  cleans up the prompt
    ::
    =^  edit  state.consol.sat  (to-sole:co:view reset)
    ::
    ::  Unlocks the confirmation state and start the game
    ::  The one who received the request owns the turn and
    ::  can put moves on the board
    ::
    :_  %=  this
          who.sat   me
          game.sat  %start
          subs.sat  new-opos
        ==
    :~  ::  after we confirm, we subscribe to our opponent
        ::    TODO: research 2-way subscription model with Hall
        ::
        [ost.bol %peer /join-game [ze.guest dap.bol] /back]
        ::  We send $accept to our subscriber with our icon
        ::
        [in.conns.i.subs.sat %diff %toe-player [%accept [%'X' %g]]]
        ::  Update to the console as list of effects
        ::
        %-  send:co:view  ^-  sole-effect
          :~  %mor
              det+edit
              instruct
              (prompt:co:view (dial:co:view [ze.guest stones "<-"]))
          ==
        ::  Update to the fronted as json
        ::
        %-  send:fe:view  ^-  (list [@t json])
          :~  [%stone s+(crip me:stones)]
              [%next s+(scot %p me)]
              [%status s+'start']
    ==    ==
  ::
  ::  $moves-start: step 3
  ::    now the game is on, each player will send diffs
  ::    to each other with the position for zir icon
  ::
  ++  moves-start
    ^-  (quip move _this)
    =/  try  (rust (tufa buf) position)
    ?~  try
      [~ this]
    ?.   =(our.bol who.sat)
      :_  this
      ~[(send:co:view wait-your-turn)]
    ?:  (~(has by board.sat) (spot-val u.try))
      :_  this
      ~[(send:co:view spot-taken)]
    =/  new-step=toe-turno  [(~(got by toers.sat) me) (spot-val u.try)]
    =^  out  board.sat  (step new-step)
    =^  edit  state.consol.sat  (to-sole:co:view reset)
    ?~  subs.sat
      [~ this]
    =*  opp  ze.i.subs.sat
    =*  spo  spo.new-step
    ?~  out
      ::  we switch turns
      ::
      :_  this(who.sat opp)
      :~  ::  sends our game move (turno) to our opponent
          ::
          [in.conns.i.subs.sat %diff %toe-turno new-step]
          ::  Update to the frontend as json
          ::
          ::  If the move originated in the frontend, this is redundant
          ::  so this move should be ignored on the frontend (via %next)
          ::
          %-  send:fe:view  ^-  (list [@t json])
            :~  [%status s+'play']
                [%next s+(scot %p opp)]
                [%stone s+`@t`stone.per.new-step]
                [%move a+~[n+(scot %u -.spo) n+(scot %u +.spo)]]
            ==
          ::  Update to the console as list of effects
          ::
          %-  send:co:view  ^-  sole-effect
            :~  %mor
                grid:co:view
                det+edit
                (prompt:co:view (dial:co:view [opp stones "->"]))
      ==    ==
    ::  game ends
    ::
    =/  end-message=tape  (end:co:view out)
    :_  this(board.sat ~, game.sat %replay)
    :~  ::  Sends winner move to our opponent
        ::
        [in.conns.i.subs.sat %diff %toe-winner [end-message new-step]]
        ::  Update to the frontend as json
        ::
        %-  send:fe:view  ^-  (list [@t json])
          :~  [%status s+'replay']
              [%winner ?:(=(out %tie) s+'tie' s+(scot %p me))]
              [%stone s+`@t`stone.per.new-step]
              [%move a+~[n+(scot %u -.spo) n+(scot %u +.spo)]]
          ==
        ::  Update to the console as list of effects
        ::
        %-  send:co:view  ^-  sole-effect
          :~  %mor
              det+edit
              grid:co:view
              ?:(=(out %tie) falken bel+~)
              new-line
              (prompt:co:view "{end-message}{keep-on}")
    ==    ==
  ::
  ::  $continue-replay: step 4
  ::    the game has finished, either with a win or a tie
  ::    now we block to confirm if the players want to continue
  ::
  ++  continue-replay
    ^-  (quip move _this)
    =/  try  (rust (cass (tufa buf)) (mask "yn"))
    ?~  try
      [~ this]
    ?:  =(u.try 'n')
      crash-current-game
    =^  edit  state.consol.sat  (to-sole:co:view reset)
    =.  board.sat  ~
    =/  my-toer  (~(got by toers.sat) me)
    ?~  subs.sat
      [~ this]
    =*  opp  ze.i.subs.sat
    =/  rematch
      [in.conns.i.subs.sat %diff %toe-player [%rematch my-toer]]
    ::  has our opponent already confirmed the replay?
    ::  by default, the first player to confirm, will have the first turn
    ::
    ?:  =(next.sat %.y)
      :_  this(game.sat %start, who.sat opp, next.sat %.n)
      :~  rematch
          ::  Update to the frontend as json
          ::
          %-  send:fe:view  ^-  (list [@t json])
            :~  [%stone s+(crip me:stones)]
                [%next s+(scot %p opp)]
                [%status s+'start']
            ==
          ::  Update to the console as list of effects
          ::
          %-  send:co:view  ^-  sole-effect
            :~  %mor
                grid:co:view
                det+edit
                (prompt:co:view (dial:co:view [opp stones "->"]))
      ==    ==
    :_  this(game.sat %replay, next.sat %.y)
    :~  rematch
        ::  Update to the frontend as json
        ::
        %-  send:fe:view  ^-  (list [@t json])
          :~  [%message s+(scot %p opp)]
              [%status s+'select-opponent']
              [%next s+(scot %p me)]
          ==
        ::  Update to the console as list of effects
        ::
        %-  send:co:view  ^-  sole-effect
          :~  %mor
              det+edit
              %-  prompt:co:view
                " | ...waiting for {(cite:title opp)} {abort} |"
    ==    ==
  ::
  --
::
::  %comunication
::
::    Gall-related arms for urbit-to-urbit communication
::
+|  %comms
::
::  $peer-invite: receives/enqueues a request to start a game
::
::    if a game is ongoing (or more than one request in queue),
::    enqueues the new request or asks for confirmation if no active games.
::
++  peer-invite
  |=  pax=path
  ^-  (quip move _this)
  =/  guest  (cite:title ze)
  ::  $out=0: we haven't subscribed back yet so
  ::  by convention we assign 0 to the out subs
  ::
  =/  invite  [ze [ost.bol 0]]
  ?~  subs.sat
    ::  first invite goes into the subscribers queue
    ::
    :_  this(subs.sat ~[invite], game.sat %confirm)
    :~  (send:fe:view ~[[%message s+(crip guest)] [%status s+'confirm']])
        (send:co:view (prompt:co:view "{confirm}{guest}? (Y/N) | "))
    ==
  :_  this(subs.sat (snoc subs.sat invite))
  ~[(send:co:view klr+[[[```%b] " [ {guest} wants to play ]"] ~])]
::
::  $peer-back: subscribes back to the ship that requested to play with us
::
::
++  peer-back
  |=  pax=path
  ^-  (quip move _this)
  ?~  subs.sat
    [~ this]
  =/  new-head  [ze.i.subs.sat [ost.bol out.conns.i.subs.sat]]
  :-  ~
  this(subs.sat [new-head t.subs.sat])
::
++  reap
  |=  [wir=wire err=(unit tang)]
  ^-  (quip move _this)
  ?~  err  [~ this]
  :_  this
  ~[(send:co:view tan+u.err)]
::
::  $diff-toe-player: invite accepted with our opponent's icon
::
::    hardcoded %x as our opponent's icon.
::
++  diff-toe-player
  |=  [wir=wire act=action per=player]
  ^-  (quip move _this)
  =*  z-stone        stone.per
  =/  m-stone=stone  ?:(=(stone.per %'O') %'X' %'O')
  ?-    act
      ::  %accept: first match
      ::
      %accept
    ::  toers needs to be modifed before we send the new state
    ::    since create dial can't access a future state
    ::
    =.  toers.sat
      %-  ~(gas by toers.sat)
        ~[me^[m-stone %g] ze^[z-stone %r]]
    ::  We unlock the waiting state and start the game
    ::  Our opponent owns the turn
    ::
    :_  this(game.sat %start, who.sat ze)
    :~  ::  Update to the frontned as json
        ::
        %-  send:fe:view  ^-  (list [@t json])
          :~  [%stone s+`@t`m-stone]
              [%next s+(scot %p ze)]
              [%status s+'start']
          ==
        ::  Update to the console as list of effects
        ::
        %-  send:co:view  ^-  sole-effect
          :~  %mor
              instruct
              (prompt:co:view (dial:co:view [ze stones "->"]))
    ==    ==
  ::
      ::  %rematch: game has endend
      ::
      %rematch
    ::  has our opponent already confirmed the replay?
    ::
    ?.  next.sat
      [~ this(next.sat %.y)]
    =.  board.sat  ~
    ?~  subs.sat
      [~ this]
    ::  Update to the frontend as json
    ::
    =/  frontend  ^-  (list [@t json])
      :~  [%stone s+`@t`m-stone]
          [%next s+(scot %p me)]
          [%status s+'start']
      ==
    ::  Update to the console as list of effects
    ::
    =/  effects  ^-  sole-effect
      :~  %mor
          grid:co:view
          (prompt:co:view (dial:co:view [ze.i.subs.sat stones "<-"]))
      ==
    :_  this(game.sat %start, who.sat me, next.sat %.n)
    ~[(send:fe:view frontend) (send:co:view effects)]
  ==
::
::  We receive the resolution of the game
::
++  diff-toe-winner
  |=  [wir=wire win=toe-winner]
  ^-  (quip move _this)
  =*  z-stone  stone.per.tur.win
  =*  spot     spo.tur.win
  ::  puts the winner move on the board
  ::
  =^  out  board.sat  (step [z-stone^%r spo.tur.win])
  :_  this(game.sat %replay)
  :~  ::  Update to the frontend as list json
      ::
      %-  send:fe:view  ^-  (list [@t json])
        :~  [%status s+'replay']
            [%winner ?:(=(out %tie) s+'tie' s+(scot %p ze))]
            [%stone s+`@t`z-stone]
            [%move a+~[n+(scot %u -.spot) n+(scot %u +.spot)]]
        ==
      ::  Update to the console as list of effects
      ::
      %-  send:co:view  ^-  sole-effect
        :~  %mor
            grid:co:view
            ?:(=(out %tie) falken bel+~)
            new-line
            (prompt:co:view "{out.win}{keep-on}")
  ==    ==
::
::  We receive our opponent's move on the board
::
++  diff-toe-turno
  |=  [wir=wire tur=toe-turno]
  ^-  (quip move _this.$)
  =*  z-stone  stone.per.tur
  ::  puts the opponent's move on the  board
  ::
  =^  out  board.sat  (step z-stone^%r spo.tur)
  ::  We unlock the confirmation state and start the game
  ::  We own the turn and can put moves on the board
  ::
  ?~  subs.sat
    [~ this]
  ::  now is our turn
  ::
  :_  this(who.sat me)
  :~  ::  Update to the frontend as json
      ::
      %-  send:fe:view  ^-  (list [@t json])
        :~  [%status s+'play']
            [%next s+(scot %p me)]
            [%stone s+`@t`z-stone]
            [%move a+~[n+(scot %u -.spo.tur) n+(scot %u +.spo.tur)]]
        ==
      ::  Update to the console as list of effects
      ::
      %-  send:co:view  ^-  sole-effect
        :~  %mor
            grid:co:view
            (prompt:co:view (dial:co:view [ze.i.subs.sat stones "<-"]))
  ==    ==
::
++  crash-current-game
  ^-  (quip move _this)
  ?~  subs.sat
    =^  edit  state.consol.sat  (to-sole:co:view reset)
    [[(send:co:view det+edit)]~ this]
  =/  current-guest  i.subs.sat
  ?:  ::  if we haven't confirmed current subscription
      ::
      =(0 out.conns.current-guest)
    ::  send cancel poke
    ::
    (send-cancel current-guest)
  ::  if subscribed, %pull subscription
  ::
  (send-unsubscribe current-guest)
::
++  send-unsubscribe
  |=  guest=remote-app
  ^-  (quip move _this)
  ?~  subs.sat
    [~ this]
  =/  peer-move
    [out.conns.guest %pull /join-game [ze.guest dap.bol] ~]
  =^  edit  state.consol.sat  (to-sole:co:view reset)
  ::  Board is reset before printing it
  ::
  =.  board.sat  ~
  ::  We crashed our only subscription
  ::
  ?~  t.subs.sat
    ::  The board needs to be reset before producing anything
    ::  so the screen displays the empty board
    ::
    :_  wipe
    :~  peer-move
        (send:co:view (all-effects:co:view edit))
        (send:fe:view [%status s+'null']~)
    ==
  ::  Other toers are waiting for confirmation to play
  ::
  =/  new-guest  (cite:title ze.i.t.subs.sat)
  :_  %=  this
         game.sat  %confirm
         subs.sat  t.subs.sat
        board.sat  ~
      ==
  :~  peer-move
      ::  Update to the frontend as json
      ::
      %-  send:fe:view  ^-  (list [@t json])
        :~  [%message s+(crip new-guest)]
            [%status s+'confirm']
        ==
      ::  Update to the console as list of effects
      ::
      %-  send:co:view  ^-  sole-effect
        :~  %mor
            det+edit
            (prompt:co:view "{confirm}{new-guest} (Y/N)? | ")
  ==    ==
::
::  $pull: handles logic for ending subscriptions
::
::    we only handle /back cases, to stop communication
::    with a ship that requested to play with us
::
++  pull
  ::  TODO:
  ::    is it possible to get a %pull from a ship who didn't %peer?
  ::
  |=  pax=path
  ^-  (quip move _this)
  ::  if we receive a random pull, do nothing
  ::    FIXME: is this even necessary?
  ::
  ?~  subs.sat  [~ this]
  =/  shortened-ship  (cite:title ze)
  =/  out  klr+~[[[```%b] " [{shortened-ship} cancelled your game...]"]]
  ?.  =(ze ze.i.subs.sat)
    ::  we get a cancel from someone waiting in the queue
    ::  the current game needs to keep going, the queue is updated
    ::  silently, and we inform the app of the event
    ::
    :-  ~[(send:co:view out)]
    %=  this
      subs.sat  %+  skip  `subscribers`subs.sat  :: why the cast?
                  |=(e=remote-app =(ze ze.e))
    ==
  =^  edit  state.consol.sat  (to-sole:co:view reset)
  =.  board.sat  ~
  ?~  t.subs.sat
    :_  wipe
    :~  (send:co:view (all-effects:co:view edit))
        (send:fe:view [%status s+'null']~)
    ==
  ::  we get a cancel from the first in the queue
  ::
  :_  %=  this
         subs.sat  t.subs.sat
         game.sat  %confirm
      ==
  ::  we ask for confirmation to the next in the queue
  ::
  :~  ::  Update to the frontend as json
      ::
      %-  send:fe:view  ^-  (list [@t json])
        :~  [%message s+(scot %p ze.i.t.subs.sat)]
            [%status s+'confirm']
        ==
      ::  Update to the console as list of effects
      ::
      %-  send:co:view  ^-  sole-effect
        :~  %mor
            det+edit
            out
            %-  prompt:co:view:co:view
              "{confirm}{(cite:title ze.i.t.subs.sat)} (Y/N)? |  "
  ==    ==
::
::  $send-cancel: sends a manual cancel to a ship that peered us
::
++  send-cancel
  |=  guest=remote-app
  ^-  (quip move _this)
  ?~  subs.sat
    [~ this]
  =/  cancel-move
    [ost.bol %poke /cancel [ze.guest dap.bol] [%toe-cancel %bye]]
  =^  edit  state.consol.sat  (to-sole:co:view reset)
  =/  tabla  grid:co:view
  ?:  =((lent subs.sat) 1)
    :_  wipe
    :~  cancel-move
        (send:co:view (all-effects:co:view edit))
        (send:fe:view [%status s+'null']~)
    ==
  ?~  t.subs.sat
    [~ this]
  =/  new-guest  (cite:title ze.i.t.subs.sat)
  :_  %=  this
         subs.sat  t.subs.sat
         game.sat  %confirm
        board.sat  ~
      ==
  :~  cancel-move
      ::  Update to the frontend as json
      ::
      %-  send:fe:view  ^-  (list [@t json])
        :~  [%message s+(crip new-guest)]
            [%status s+'confirm']
        ==
      ::  Update to the console as list of effects
      ::
      %-  send:co:view  ^-  sole-effect
        :~  %mor
            det+edit
            (prompt:co:view "{confirm}{new-guest} (Y/N)? | ")
  ==    ==
::
::  $poke-toe-cancel: manual pull subscription
::
::    poking the app with a toe-cancel mark
::    for a pull on the guest ship
::
++  poke-toe-cancel
  |=  bye=toe-cancel
  ^-  (quip move _this)
  ::  if we receive a random cancel, do nothing
  ::
  ?~  subs.sat
    [~ this]
  ::  the manual pull can only be sent by our current guest
  ::
  ?.  =(ze ze.i.subs.sat)
    ::  if someone we didn't peer pokes us, do nothing
    ::
    [~ this]
  ::
  =/  current-guest  (cite:title ze.i.subs.sat)
  =^  edit  state.consol.sat  (to-sole:co:view reset)
  ?~  t.subs.sat
    ::  if we had only one opponent in the queue, reset
    ::
    :_  wipe
    :~  (send:co:view (all-effects:co:view edit))
        (send:fe:view [%status s+'null']~)
    ==
  =/  new-guest  (cite:title ze.i.t.subs.sat)
  :_  %=  this
        subs.sat  t.subs.sat
        game.sat  %confirm
      ==
  :~  ::  Update to the console as list of effects
      ::
      %-  send:fe:view  ^-  (list [@t json])
        :~  [%message s+(crip new-guest)]
            [%status s+'confirm']
        ==
      ::  Update to the console as list of effects
      ::
      %-  send:co:view  ^-  sole-effect
        :~  %mor
            det+edit
            klr+~[[[```%b] " [{current-guest} cancelled your game...] "]]
            (prompt:co:view "{confirm}{new-guest} (Y/N)? | ")
  ==    ==
::
::  %view
::
::    Arms for displaying of the tic-tac-toe board
::
++  view
  |%
  ::
  ::  %fe: frontend
  ::
  ::    arms that deal with communication with eyre and the frontend
  ::
  ++  fe
    |%
    ::
    ++  bound
      |=  [wir=wire success=? binding=binding:eyre]
      ^-  (quip move _this)
      [~ this]
    ::
    ::  $peer-toefile:
    ::
    ++  peer-toetile
      |=  wir=wire
      ^-  (quip move _this)
      :_  this
      [ost.bol %diff %json *json]~
    ::
    ::  +poke-handle-http-request:
    ::
    ::    serve pages from file system based on URl path
    ::
    ++  poke-handle-http-request
      %-  (require-authorization:app ost.bol move this)
        |=  =inbound-request:eyre
        ^-  (quip move _this)
        =/  request-line  (parse-request-line url.request.inbound-request)
        =/  back-path  (flop site.request-line)
        =/  name=@t
          =/  back-path  (flop site.request-line)
          ?~  back-path
            ''
          i.back-path
        ::
        :_  this
        :_  ~
        :+  ost.bol  %http-response
        ?~  back-path
          not-found:app
        ?:  =(name 'tile')
          (js-response:app tile-js)
        not-found:app
    ::
    ++  poke-json
      |=  jon=json
      ^-  (quip move _this)
      ?.  ?=(%o -.jon)
        ::  ignores non-object json
        ::
        [~ this]
      =/  object=(map @t json)  +.jon
      =/  data=json  (~(got by object) 'data')
      =-  ~(action ge -)
      ^-  (list @c)
      ::  $data: cord->tape->(list @c)
      ::
      ::    this is a hack to reuse the parsing of console input
      ::    to handle data validation. hacks need to be refactor
      ::    at some point in the future, but not now
      ::
      ?+    -.data  !!
        %a  =+  ((ar:dejs ni:dejs) data)
            (tuba "{(scow %u (snag 0 -))}/{(scow %u (snag 1 -))}")
        %s  (tuba (trip (so:dejs data)))
      ==
    ::
    ::  +send:
    ::
    ::    sends new data to the frontend
    ::
    ++  send
      |=  pairs=(list [@t json])
      ^-  move
      =-  (snag 0 -)
      %+  turn  (prey:pubsub:userlib /toetile bol)
        |=  [=bone ^]
        [bone %diff %json (pairs:enjs:format pairs)]
    --
  ::
  ::  %co: console
  ::
  ::    %sole arms to receive console moves and prompt formatting
  ::
  ++  co
    |%
    ++  all-effects
      |=  =sole-change
      ^-  sole-effect
      :-  %mor
      :~  det+sole-change
          clear
          welcome
          new-line
          grid
          shall-we
          (prompt choose)
      ==
    ::
    ++  dial
      ::  +cite:title compresses the ship's name if
      ::    we are dealing with a comet
      ::
      |=  [guest=ship stones=[me=tape ze=tape] arrow=tape]
      ^-  styx
      :~  [[~ ~ ~] " | "]
          [[~ ~ ~] "{(cite:title me)}"]
          [[~ ~ ~] ":["]
          [[```%g] "{me.stones}"]
          [[~ ~ ~] "] {arrow} "]
          [[~ ~ ~] "{(cite:title guest)}"]
          [[~ ~ ~] ":["]
          [[```%r] "{ze.stones}"]
          [[~ ~ ~] "] |  "]
      ==
    ::
    ++  end
      |=  out=outcome
      ^-  tape
      ?:  =(out %tie)
        " Stalemate"
      " | {<who.sat>} wins!"
    ::
    ::  $grid: pretty prints the board displayed on the console
    ::
    ++  grid
      ^-  sole-effect
      :-  %mor
      :~  (row %1)  row-sep
          (row %2)  row-sep
          (row %3)
          empty-style
      ==
    ::
    ++  list-subscribers
      ^-  (quip move _this)
      =^  edit  state.consol.sat  (to-sole reset)
      ?~  subs.sat
        :_  this
        ~[(send mor+~[det+edit no-subscribers])]
      :_  this
      :~  %-  send
            :~  %mor
                (print-subscribers subs.sat)
                det+edit
      ==    ==
    ::
    ::  $peer-sole: sole's subscription arm that connects to the console
    ::
    ++  peer-sole
      |=  path
      ^-  (quip move _this)
      =.  consol.sat  [ost.bol *sole-share]
      :_  this
      :_  ~
      %-  send
        mor+~[clear welcome wopr grid shall-we (prompt choose)]
    ::
    ++  poke-sole-action
      |=  act=sole-action
      ^-  (quip move _this)
      =*  share  state.consol.sat
      ?-    -.act
          ::  $clr: clear screen
          ::
          %clr
        [~ this]
          ::  $ret: enter key pressed
          ::
          %ret
        ?~  buf.share  [~ this]
        ::  checks for a restart game command
        ::
        =/  restart=(unit @t)
          (rust (tufa buf.share) ;~(just zap))
        ?.  =(~ restart)
          crash-current-game
        ::  checks for a "list waiting opponents" command
        ::
        =/  list=(unit @t)
          (rust (tufa buf.share) ;~(just (just 'l')))
        ?.  =(~ list)  list-subscribers:co:view
        ::  %egg (?)
        ::
        =/  egg=(unit @t)
          (rust (tufa buf.share) ;~(just (jest (crip "joshua"))))
        ?.  =(~ egg)  easter-egg
        ::  based on the current state, a different engine arm is called
        ::
        ~(action ge buf.share)
          ::  $det: key press
          ::  pressed key is stored in the console state
          ::
          %det
        =^  inv  state.consol.sat  (~(transceive sole share) +.act)
        [~ this]
      ==
    ::
    ++  print-subscribers
      |=  q=subscribers
      =/  c  1
      :-  %tan
      %-  flop
        :-  leaf+".............."
        |-  ^-  (list [%leaf tape])
        ?~  q
          ~[leaf+".............."]
        :-  leaf+"{<c>}. {(cite:title ze.i.q)}"
        $(q t.q, c +(c))
    ::
    ::  $prompt: default game input that modifies the prompt
    ::
    ++  prompt
      |=  dial=styx
      ^-  sole-effect
      pro+[& %$ dial]
    ::
    ::  $row: pretty prints a row of the board displayed on the console
    ::
    ++  row
      |=  row=coord
      ^-  sole-effect
      =/  col=coord  %1
      :-  %klr
      |-  ^-  styx
      =/  symbol=(unit player)  (~(get by board.sat) [row col])
      :-  ?:  =(col %1)
            [[~ ~ ~] "    "]
          [[~ ~ ~] "| "]
      :_  ?:  =(col %3)  ~
        $(col (coord +(col)))
      ?~  symbol
        [[~ ~ ~] "  "]
      :-  [~ ~ `color.u.symbol]
      "{(trip stone.u.symbol)} "
    ::
    ++  send
      |=  fec=sole-effect
      ^-  move
      [conn.consol.sat %diff %sole-effect fec]
    ::
    ++  to-sole
      |=  inv=sole-edit
      ^-  [sole-change sole-share]
      (~(transmit sole state.consol.sat) inv)
    --
  --
::
::  %rules
::
::    Pattern matching on console's input
::
+|  %rules
::
++  num-rule  (shim '1' '3')
++  index    (cook |=(a/@ (sub a '0')) num-rule)
++  position
  ::  e.g. [1-3]/[1-3]
  ::
  ;~((glue fas) index index)
::
++  spot-val
  |=  a=[@ @]
  ?>(?=(spot a) a)
::
::  %game
::
::     Arms for game-specific actions
::
+|  %game
::
++  step
  |=  tur=toe-turno
  ^-  [outcome board-state]
  =.  board.sat  (~(put by board.sat) [spo.tur per.tur])
  [(outcome-check per.tur) board.sat]
::
++  outcome-check
  |=  per=player
  ^-  outcome
  ?:  (win-check per)
    %wins
  ?:(tie-check %tie ~)
::
++  win-check
  |=  per=player
  ^-  ?
  %+  lien  winning-rows
  |=  a=(list spot)
  ^-  ?
  %+  levy  a
  |=  b=spot
  =/  c=(unit player)  (~(get by board.sat) b)
  ?~(c | =(stone.per stone.u.c))
::
++  tie-check
  =(~(wyt in board.sat) 9)
::
++  winning-rows
  ^-  (list (list spot))
  :~  ~[[%1 %1] [%2 %1] [%3 %1]]
      ~[[%1 %2] [%2 %2] [%3 %2]]
      ~[[%1 %3] [%2 %3] [%3 %3]]
      ~[[%1 %1] [%1 %2] [%1 %3]]
      ~[[%2 %1] [%2 %2] [%2 %3]]
      ~[[%3 %1] [%3 %2] [%3 %3]]
      ~[[%1 %3] [%2 %2] [%3 %1]]
      ~[[%1 %1] [%2 %2] [%3 %3]]
  ==
::
::  %helpers
::
+|  %helpers
::
++  stones
  ^-  [me=tape ze=tape]
  =/  p=player  (~(got by toers.sat) me)
  :-  (trip stone.p)
  %-  trip
    ?:  =(stone.p %'O')
      %'X'
    %'O'
::
:: ++  guest-bone
::   |=  [ze=ship =path]
::   ^-  bone
::   ::  $arvo-subscribers:
::   ::    list of who has sent us a %peer with a join wire
::   ::
::   =/  arvo-subs  (prey:pubsub:userlib path bol)
::   =+  (skim arvo-subs |=(a=[* ze=ship *] =(ze.a ze)))
::   ?~  -  !!
::   -.-
::
++  easter-egg
  ^-  (quip move _this)
  =^  edit  state.consol.sat  (to-sole:co:view reset)
  [~[(send:co:view mor+~[joshua det+edit])] this]
--
