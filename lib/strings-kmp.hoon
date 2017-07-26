::  Knuth-Morris-Pratt string search
::  arms accessible in dojo after `/+  strings-kmp`  (two spaces (`gap`) in between)
::  try `test:strings-kmp`
::
::  /libs/strings-kmp
::
!:
::
|%
++  test
  =+  a==+([a="a" b=15] |-(?~(b (weld a "b") $(a (weld a a), b (dec b)))))
  =+  b="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ipsum, ipsum ipsum."
  [(kmp "aaaaaaab" a) (kmp "ipsum" b)]
::
++  kmp
  |=  {ptn/tape txt/tape}
  (skm ptn (gnx ptn) txt)
::
++  skm
  |=  {ptn/tape nxt/(list @sd) txt/tape}
  =|  {i/@sd j/@ud}
  =|  fnd/(list @ud)                        ::  indices of pattern in text
  =+  len=(lent txt)
  ^-  (list @ud)  |-
  ?~  txt  (flop fnd)
  =+  ^=  k
  |-  ?.  |(=(i -1) =((snag (abs:si i) ptn) -.txt))
    $(i (snag (abs:si i) nxt))
  (abs:si (sum:si i --1))
  ?:  (gte k (lent ptn))
    $(i (snag k nxt), j +(j), txt +.txt, fnd [(sub +(j) k) fnd])
  $(i (sun:si k), j +(j), txt +.txt)
::
++  gnx                                     ::  generate next table
  |=  ptn/tape
  =+  nxt=`(list @sd)`[-1 ~]
  =+  [i=-1 j=0]
  ^-  (list @sd)  |-
  ?.  (lth j (lent ptn))  nxt
  =+  ^=  k
  |-  ?.  |(=(i -1) =((snag j ptn) (snag (abs:si i) ptn)))
    $(i (snag (abs:si i) nxt))
  (abs:si (sum:si i --1))
  ?:  &(!=(+(j) (lent ptn)) =((snag +(j) ptn) (snag k ptn)))
    $(i (sun:si k), j +(j), nxt (weld nxt (limo (snag k nxt) ~)))
  $(i (sun:si k), j +(j), nxt (weld nxt (limo (sun:si k) ~)))
--
