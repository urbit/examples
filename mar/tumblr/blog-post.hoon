::
::  /hoon/blog-post/tumblr/mar
::
::
/?    310
/-  tumblr
/+  tumblr-parse, jumblr
!:
|_  bp/post:tumblr
++  grab
  |%
  ++  json
    |=  jon/^json
    ^-  post:tumblr
    %-  need
    (post:tumblr-parse jon)
  ++  noun  post:tumblr
  --
++  grow
  |%
  ++  json
    (jost:jumblr bp)
  --
--
