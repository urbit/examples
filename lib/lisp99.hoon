::  "99 lisp problems" http://www.ic.unicamp.br/~meidanis/courses/mc336/2006s2/funcional/L-99_Ninety-Nine_Lisp_Problems.html
::  arms accessible in dojo after `/+  lisp99` (two spaces (`gap`) in between)
::  try `test:lisp99`
::
::  /libs/lisp99
::
!:
::
|%  ++  s-expr  (list ?(s-expr term))
--
|%
++  test
  :*  (p01 "abcd")  (p02 "abcd")  (p03 "abcde" 3)  (p04 "abc")
      (p05 "sdrawkcab")  (p06 "godsdog")  (p07 ~["ab" %c "d"] "ef" ~["g"] ~)
      (p08 "aaaabccaadeeee")  (p09 "aaaabccaadeeee")  (p10 "aaaabccaadeeee")
  ==
++  p01  last-cell
++  last-cell
  |=(a/s-expr ?~(+.a a $(a +.a)))
::
++  p02  but-last-cell
++  but-last-cell  :: broken for the moment
  |=(a/s-expr =+(|2.a ?~(- a $(a +.a))))
::
++  p03  element-at
++  element-at
  |=({a/s-expr k/@u} ?:(=(1 k) -.a $(a +.a, k (dec k))))
::
++  p04  length
++  length
  |=(a/s-expr ?~(a 0 +($(a t.a))))
::
++  p05  reverse
++  reverse
  |=(a/s-expr =|(b/s-expr |-(?~(a b $(a +.a, b [-.a b])))))
::
++  p06  palinodrome-p
++  palinodrome-p
  |=(a/s-expr =(a (reverse a)))
::
++  p07  flatten
++  flatten
  |=  a/s-expr  ^+  a
  ?~  a  ~
  ?~  i.a  t.a
  ?@  i.a  [i.a $(a t.a)]
  (weld $(a i.a) $(a t.a))
::
++  p08  compress
++  compress
  |=  a/s-expr
  ?~  a  ~
  |-  ^-  s-expr
  ?~  t.a  a
  ?:  =(i.a i.t.a)
    $(t.a t.t.a)
  [i.a $(a t.a)]
::
++  p09  pack
++  pack
  |=  a/s-expr  ^-  s-expr
  ?~  a  ~
  |-  ^-  {i/s-expr t/s-expr}
  ?~  t.a  [a]~
  ?:  =(i.a i.t.a)
    [[-.i i] t]:$(a t.a)
  [[i.a]~ $(a t.a)]
::
++  p10  encode
++  encode
  |=  a/s-expr
  ?~  a  ~
  |-  ^-  (list {@u ?(s-expr term)})
  ?~  t.a  [1 i.a]~
  ?:  =(i.a i.t.a)
    [[+(-) +]:- +]:$(a t.a)
  [[1 i.a] $(a t.a)]
--
