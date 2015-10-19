::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                                                            ::
::  A sur library is meant to contain data structure definitions. They can    ::
::  be loaded with the %ford rune /- at the beginning of a source file.       ::
::                                                                            ::
::  The full state of the octo app is the ++axle type in ape/octo.hoon. By    ::
::  convention, the application state is named 'axle'. The actual game state  ::
::  is ++game, defined below. ++game is a 5-tuple of the following:           ::
::                                                                            ::
::  - who=? is a boolean that is true if it's X's turn.                       ::
::  - sag=stage is a ++stage, defined below as a pair of two (unit ship)s.    ::
::    A ++unit is Hoon's standard maybe type - in this case, (unit ship), it  ::
::    is either ~ or [~ u=ship].                                              ::
::  - Anyone who is subscribed is in the audience. They are stored in the     ::
::    aud map along with their number of wins.                                ::
::  - box and boo are both ++board, which is a simple 9-bit field. Together   ::
::    they comprise the actual board state.                                   ::
::                                                                            ::
::  The data structures ++point (a pair of coordinates) and ++play, a union   ::
::  that contains either a ++game or a ++tape (one of Hoon's string types,    ::
::  represented as a list of characters) are also defined.                    ::
::                                                                            ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                                      ::  ::
::::  /hoon/octo/sur                                    ::::::  dependencies
  ::                                                    ::  ::
/?    310                                               ::  arvo version
::                                                      ::  ::
::::                                                    ::::::  semantics
  ::                                                    ::  ::
|%                                                      ::
++  board   ,@                                          ::  one-player bitfield
++  point   ,[x=@ y=@]                                  ::  coordinate
++  stage   (pair (unit ship) (unit ship))              ::  players
++  play    (each game tape)                            ::  update
++  game                                                ::  game state
            $:  who=?                                   ::  whose turn
                sag=stage                               ::  who's playing
                aud=(map ship ,@ud)                     ::  who's watching
                box=board                               ::  X board
                boo=board                               ::  O board
            ==                                          ::
--
