::    project euler 6
::    https://projecteuler.net/problem=6
::  run in dojo with +euler6
::
::::  /hoon/euler6/gen
  ::
:-  %say  |=  *  
:-  %noun
=<  (diff 100)
::
::::  ~racleb-fitwyt
  ::
|%
++  sq
  |=  a=@u
  (mul a a)

++  sum
  |=  a=@u
  =+  b=1
  |-  ^-  @u
  ?:  (lth a b)
    0
  (add b $(b +(b)))
  
++  sumsq
  |=  a=@u
  =+  b=1
  |-  ^-  @u
  ?:  (lth a b)
    0
  (add (sq b) $(b +(b)))

++  diff
  |=  a=@u
  (sub (sq (sum a)) (sumsq a))
--
