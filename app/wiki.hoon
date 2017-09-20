:: wiki
/?  314
/-  wiki
/+  frontmatter
[wiki .]
!:
|%
++  move  {bone card}
++  card
  $%
    {$info wire @p toro}
    {$diff drift}
    {$warp wire sock riff}
    {$peer wire {@p term} path}
    {$pull wire {@p term} $~}
  ==
++  drift
  $?
    {$wiki-change delt}
    {$wiki-articles (list delt)}
    {$json json}
  ==
++  config
  $%
    {$serve d/desk}
    {$export pax/path}
    {$import pax/path}
  ==
++  callback-state
  $%
    {$query todo/(set wire) done/(list delt)}
    {$import todo/(jar cord delt)}
  ==
--
::
|_  $:
  hid/bowl
  articles/(list {@t $~})
  initialized/_|
  wiki-desk/_'home'
  cabs/(map wire callback-state)
==
::++  prep  _`.  :: wipe state when app code is changed
::
:: general configuration interface
++  poke-noun
  |=  a/config
  ?>  (team our.hid src.hid)      :: don't allow strangers
  ?-  a
  {$serve *}
    ?:  =(d.a wiki-desk)
      ~&  [%already-serving-from d.a]
      [~ +>.$]
    :: clear cached article list and unsubscribe from previous desk
    ~&  [%serving-from d.a]
    =+  moves=(unwatch-dir wiki-base-path)
    =.  wiki-desk  d.a
    =.  initialized  |                                  :: invalidate cache
    =+  res=(get-articles wiki-base-path-full)
    [(welp moves -.res) +.res]
  {$export *}
    ~&  [%export pax=pax.a]
    (export pax.a)
  {$import *}
    ~&  [%import pax=pax.a]
    (import pax.a)
  ==
::
:: save an updated wiki, or request
++  poke-wiki-change
  |=  a/delt
  ^-  {(list move) _+>.$}
  ~|  poked-with=a
  :_  +>.$
  :: do a security check - only duke or better allowed
  ?.  ?=(?($czar $king $duke) (clan src.hid))
    ~|  %duke-or-better-required
    !!
  =+  w=(read-wiki-immediate art.a)
  :: do a version check
  ?.  =(ver.a ver.w)
    ~|  %version-check-failed
    !!
  :: increment version
  =+  newver=(get-next-version (escape-for-label art.w) +((rash ver.w dem:ag)))
  =+  a=a(ver (scot %ud newver), at now.hid, aut (scot %p src.hid))
  (write-new-wiki-version [a newver]~)
::
++  peer-wiki-article
  |=  pax/path
  ^-  {(list move) _+>.$}
  ~&  [%subscribed-to pax=pax]
  ?:  =(pax /list)
    (get-articles wiki-base-path-full)
  ?:  =(-.pax 'content')
    =+  art=(woad (snag 1 pax))
    =+  w=(read-wiki-immediate art)
    :_  +>.$
    (diff-by-ost %wiki-change w)
  ?:  =(-.pax 'history')
    (get-history (slag 1 pax))
  [~ +>.$]
::
++  wiki-base-path
  `path`/web/pages/wiki/pub
::
++  wiki-base-path-full
  (wiki-base-path-full-at da+now.hid)
::
++  wiki-base-path-full-at
  |=  at/case
  %-  tope
  %-  beam
  :_  (flop wiki-base-path)
  (beak our.hid wiki-desk at)
::
++  relpath-from-article
  |=  art/cord
  =+  ^-  ext/path  [(escape art) %md ~]
  (weld wiki-base-path ext)
::
++  path-from-article
  |=  art/cord
  (path-from-article-at art da+now.hid)
::
++  path-from-article-at
  |=  {art/cord at/case}
  ^-  path
  =+  ^-  ext/path  [(escape art) %md ~]
  (weld (wiki-base-path-full-at at) ext)
::
++  article-header
  |=  a/delt
  ^-  (map cord cord)
  %-  malt
  %-  limo
  :*
    [%author aut.a]
    [%at (scot %da at.a)]
    [%article art.a]
    [%version ver.a]
    [%message msg.a]
    ~
  ==
::
++  read-wiki
  |=  {art/cord wir/wire}
  (read-wiki-at art wir da+now.hid)
::
++  read-wiki-at
  |=  {art/cord wir/wire cas/case}
  =+  pax=(relpath-from-article art)
  (read wir [%sing %x cas pax])
::
++  read
  |=  {wir/wire rav/rave}
  [ost.hid %warp wir [our.hid our.hid] [wiki-desk (some rav)]]~
::
++  read-wiki-immediate
  |=  art/cord
  ^-  delt
  =+  pax=(path-from-article art)
  =+  maybe=(file pax)
  ?~  maybe
    :: article doesn't exist, return a default structure
    =+  r=*delt
    r(art art, ver '0')
  =+  v=(need maybe)
  ?.  ?=(@t v)
    ~|  %no-content
    !!
  =+  ^-  u/@t  v
  (parse-wiki u)
::
++  parse-wiki
  |=  u/@t
  ^-  delt
  =+  [atr mud]=(parse:frontmatter (lore u))
  =+  aut=(~(got by atr) 'author')
  =+  at=(slav %da (~(got by atr) 'at'))
  =+  art=(~(got by atr) 'article')
  =+  ver=(~(got by atr) 'version')
  =+  msg=(fall (~(get by atr) 'message') '')
  :*
    aut
    at
    art
    mud
    ver
    msg
  ==
::
:: write a wiki version, create a label and notify subscribers
++  write-new-wiki-version
  |=  items/(list {a/delt ver/@ud})
  ^-  (list move)
  %-  welp
  :_
    %-  zing
    %+  turn  items
    |=  {a/delt ver/@ud}
    %+    weld
      (create-label (escape-for-label art.a) ver)
    :: since this is a write, notify all clients
    (diff-by-path /wiki/article/content %wiki-change a)
  %-  write-wiki
  %+  turn  items
  |=  {a/delt ver/@ud}
  =+  dom=.^(dome cv+wiki-base-path-full)
  =+  pax=(path-from-article-at art.a ud+let.dom)
  [a pax]
::
++  write-wiki
  |=  items/(list {a/delt pax/path})
  ^-  (list move)
  %-  write-md
  %+  turn  items
  |=  {a/delt pax/path}
  :-  pax
  %-  nule
  %+  print:frontmatter
    (article-header a)
  ~[cot.a]
::
++  write-md
  |=  items/(list {pax/path cot/cord})
  %-  write
  %+  turn  items
  |=  {pax/path cot/cord}
  [pax [%md !>(cot)]]
::
++  write
  |=  items/(list {pax/path val/cage})
  ^-  (list move)
  =/  wr
  %+  turn  items
  |=  {pax/path val/cage}
  ?>  ?=({* * * *} pax)
  [t.t.t.pax (feel pax val)]
  [ost.hid %info /writing our.hid wiki-desk %& wr]~
::
++  watch-dir
  |=  a/path
  ^-  (list move)
  :~  :-  ost.hid
    :^    %warp
        /article/list
      [our.hid our.hid]
    :-  wiki-desk
    :-  ~
    [%next %y da+now.hid a]
  ==
::
++  unwatch-dir
  |=  a/path
  ^-  (list move)
  :~  :-  ost.hid
    :^    %warp
        /article/list
      [our.hid our.hid]
    :-  wiki-desk
    ~
  ==
::
++  writ
  |=  {way/wire rot/riot}
  ?:  =(way /article/list)
    =.  initialized  |                                  :: invalidate cache
    (get-articles wiki-base-path-full)
  ?:  =(way /import)
    (import-callback way rot)
  :: history query result
  (history-callback way rot)
::
++  escape-for-label
  |=  a/@t
  ^-  @tas
  ?:  =(a '')
    ''
  =+  first=(end 3 1 a)
  %-  cat
  :-  3
  :_  $(a (rsh 3 1 a))
  ?:
    ?|
      &((gte first 'a') (lte first 'z'))
      &((gte first '0') (lte first '9'))
    ==
    first
  (cat 3 '-' (scot %ud first))
::
++  escape
  |=  a/@t
  ^-  @t
  ?:  =(a '')
    ''
  =+  first=(end 3 1 a)
  %-  cat
  :-  3
  :_  $(a (rsh 3 1 a))
  ?:  =(first '/')  '~2f'
  ?:  =(first '~')  '~7e'
  first
::
++  unescape
  |=  a/@t
  ^-  @t
  ?:  =(a '')
    ''
  =+  first=(end 3 1 a)
  ?.  =(first '~')
    (cat 3 first $(a (rsh 3 1 a)))
  =+  code=(end 3 2 (rsh 3 1 a))
  %-  cat
  :-  3
  :_  $(a (rsh 3 3 a))
  ?:  =(code '2f')  '/'
  ?:  =(code '7e')  '~'
  ~|  [%bad-sequence code=`@t`code]
  !!
::
++  diff-by-path
  |=  {pax/path d/drift}
  %+  turn  (pale hid (prix pax))
  |=({o/bone *} `move`[o %diff d])
::
++  diff-by-src
  |=  {pax/path s/ship d/drift}
  %+  turn  (pale hid (prix-and-src pax s))
  |=({o/bone *} `move`[o %diff d])
::
++  diff-by-ost
  |=  {d/drift}
  [ost.hid %diff d]~
::
:: get cached article list, initialize if needed
++  get-articles
  |=  pax/path
  ^-  {(list move) _+>.$}
  ?.  initialized
    =.  initialized  &
    =.  articles  (list-dir-articles pax)
    :_  +>.$
    %+  welp  (watch-dir wiki-base-path)
    :: since the cache was rebuilt, notify all subscribers
    (diff-by-path /wiki/article/list %json (jobe articles))
  :_  +>.$
  :: since there was no change, notify only the event source
  (diff-by-ost %json (jobe articles))
::
++  list-dir-articles
  |=  pax/path
  ^-  _articles
  %+  murn  (~(tap by (list-dir pax)) ~)
  |=  {p/@t q/*}
  ?~  q
    ~
  (some [(unescape p) ~])
::
::  get directory listing (for md files) once
++  list-dir
  |=  pax/path
  ^-  (map @t *)
  =+  ls=.^(arch %cy pax)
  %-  ~(urn by dir.ls)
  |=  {p/knot q/$~}
  =+  subfil=.^(arch %cy (welp pax p ~))
  ?~  ((soft (map @t *)) dir.subfil)
    ~
  ?.  (~(has by dir.subfil) %md)
    ~
  =+  a=.^(noun cx+(welp pax [p] [%md] ~))
  ?.  ?=(@t a)
    ~
  =+  [atr mud]=(parse:frontmatter (lore a))
  atr
::
++  get-history
  |=  pax/path
  ^-  (quip move +>)
  =+  way=(weld `path`/article/history pax)
  =+  art=(woad -.pax)
  =+  latest=(read-wiki-immediate art)
  ?:  =(ver.latest '0')
    (history-finish way ~)
  =+  done=~[latest]
  ?:  =(ver.latest '1')
    (history-finish way done)
  =+  rev=(rash ver.latest dem:ag)
  =/  min
  ?~  +.pax
    :: get all history
    1
  ::  look back for no more than 10 revision
  ?:((lte rev 9) 1 (sub rev 9))
  =+  revisions=(gulf min (dec rev))
  =/  todo-map
  %-  malt
  %+  murn  revisions
  |=  rev/@ud
  =+  subway=(welp way /[(scot %ud rev)])
  =+  moves=(get-history-for-rev subway art rev)
  ?~  moves
    ~
  (some [subway moves])
  =+  todo=~(key by todo-map)
  ?~  todo
    (history-finish way done)
  :-  (zing ~(val by todo-map))
  +>.$(cabs (~(put by cabs) way [%query todo done]))
::
++  history-finish
  |=  {way/wire res/(list delt)}
  :_  +>.$
  (diff-by-ost %wiki-articles (flop (sort res dor)))
::
++  history-callback
  |=  {way/wire rot/riot}
  ^-  (quip move +>)
  =+  par=(scag (dec (lent way)) way)
  =+  cab=(~(got by cabs) par)
  ?>  ?=({$query *} cab)
  =/  done
  %+  welp  done.cab
  =+  a=(need rot)
  =+  p=q.a
  =+  u=q.q.r.a
  ?.  ?=(@t u)
    ~&  %no-content
    ~
  =+  w=(parse-wiki u)
  ~[w]
  :: remove from todo set
  =+  todo=(~(del in todo.cab) way)
  ?~  todo
    :: finished all todo for this callback
    =.  cabs  (~(del by cabs) par)
    (history-finish par done)
  :-  ~
  +>.$(cabs (~(put by cabs) par [%query todo done]))
::
++  get-history-for-rev
  |=  {way/wire art/cord rev/@ud}
  ^-  (list move)
  =+  dom=.^(dome cv+wiki-base-path-full)
  =+  labels=lab.dom
  :: check that the label exists
  =+  label=(label-for-rev (escape-for-label art) rev)
  ?~  (~(get by labels) label)
    ~
  (read-wiki-at art way tas+label)
::
++  label-for-rev
  |=  {art/@t ver/@ud}
  ^-  @tas
  (rap 3 %wiki- art '-' (scot %ud ver) ~)
::
++  create-label
  |=  {art/@t ver/@ud}
  ^-  (list move)
  =+  label=(label-for-rev art ver)
  :: check that label doesn't exist yet
  =+  dom=.^(dome cv+wiki-base-path-full)
  ?^  (~(get by lab.dom) label)
    ~|  [%label-already-exists label=label]
    !!
  [ost.hid %info /wiki-label our.hid wiki-desk %| label]~
::
:: check if the label for the next version is not taken, otherwise increment
++  get-next-version
  |=  {art/@t ver/@ud}
  =+  dom=.^(dome cv+wiki-base-path-full)
  |-
  =+  label=(label-for-rev art ver)
  ?^  (~(get by lab.dom) label)
    $(ver +(ver))
  ver
::
++  export
  |=  pax/path
  ^-  (quip move +>)
  =+  way=/export/[(wood (spat pax))]
  =/  todo-map
  %-  malt
  %+  murn  (~(tap by (list-dir wiki-base-path-full)) ~)
  |=  {p/@t q/*}
  ?~  q
    ~
  =+  art=(wood (unescape p))
  =+  subway=(welp way /[art])
  %-  some
  :-  subway
  [ost.hid %peer subway [our.hid %wiki] /wiki/article/history/[art]]~
  =+  todo=~(key by todo-map)
  ?~  todo
    ~&  %nothing-to-export
    [~ +>.$]
  :-  (zing ~(val by todo-map))
  +>.$(cabs (~(put by cabs) way [%query todo ~]))
::
++  diff-wiki-articles
  |=  {way/wire articles/(list delt)}
  ^-  (quip move +>)
  =+  par=(scag (dec (lent way)) way)
  =+  cab=(~(got by cabs) par)
  ?>  ?=({$query *} cab)
  =+  done=(weld done.cab articles)
  =+  todo=(~(del in todo.cab) way)
  =+  pull=[ost.hid %pull way [our.hid %wiki] ~]
  ?~  todo
    :-  (welp ~[pull] (export-finish way done))
    +>.$(cabs (~(del by cabs) par))
  :-  ~[pull]
  +>.$(cabs (~(put by cabs) par [%query todo done]))
::
++  export-finish
  |=  {way/wire articles/(list delt)}
  ^-  (list move)
  =+  pax=(stab (woad (snag 1 way)))
  =+  wr=(foal pax [%wiki-articles !>(articles)])
  [ost.hid %info /writing our.hid wr]~
::
++  import
  |=  pax/path
  ^-  (quip move +>)
  =+  maybe=(file pax)
  ?~  maybe
    ~&  [%load-failed pax=pax]
    [~ +>.$]
  :: sort article in decreasing (because they are inserted reversed) version order
  =+  articles=(flop (sort (from-raw-delt-list (need maybe)) dor))
  ~&  %+  turn  articles  |=(a/delt [art.a ver.a])
  :: collect the list of articles into a map of list of revisions per article
  =|  todo/(jar cord delt)
  =.  todo
  |-
  ?:  =(articles ~)
    todo
  =+  first=(snag 0 articles)
  $(todo (~(add ja todo) art.first first), articles (slag 1 articles))
  =+  way=/import
  =.  cabs  (~(put by cabs) way [%import todo])
  (import-callback way ~)
::
++  import-callback
  |=  {way/wire rot/riot}
  ^-  (quip move +>)
  =+  cab=(~(got by cabs) way)
  ?>  ?=({$import *} cab)
  ?:  =(todo.cab ~)
    ~&  %import-done
    :-  ~
    +>.$(initialized |, cabs (~(del by cabs) way))
  =+  todos=~(val by todo.cab)
  =/  nexts
  %+  turn  todos
  |=  revs/(list delt)
  (snag 0 revs)
  =/  todo
  %-  malt
  %+  murn  (~(tap by todo.cab) ~)
  |=  {art/cord revs/(list delt)}
  =+  rest=(slag 1 revs)
  ?~  rest
    ~
  (some [art rest])
  =.  cabs  (~(put by cabs) way [%import todo])
  :_  +>.$
  %-  welp
  :_
    :: register callback for when the next commit appears
    =+  dom=.^(dome cv+wiki-base-path-full)
    =+  let=+(let.dom)
    (read way [%next %x ud+let wiki-base-path])
  %-  write-new-wiki-version
  %+  turn  nexts
  |=  next/delt
  [next (slav %ud ver.next)]
::
++  from-raw-delt-list
  |=  r/*
  ?~  r
    ~
  ?>  ?=(^ r)
  =+  ^-  c/{p/* q/*}  r
  ?>  ?=(delt p.c)
  [i=`delt`p.c t=$(r q.c)]
::
++  reap
  |=  {wir/wire error/(unit tang)}
  ^-  {(list move) _+>.$}
  ?~  error
    [~ +>.$]
  ~|  [%subscription-failed error]
  [~ +>.$]
::
:: filter by path prefix and event source
++  prix-and-src
  |=  {pax/path src/ship}
  (both (prix pax) (bysrc src))
::
++  both  :: filter by two criteria
  |=  {a/$-(sink ?) b/$-(sink ?)}  |=  s/sink  ^-  ?
  &((a s) (b s))
::
++  bysrc            :: filter by src
  |=  src/ship  |=  sink  ^-  ?
  =(q.+< src)
--
