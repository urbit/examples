|%
++  s-expr  (list $@(term {$~ p/s-expr}))
++  whitespace  (star (mask " \0a"))
++  element  ;~(pose sym (stag ~ toplevel))
++  toplevel
  %+  knee  *s-expr  |.  ~+
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
