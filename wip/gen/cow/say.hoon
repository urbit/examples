::  The classic unix "cowsay" implemented in hoon
::
::  To see a cow say a quote from gen/cow/quotes.txt run:
::
::  +cow/say
::
/-  sole
/+  *generators, pretty-file
:-  %ask
|=  [[now=@da eny=@uvJ bec=beak] ~ ~]
=/  max-length=@  80
=/  file-path=path  /(scot %p p.bec)/[q.bec]/(scot r.bec)/gen/cow/quotes/txt
=/  file=tang  (pretty-file .^(noun (cat 3 %c %x) file-path))
=/  line=tank  (snag (~(rad og eny) (lent file)) file)
=/  tongue=tape  "U"
=/  thoughts=tape  "o"
=/  eyes=tape  "oo"
|^
  ^-  (sole-product:sole (cask tang))
  =/  bubble=(list [%leaf tape])  (turn message bars)
  =/  bubble-width=@  (lent (snag 0 bubble))
  =/  horizontal-border=[%leaf tape]
    leaf+(weld "  " (reap (sub bubble-width 5) '-'))
  =/  slant-gap=tape  (reap (sub bubble-width 5) ' ')
  =/  top-slant=[%leaf tape]  leaf+" /{slant-gap}\\"
  =/  bottom-slant=[%leaf tape]  leaf+" \\{slant-gap}/"
  %+  produce  %tang
  ;:  weld
    :~  leaf+"            ||     ||"
        leaf+"          {tongue} ||----w |"
        leaf+"        (__)\\       )\\/\\"
        leaf+"      {thoughts} ({eyes})\\_______"
        leaf+"     {thoughts}  ^__^"
    ==
    ~[horizontal-border bottom-slant]
    bubble
    ~[top-slant horizontal-border]
  ==
++  message
  ^-  (list tape)
  =/  quote=tape
    ?+  line  ""
      [%leaf *]  p.line
    ==
  (flop (split quote))
++  split
  |=  tap=tape
  ^-  (list tape)
  ?:  (gth (lent tap) max-length)
    =/  trimmed=[p=tape q=tape]  (trim max-length tap)
    (weld ~[p.trimmed] (split q.trimmed))
  ~[tap]
++  bars
  |=  tap=tape
  ^-  [%leaf tape]
  =/  tape-length=@  (lent tap)
  ?:  (lth tape-length max-length)
    =/  padded-tap=tape  (weld tap (reap (sub max-length tape-length) ' '))
    leaf+"| {padded-tap} |"
  leaf+"| {tap} |"
--
