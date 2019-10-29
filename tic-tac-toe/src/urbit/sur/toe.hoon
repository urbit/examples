::
::::  /sur/toe/hoon
::
|%
::
+|  %data-structures
::
+$  grid         (list [%klr styx])
+$  outcome      ?(%wins %tie ~)
+$  stone        ?(%'X' %'O')
+$  player       [=stone color=tint]
::  $players: each player has a stone (%x/%o) and color (%g/%r)
::
+$  players      (map ship player)
+$  coord        ?(%1 %2 %3)
+$  spot         [coord coord]
::  $board-state: internal board for our game [@ @] -> icon
::
+$  board-state  (map spot player)
::  $game-state: current game state
::
+$  game-state   ?(%select-opponent %confirm %start %replay)
+$  remote-app   [ze=ship =conns]
+$  conns
  $:  ::  $in: for incoming connections
      ::    used when a ship sends us a %peer
      ::
      in=bone
      ::  $out: for outgoing connections
      ::    used when we %peer a ship
      ::
      out=bone
  ==
::  $subscribers: queue of players waiting to play
::
+$  subscribers
  ::  Gall has prey:pubsub:userlib to get the list
  ::  of subscribers.
  ::  It uses a
  ::    $bitt: (map bone (pair ship path))
  ::  to track  incoming subs
  ::  TODO: don't reinvent the wheel and just use
  ::        the queue to track the order or subs.
  ::
  (list remote-app)
::
+$  action      ?(%accept %rematch)
::
+|  %marks
::  Marks sent in each move, as defined in %/mar/toe/
::
+$  toe-player   [msg=action per=player]
+$  toe-winner   [out=tape tur=toe-turno]
+$  toe-turno    [per=player spo=spot]
+$  toe-cancel   %bye
--
