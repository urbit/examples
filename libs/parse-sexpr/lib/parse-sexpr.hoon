|%
::  A symbolic expression is either a symbol or more s-exprs.
::  Symbols are stored as terms, Hoon constants.
++  s-expr  (list $@(term {$~ p/s-expr}))
::  Whitespace between s-exprs can be (zero or more) spaces and newlines.
++  whitespace  (star (mask " \0a"))
::  An s-expr is either a symbol (term) or more s-exprs.
++  element  ;~(pose sym (stag ~ toplevel))
::  Parses s-exprs.
++  toplevel
  ::  Recursive parser, output should fit our mold.
  %+  knee  *s-expr
  ::  Cache computations made within the recursion.
  |.  ~+
  ::  Parse elements, separated by whitespace, surrounded by ( and ).
  %+  ifix  [pel per]
  (more whitespace element)
::
++  test  (scan """
                (a
                 b
                 (c  (d e)  f)
                 g)
                """ toplevel)
--
