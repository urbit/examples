::  The classic unix "cowsay" implemented in hoon
::
::  To see a cow say a quote from gen/cow/quotes.txt run:
::
::  +cow/cow
::
/-  sole
/+   generators, pretty-file
=,  generators
:-  %ask
|=  [[now=@da eny=@uvJ bec=beak] ~ ~]
=/  max-length  80
=/  file  (pretty-file .^(noun (cat 3 %c %x) `path`/(scot %p p.bec)/[q.bec]/(scot r.bec)/gen/cow/quotes/txt))
=/  line  (snag (~(rad og eny) (lent file)) file)
=/  tongue  "U"
=/  thoughts  "o"
=/  eyes  "oo"
=<  (cow)
|%
++  cow
    |=  ~
    ^-  (sole-request:sole (cask tang))
    =/  bubble  (turn (message) bars)
    =/  horizontal-border  leaf+(weld "  " (reap (sub (lent (snag 0 bubble)) 5) '-'))
    =/  slant-gap  (reap (sub (lent (snag 0 bubble)) 5) ' ')
    =/  top-slant  leaf+" /{slant-gap}\\"
    =/  bottom-slant  leaf+" \\{slant-gap}/"
    %+  produce  %tang
    %+  weld
      :~  leaf+"            ||     ||"
          leaf+"          {tongue} ||----w |"
          leaf+"        (__)\\       )\\/\\"
          leaf+"      {thoughts} ({eyes})\\_______"
          leaf+"     {thoughts}  ^__^"
      ==
      (weld (weld ~[horizontal-border bottom-slant] bubble) ~[top-slant horizontal-border])
++  message
  |=  ~
  ^-  (list tape)
  =/  quote  ?+  line  ""
    [%leaf *]  p.line
  ==
  (flop (split quote))
++  split
  |=  a=tape
  ^-  (list tape)
  ?:  (gth (lent a) max-length)
    =/  trimmed  (trim max-length a)
    (weld ~[p.trimmed] (split q.trimmed))
  ~[a]
++  bars
  |=  a=tape
  ^-  [%leaf tape]
  =/  tape-length  (lent a)
  ?:  (lth tape-length max-length)
    =/  b  (weld a (reap (sub max-length tape-length) ' '))
    leaf+"| {b} |"
  leaf+"| {a} |"
--
