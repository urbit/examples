::  Project Euler 4
::  https://projecteuler.net/problem=4
::
::  > A palindromic number reads the same both ways. The largest palindrome made
::  > from the product of two 2-digit numbers is 9009 = 91 × 99.
::  > Find the largest palindrome made from the product of two 3-digit numbers.
::
::  Run in :dojo with `+project-euler/p4`.
::
::  /hoon/p4/project-euler/gen
::
!:
::
:-  %say  |=  *
:-  %noun
=<  (largest-palindrome [999 999])
::
|%
++  largest-palindrome
  |=  {a/@u b/@u}                                       :: gate, takes cell nums
  =|  p/@u                                              :: palindr. var, set l8r
  |-  ^-  @u                                            :: loop, produce a num:
  ?>  &((lth a 1.000) (lth b 1.000))                    :: assert (sure) a&b are
  ?>  &((gte a 100) (gth b 100))                        ::  three-digit numbers.
  ?:  (lth (mul a b) p)                                 :: if a*b < p,
    p                                                   :: produce p
  %=  $                                                 :: otherwise, call loop:
    p  |-  ^-  @u                                       :: p -> prod. loop. num:
       ?:  (lth (mul a b) p)                            :: if a*b < p
         p                                              :: produce p.
       ?:  =(<(mul a b)> (flop <(mul a b)>))            :: <foo> = list of chars
         (mul a b)                                      :: ^if palinr., prod a*b
       $(b (dec b))                                     :: else, call loop w b-1
    a  (dec a)                                          :: a ->  a - 1.
  ==
--

:: > +examples/euler4
:: 906.609
