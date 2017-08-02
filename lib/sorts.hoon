::  arms accessible in dojo after `/+  sorts` (two spaces (`gap`) in between)
::  try `test:sorts`
::
::  /lib/sorts
::
!:
::
|%
++  test
  |=  *
  =/  a/(list @u)  ~[5 2 3 8 1 13 1]
  :*  insertion-sort+(insertion-sort a)
      bubble-sort+(bubble-sort a)
      merge-sort+(merge-sort a)
  ==
::
++  insertion-sort
  |=  a/(list @u)                                       :: gate, list of numbers
  =/  b/(list @u)  ~                                    :: var, b = empty list.
  |-  ^-  (list @u)                                     :: loop, prod. list nums
  ?~  a  b                                              :: ifno a (~), produce b
  %=  $                                                 :: else, call loop:
    a  t.a                                              :: a->tail a (~ if none)
    b  |-  ^-  (list @u)                                :: b->loop prod, list @s
       ?~  b  [i.a ~]                                   :: ifno b, prod. head a.
       ?:  (lth i.a i.b)                                :: else,if head-a<head-b
         [i.a b]                                        :: prod. cell [head-a b]
       [i.b $(b t.b)]                                   :: else, prod. i.b, loop
  ==
::
++  bubble-sort
  |=  a/(list @u)                                       :: gate, list of numbers
  =/  s/@u  (lent a)                                    :: var, "surface".
  =/  c/@u  0                                           :: var, counter.
  |-  ^-  (list @u)                                     :: loop, produce list @s
  ?:  =(s 1)                                            :: if surface=1, sorted,
    a                                                   :: so produce a.
  %=  $                                                 :: else, call loop:
    a  |-  ^-  (list @u)                                :: a->loop, list of nums
       ?~  a  ~                                         :: disambiguates a
       ?~  t.a  [i.a ~]                                 :: disambiguates t.a
       ?:  =(+(c) s)                                    :: rest sorted if +(c)=s
         a                                              :: so produce a.
       ?:  (gth i.a i.t.a)                              :: else, if head greater
         [i.t.a $(a [i.a t.t.a], c +(c))]               :: swap, loop w tail,c+1
       [i.a $(a t.a, c +(c))]                           :: else prod. head, loop
    s  (dec s)                                          :: s - > dec s, s - 1.
  ==
::
++  merge-sort
  |=  a/(list @u)                                       :: gate, list of numbers
  ?:  (lth (lent a) 2)                                  :: if <2 elems, "sorted"
    a                                                   :: so produce a.
  =+  mid=(div (lent a) 2)                              :: else pin mid->lenta/2
  %-  merge                                             :: call merge
  :-  (merge-sort (scag mid a))                         :: with cons-cell l list
      (merge-sort (slag mid a))                         ::  and right list.
::
++  merge
  |=  {l/(list @u) r/(list @u)}                         :: gate, two lists/ nums
  =|  merged/(list @u)                                  :: newvar merged,set l8r
  |-  ^-  (list @u)                                     :: loop, prod. list nums
  ?.  |(?=($~ l) ?=($~ r))                              :: unless l or r are nil
    ?:  (gth i.l i.r)                                   :: if l head > r head,
      $(merged [i.r merged], r t.r)                     :: call loop with <-.
    $(merged [i.l merged], l t.l)                       :: else, call loop w/ <-
  ?^  l                                                 :: if left is a cell,
    $(merged [i.l merged], l t.l)                       :: call loop  with <-.
  ?^  r                                                 :: else, if r is a cell,
    $(merged [i.r merged], r t.r)                       :: call loop with <-.
  (flop merged)                                         :: else prod mrgd revrsd
::
--
