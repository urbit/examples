::  Just a hello
::
::::  /===/mar/hello/world/hoon
  ::
/-  hello
[. hello]
!:
|_  elo=hello-world
++  grab
  |%
  ++  noun  cord
  ++  json
    |=  jon=^json
    (need (so:dejs-soft:format jon))
  --
++  grow
  |%
  ++  json
    (tape:enjs:format (trip elo))
  --
--
