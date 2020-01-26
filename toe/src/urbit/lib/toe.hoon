::  /lib/toe/hoon
::
|%
+|  %players
::  default, player's icons are harcoded
::  me/ joiner/  first-to-replay = [X green]
::  ze/inviter/second-to-confirm = [O   red]
::
++  player-a  |=([me=@p ze=@p] ~[me^[%'X' %g] ze^[%'O' %r]])
++  player-b  |=([me=@p ze=@p] ~[me^[%'O' %g] ze^[%'X' %r]])
+|  %intro-text
++  welcome
  :-  %klr
  :~  [[~ ~ ~] "   "]
      [[`%un ~ ~] "Tic-Tac-Toe"]
      [[~ ~ ~] "   "]
  ==
++  brought-by      "brought to you by W.O.P.R {copyright}  "
++  wopr            txt+(weld empties brought-by)
++  shall-we        klr+~[[[`%un ~ ~] txt="shall we play a game?"]]
::
+|  %prompt-messages
::
++  choose          " | enter @p (e.g. ~zod) | "
++  waiting         " | waiting for "
++  abort           "(!=quit)"
++  keep-on         " continue? (Y/N) | "
++  confirm         " | play with "
::
+|  %action-messages
::
++  no-subscribers  klr+~[no-klr [[```%b] txt="* no players yet..."]]
++  spot-taken      klr+~[no-klr [[```%r] txt="* spot taken"]]
++  wait-your-turn  klr+~[no-klr [[```%r] txt="* wait for your turn"]]
++  instruct
  klr+~[no-klr [[```%b] txt="* choose a board position (e.g. 2/2)"]]
++  frowned-upon
  :-  %klr
  :~  [[~ ~ ~] " * "]
      :-  [```%y]
      txt="playing with yourself is frowned upon... "
  ==
++  cancel-game
  |=  guest=tape
  klr+~[[[```%b] " [{guest} cancelled your game...]"]]
::
+|  %text-helpers
::
++  row-sep         klr+~[[[~ ~ ~] "    ---------"]]
++  new-line        txt+""
++  empties         "                 "
++  no-klr          [[~ ~ ~] "    "]
++  unline          [`%un ~ ~]
++  empty-style     klr+~[no-klr]
++  copyright       (trip (tuft `@c`169))
++  clear     clr+~
++  reset     set+~
::
+|  %easter-eggs
++  falken
  :-  %mor
  :~  klr+~[[[`%un ~ ~] txt="Greetings professor Falken."]]
      klr+~[[[`%un ~ ~] txt="A strange game."]]
      klr+~[[[`%un ~ ~] txt="They only winning move is not to play."]]
      empty-style
      klr+~[[[`%un ~ `%b] txt="How about a nice game of chess?"]]
  ==
++  joshua
  :-  %mor
  :~  klr+~[no-klr [unline "FALKEN'S MAZE"]]
      klr+~[no-klr [unline "BLACK JACK"]]
      klr+~[no-klr [unline "GIN RUMMY"]]
      klr+~[no-klr [unline "HEARTS"]]
      klr+~[no-klr [unline "BRIDGE"]]
      klr+~[no-klr [unline "CHECKERS"]]
      klr+~[no-klr [unline "CHESS"]]
      klr+~[no-klr [unline "POKER"]]
      klr+~[no-klr [unline "FIGHTER COMBAT"]]
      klr+~[no-klr [unline "GUERRILLA ENGAGEMENT"]]
      klr+~[no-klr [unline "DESERT WARFARE"]]
      klr+~[no-klr [unline "AIR-TO-GROUND ACTIONS"]]
      klr+~[no-klr [unline "THEATERWIDE TACTICAL WARFARE"]]
      klr+~[no-klr [unline "THEATERWIDE BIOTOXIC AND CHEMICAL WARFARE"]]
      empty-style
      klr+~[no-klr [[`%un ~ `%r] "GLOBAL THERMONUCLEAR WAR"]]
   ==
  --
