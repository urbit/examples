::  Project Euler 4
::  https://projecteuler.net/problem=4
::
::  > A palindromic number reads the same both ways. The largest palindrome made
::  > from the product of two 2-digit numbers is 9009 = 91 × 99.
::  > Find the largest palindrome made from the product of two 3-digit numbers.
::
::  Run in :dojo with `+examples/euler4`.
::
::  /gen/examples/euler4
::
/?  310
::
!:
::
:-  %say  |=  *
:-  %noun
=<  (largest-palindrome [999 999])
::
|%
++  largest-palindrome
  |=  {a/@u b/@u}
  =|  p/@u                                              :: palindrome.
  |-  ^-  @u
  ?>  &((lth a 1.000) (lth b 1.000))                    :: three-digit
  ?>  &((gte a 100) (gth b 100))                        :: numbers.
  ?:  (lth (mul a b) p)
    p
  %=  $
    p  |-  ^-  @u
       ?:  (lth (mul a b) p)
         p
       ?:  =(<(mul a b)> (flop <(mul a b)>))            :: <foo> = list of chars
         (mul a b)
       $(b (dec b))
    a  (dec a)
  ==
--

:: > +examples/euler4
:: 906.609
