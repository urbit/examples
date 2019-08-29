|=  raw=tape
^-  tape
=<  ?:((valid raw) (turn raw convert) "input contains non-rune characters")
|%
++  valid
  |=  x=tape
  ^-  ?
  =/  chars  (sy x)
  (~(all in chars) |=(c=@t (~(has by table) c)))
++  convert
  |=  x=@t
  ^-  @t
  =/  r  (trip (~(got by table) x))
  (crip r)
++  table
  %-  my
  :~  :-  ' '  'ace'
      :-  '|'  'bar'
      :-  '\\'  'bas'
      :-  '$'  'buc'
      :-  '_'  'cab'
      :-  '%'  'cen'
      :-  ':'  'col'
      :-  ','  'com'
      :-  '"'  'doq'
      :-  '.'  'dot'
      :-  '/'  'fas'
      :-  '<'  'gal'
      :-  '>'  'gar'
      :-  '#'  'hax'
      :-  '-'  'hep'
      :-  '{'  'kel'
      :-  '}'  'ker'
      :-  '^'  'ket'  
      :-  '+'  'lus'
      :-  ';'  'mic'
      :-  '('  'pal'
      :-  '&'  'pam'
      :-  ')'  'par'
      :-  '@'  'pat'
      :-  '['  'sel'
      :-  ']'  'ser'
      :-  '~'  'sig'
      :-  '\''  'soq'
      :-  '*'  'tar'
      :-  '`'  'tic'
      :-  '='  'tis'
      :-  '?'  'wut'
      :-  '!'  'zap'
  ==
--
