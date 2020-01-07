|=  runes=tape
^-  tape
|^  ?:  (valid runes)
      (turn runes convert)
    "input contains non-rune characters"
++  valid
  |=  x=tape
  ^-  ?
  =/  chars  (sy x)
  (~(all in chars) ~(has by table))
++  convert
  |=  x=@t
  ^-  @t
  (~(got by table) x)
++  table
  %-  my
  :~  [' ' 'ace']
      ['|' 'bar']
      ['\\' 'bas']
      ['$' 'buc']
      ['_' 'cab']
      ['%' 'cen']
      [':' 'col']
      [',' 'com']
      ['"' 'doq']
      ['.' 'dot']
      ['/' 'fas']
      ['<' 'gal']
      ['>' 'gar']
      ['#' 'hax']
      ['-' 'hep']
      ['{' 'kel']
      ['}' 'ker']
      ['^' 'ket']
      ['+' 'lus']
      [';' 'mic']
      ['(' 'pal']
      ['&' 'pam']
      [')' 'par']
      ['@' 'pat']
      ['[' 'sel']
      [']' 'ser']
      ['~' 'sig']
      ['\'' 'soq']
      ['*' 'tar']
      ['`' 'tic']
      ['=' 'tis']
      ['?' 'wut']
      ['!' 'zap']
  ==
--
