::/sur/toe/hoon
::
|%
::
+|  %data-structures
::
+$  game-room    [board=board-game =toers who=@p]
+$  game-rooms   (list [=ship room=(unit game-room)])
+$  outcome      (unit ?(%wins %tie))
+$  stone        ?(%'X' %'O')
::  $players: each player has a stone (%x/%o) and color (%g/%r)
::
+$  player       [=stone color=tint]
+$  toers        (map ship player)
+$  coord        ?(%1 %2 %3)
+$  position     [coord coord]
::  $board-state: internal board for our game [@ @] -> icon
::
+$  board-game   (map position player)
::  $game-state: current game state
::
+$  game-state   ?(%begin %wait %confirm %play %rematch)
::
+$  action       ?(%accept %rematch)
::
+|  %marks
::  Marks sent in each move, as defined in %/mar/toe/
::
+$  toe-player   [msg=action per=player]
+$  toe-winner   [out=tape tur=toe-turno]
+$  toe-turno    [per=player spo=position]
+$  toe-cancel   %bye
--
