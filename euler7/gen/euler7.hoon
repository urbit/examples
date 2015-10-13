::    project euler 7
::    https://projecteuler.net/problem=7
::  run in dojo with +euler7
::
::::  /hoon/euler7/gen
  ::
:-  %say  |=  *  
:-  %noun
=<  (nth 10.001)
::
::::  ~racbes-solmun
  ::
|%
++  iip                     :: is it prime
  |=  a=@
  =+  b=2
  |-  ^-  @f
  ?:  =((mod a b) 0)
    .n
  ?:  (lth a (mul b 2))
    .y
  $(b +(b))

++  nth                     :: find the nth prime
  |=  a=@
  =+  [i=2 n=3]
  |-  ^-  @
  ?:  (iip n)
    ?:  =(i a)
      n
    ~&  [%i i]
    ~&  [%n n]
    $(i +(i), n (add 2 n))
  $(i i, n (add 2 n))
--
