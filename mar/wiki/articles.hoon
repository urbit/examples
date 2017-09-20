/-  wiki
[wiki .]
!:
|_  {articles/(list delt)}
++  grab
  |%
  ++  noun  (list delt)
  ++  mime  |=(^mime (json (rash q.q apex:poja)))
  ++  json
    |=  jon/^json
    ^-  (list delt)
    (need ((ar (ot author+so at+di article+so content+so version+so message+so ~)):jo jon))
  --
++  grow
  |%
  ++  mime  [/text/wiki-articles (taco (crip (pojo json)))]
  ++  json
    :-  %a
    %+  turn  articles
    |=  article/delt
    %-  jobe
    :*
      [%author (jape (trip aut.article))]
      [%at (jode ?:(=(at.article *@da) ~1970.1.1 at.article))]
      [%article (jape (trip art.article))]
      [%content (jape (trip cot.article))]
      [%version (jape (trip ver.article))]
      [%message (jape (trip msg.article))]
      ~
    ==
  --
--
