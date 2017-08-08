::
::  /hoon/blog-posts/tumblr/mar
::
::
/?    310
/-  tumblr
/+  tumblr-parse
!:
|_  bp/(list post:tumblr)
++  grab
  |%
  ++  json
    |=  jon/^json
    ^-  (list post:tumblr)
    %-  need
    (blog-posts-r:tumblr-parse jon)
  ++  noun  bp
  --
--
