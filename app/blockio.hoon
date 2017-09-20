::
::  block.io wallet manager & automator
::
::TODO  probably just use zuse's ++file, ++foal etc...
::TODO  add termwidth to state, wrap (error) lines when printing.
::TODO  either learn how to use lib/write or make an easier.better alternative.
::TODO  eventually do client-side tx signing, maybe:
::      https://block.io/api/simple/signing
::
/-  blockio, talk, plan-acct, plan-diff
/+  blockio, talk, sole
!:
[. blockio sole]
::
|%
++  state                                               ::>  full app state
  $:  soles/(map bone sole-share)                       ::<  console state
      style/manners                                     ::<  behavior config
      heard/(set serial:talk)                           ::<  parsed messages
      nomes/(map tape @p)                               ::<  recent comet names
      pends/(pair @ud (map @ud pending))                ::<  pending actions
  ==                                                    ::
++  manners                                             ::>  behavior config
  $:  coin/currency                                     ::<  selected currency
      talk/_|                                           ::<  listen to talk
  ==                                                    ::
++  pending                                             ::>  pending action
  $:  act/action                                        ::<  original action
      aud/(unit audience:talk)                          ::<  informable audience
  ==                                                    ::
++  action                                              ::>  console action
  $%  {$coin cur/currency}                              ::<  set active currency
      {$key key/(unit @t)}                              ::<  un/set key for cur
      {$pin pin/(unit @t)}                              ::<  un/set pin
      {$address adr/(unit @t)}                          ::<  un/set public addr
      {$balance $~}                                     ::<  check balance
      {$transfer who/target cur/currency val/tape}      ::<  send coin to ship
      {$talk yes/(unit ?)}                              ::<  toggle talk watching
      {$pending $~}                                     ::<  list pending actions
      {$help $~}                                        ::<  print help text
  ==                                                    ::
++  request                                             ::>  http request
  $%  {$balance cur/currency}                           ::<  get account balance
      {$withdraw adr/tape cur/currency val/tape}        ::<  transfer out
  ==                                                    ::
++  target  $@(ship tape)                               ::<  transaction target
++  plan  {{who/@tx loc/@tx} acc/(map knot plan-acct)}  ::<  web.plan shape
::TODO  more type-wrapping molds. ++value, for example! ::
::                                                      ::
++  move  {bone card}                                   ::<  [target side-effect]
++  card                                                ::>  side-effect
  $%  {$diff $sole-effect sole-effect}                  ::<  cli change
      {$hiss wire {$~ $~} mark {$purl purl}}            ::<  http request
      {$exec wire @p $~ {beak silk}}                    ::<  data write?
      {$info wire @p toro}                              ::<  internal edit
      {$warp wire sock riff}                            ::<  file request
      {$peer wire dock path}                            ::<  start subscription
      {$pull wire dock $~}                              ::<  end subscription
      {$poke wire {@p term} $talk-command command:talk} ::<  talk-command poke
      {$wait wire @da}                                  ::<  timer
  ==                                                    ::
::                                                      ::
++  burl  "https://block.io/api/v2/"                    ::<  base api url
--
::
|_  {bol/bowl state}
::
++  prep                                                ::>  adapt state
  |=  old/(unit state)
  ^-  (quip move ..prep)
  ?~  old  [~ ..prep]
  [~ ..prep(+<+ u.old)]
::
::>  local file utilities
::TODO  probably replace with lib or something.
::
++  beak-now  byk.bol(r [%da now.bol])                  ::<  current beak
::
++  ames-secret                                         ::<  encryption secret
  ^-  @t
  =-  (crip +:<.^(@p %a -)>)
  =+  (scot %p our.bol)
  /[-]/code/(scot %da now.bol)/[-]
::
++  hav-file                                            ::>  have file at path?
  |=  pax/path
  ::NOTE  %cu not implemented, so we use %cy instead.
  =-  ?=(^ fil.-)
  .^(arch %cy pax)
::
++  hav-sec                                             ::>  have /sec/io/block?
  (hav-file (welp (tope beak-now ~) /sec/io/block/atom))
::
++  get-sec                                             ::>  get /sec/io/block
  ^-  secrets
  ?.  hav-sec  *secrets
  %-  secrets
  %-  cue
  %-  need
  =-  (de:crua ames-secret (slav %uw -))
  .^(@ %cx (welp (tope beak-now ~) /sec/io/block/atom))
::
++  hav-key                                             ::>  have key for coin?
  |=  con/currency
  ?.  hav-sec  |
  (~(has by p:get-sec) con)
::
++  hav-pin                                             ::>  have pincode set?
  ?.  hav-sec  |
  !=('' q:get-sec)
::
++  hav-plan                                            ::>  have /web/plan?
  (hav-file /=home/(scot %da now.bol)/web/plan)
::
++  get-plan                                            ::>  get /web/plan
  ^-  plan
  ?.  hav-plan  *plan
  .^(plan %cx /=home/(scot %da now.bol)/web/plan)
::
++  get-address                                         ::>  coin addr from plan
  |=  {pan/plan cur/currency}
  ^-  (unit tape)
  =+  (crip (cur-net cur))
  ?.  (~(has by acc.pan) -)  ~
  `(trip usr:(~(got by acc.pan) -))
::
++  osol  [ost.bol (~(got by soles) ost.bol)]           ::<  current sole
::
++  peek                                                ::>  action num from wire
  |=  wir/wire
  ^-  (unit @ud)
  ?~  wir  ~
  =+  num=(slav %ud i.wir)
  ?:((~(has by q.pends) num) `num ~)
  ::TODO  if we actually want to continue doing the above,
  ::      we never need to (~(has by q.pends) u.ped)
::
++  taa                                                 ::>  initiated ++ta core
  |=  wir/wire
  ~(. ta ~ (peek wir) | ~)
::
::>  worker cores
::
++  ta                                                  ::>  per transaction
  |_  $:  moves/(list move)
          pen/(unit @ud)
          don/?
          actions/(list action)
      ==
  ::
  ++  ta-done                                           ::>  fold core
    ^-  (quip move +>)
    ?^  actions
      ta-done:(ta-actions(actions ~) actions)
    :-  (flop moves)
    %_  +>
        q.pends
      ?.  ?&(don ?=(^ pen))  q.pends
      (~(del by q.pends) u.pen)
    ==
  ::
  ::>  emitters
  ::
  ++  ta-deal                                           ::>  play card
    |=  c/card
    +>(moves [[ost.bol c] moves])
  ::
  ++  ta-dall                                           ::>  play cards
    |=  c/(list card)
    =+  (turn c |=(c/card [ost.bol c]))
    +>(moves [(flop -) moves])
  ::
  ++  ta-httr                                           ::>  construct http req
    |=  {wir/wire cur/currency mar/mark url/tape}
    ^+  +>
    %-  ta-deal
    =-  [%hiss [(scot %ud (dec p.pends)) wir] [~ ~] mar %purl -]
    =+  pur=(need (epur (crip url)))
    pur(r [['api_key' cur] r.pur])
  ::
  ::
  ++  ta-act                                            ::>  store action
    |=  a/action
    +>(actions [a actions])
  ::
  ++  ta-pend                                           ::>  action is pending
    |=  {act/action aud/(unit audience:talk)}
    %.  p.pends
    %_  ta-wait
      p.pends  +(p.pends)
      q.pends  (~(put by q.pends) p.pends act aud)
    ==
  ::
  ++  ta-wait                                           ::>  timeout for pend
    |=  num/@ud
    (ta-deal %wait /(scot %ud num) (add now.bol ~m1))
  ::
  ::>  data access
  ::
  ++  ta-audible                                        ::>  does pend have aud?
    ?~  pen  |
    ?&  (~(has by q.pends) u.pen)
        ?=(^ [aud:(~(got by q.pends) u.pen)])
    ==
  ::
  ++  ta-audience                                       ::>  audience of pend
    ^-  (unit audience:talk)
    ?~  pen  ~
    aud:(~(got by q.pends) u.pen)
  ::
  ::>  direct events
  ::
  ++  ta-peer-sole                                      ::>  console connected
    sh-done:~(sh-peer sh ost.bol *sole-share)
  ::
  ++  ta-sole-action                                    ::>  route console event
    |=  act/sole-action
    ^+  +>
    sh-done:(~(sh-sole-action sh osol) act)
  ::
  ++  ta-actions                                        ::>  take actions
    |=  {acs/(list action)}
    ^+  +>
    ?~  acs  +>
    =.  +>  (ta-action i.acs)
    $(acs t.acs)
  ::
  ++  ta-action                                         ::>  take action
    |=  act/action
    ^+  +>
    ?-  -.act
      $coin       sh-done:~(sh-prompt sh(coin.style cur.act) osol)
      $key        (ta-put-key key.act)
      $pin        (ta-put-pin pin.act)
      $address    (ta-put-address adr.act)
      $balance    =.  +>  (ta-pend [%balance ~] ~)
                  (ta-request %balance coin.style)
      $transfer   (ta-transfer who.act cur.act val.act ~ ~)
      $talk       (ta-listen (fall yes.act !talk.style))
      $pending    sh-done:~(sh-pending sh osol)
      $help       sh-done:~(sh-help sh osol)
    ==
  ::
  ::>  sec operations
  ::
  ++  ta-put-sec                                        ::>  store /sec/io/block
    |=  sec/secrets
    =+  dat=(jam sec)
    %-  ta-deal
    =.  dat  (scot %uw (en:crua ames-secret dat))
    :+  %exec  /sec/io/block
    :^  our.bol  ~  beak-now
    :+  %cast  %atom
    $+[%mime !>([/ (taco dat)])]
  ::
  ++  ta-put-plan                                       ::>  put plan into file
    |=  pif/plan-diff
    %-  ta-deal
    =-  [%info /write our.bol [q.byk.bol %& -]]
    [/web/plan %dif plan-diff+!>(pif)]~
  ::
  ++  ta-put-address                                    ::>  put account in plan
    |=  adr/(unit @t)
    =+  key=(crip (cur-net coin.style))
    %-  ta-put-plan
    ^-  plan-diff
    :-  ~
    ?~  adr  [[[key ~] ~ ~] ~]
    [~ [[key [u.adr ~]] ~ ~]]  ::TODO  maybe url after adr
  ::
  ++  ta-put-key                                        ::>  un/set key for coin
    |=  key/(unit @t)
    =+  sec=get-sec
    %-  ta-put-sec
    %=  sec  p
      ?~  key  (~(del by p.sec) coin.style)
      (~(put by p.sec) coin.style u.key)
    ==
  ::
  ++  ta-put-pin                                        ::>  un/set pin
    |=  pin/(unit @t)
    =+  sec=get-sec
    %-  ta-put-sec
    sec(q (fall pin ''))
  ::
  ++  ta-fetch-plan                                     ::>  try get remote plan
    |=  {who/ship pax/path}
    ^+  +>
    =+  woh=(scot %p who)
    =/  soc/sock
      [our.bol who]
    =/  rif/riff
      [%home `[%sing %x [%da (sub now.bol ~m5)] /web/plan]]
    (ta-deal %warp [%plan (scot %ud (dec p.pends)) (scot %p who) pax] soc rif)
  ::
  ::>  coin operations
  ::
  ++  ta-request                                        ::>  send http request
    |=  req/request
    ^+  +>
    =/  ped
      ?~  pen  *pending
      (fall (~(get by q.pends) pen) *pending)
    =.  don  &
    ::TODO  PASTE1
    ?:  &(?=($withdraw -.req) !hav-pin)
      =>  %=  .  +>.$  ::TODO  NF1
        ?~  aud.ped  +>.$
        =-  (ta-lk-error - ped)
        "No block.io pin. `pin your-secret` to set."
      ==
      sh-done:~(sh-no-pin sh(don &) osol)
    ?-  -.req
        $balance
      ?.  (hav-key cur.req)  ::TODO  v
        =>  %=  .  +>.$  ::TODO  NF1
          ?~  aud.ped  +>.$
          =-  (ta-lk-error - ped)
          "No API key for {(cur-net cur.req)}. `key abcd-12...` to set."
        ==
        sh-done:(~(sh-no-key sh(don &) osol) cur.req)
      %^  ta-httr  /req/balance  cur.req
      [%blockio-balance (weld burl "get_balance/")]
      ::
        $withdraw
      ?.  (hav-key cur.req)  ::TODO  ^
        =>  %=  .  +>.$  ::TODO  NF1
          ?~  aud.ped  +>.$
          =-  (ta-lk-error - ped)
          "No API key for {(cur-net cur.req)}. `key abcd-12...` to set."
        ==
        sh-done:(~(sh-no-key sh(don &) osol) cur.req)
      %^  ta-httr  /req/withdraw  cur.req
      :-  %blockio-withdraw
      ;:  weld
        burl  "withdraw/"
        "?amounts="       val.req
        "&to_addresses="  adr.req
        "&pin="
      ==
    ==
  ::
  ++  ta-transfer                                       ::>  try send to target
    |=  {who/target cur/currency val/tape aud/(unit audience:talk) ori/(unit @p)}
    ^+  +>
    =.  +>  (ta-pend [%transfer (fall ori who) cur val] ?~(aud ta-audience aud))
    ?^  who  (ta-request %withdraw who cur val)
    ::  shortcut for self
    ?:  =(who our.bol)
      =+  tar=(get-address get-plan cur)
      ?^  tar  (ta-request %withdraw u.tar cur val)
      =.  don  &
      =.  pen  [~ (dec p.pends)]
      sh-done:(~(sh-unknown sh osol) `@p`who cur)
    %+  ta-fetch-plan  `@p`who
    /transfer/[cur]/(crip val)
  ::
  ::>  misc actions
  ::
  ++  ta-listen                                         ::>  un/watch inbox
    |=  yes/?
    ^+  +>
    ?:  =(yes talk.style)
      =-  sh-done:(~(sh-effect sh osol) %txt -)
      %-  sh-pres:sh
      ?:  yes  "Already listening."
      "Already not listening."
    ?:  yes  ta-sub-talk
    %-  ta-deal(talk.style yes)
    [%pull /talk [our.bol %talk] ~]
  ::
  ++  ta-sub-talk                                       ::>  subscribe to inbox
    %-  ta-deal(talk.style &)
    =-  [%peer /talk [our.bol %talk] -]
    /f/[(main:talk our.bol)]/(scot %da now.bol)
  ::
  ::>  response events
  ::
  ++  ta-wake                                           ::>  check for timeout
    ^+  .
    =*  this  .
    ?~  pen  .  ::~&(%weird-no-pen-wake .)
    ?.  (~(has by q.pends) u.pen)  this
    =+  ped=(~(got by q.pends) u.pen)
    =.  q.pends  (~(del by q.pends) u.pen)
    =/  say/tape
      ?+  -.act.ped  !!
        $balance    "Balance request timed out."
        $transfer   ?^  who.act.ped  "Transfer timed out."
                    "Address request to {(cite `@p`who.act.ped)} timed out."
      ==
    ::TODO  this shit's just ridiculous
    =>  [sh-done:(~(sh-error sh osol) say) . say=say ped=ped]
    ?~  aud.ped  -
    (ta-lk-error say ped)
  ::
  ++  ta-blockio-balance                                ::>  take balance resp
    |=  bal/(each balance error)
    ^+  +>
    =.  don  &
    =<  sh-done
    ?-  -.bal
      $&  (~(sh-balance sh osol) p.bal)
      $|  (~(sh-error sh osol) p.bal)
    ==
  ::
  ++  ta-blockio-withdrawal                             ::>  take withdrawal resp
    |=  wil/(each withdrawal error)
    ^+  +>
    =.  +>  ::TODO  =?
      ?.  ta-audible  +>
      =+  ped=(~(got by q.pends) (need pen))
      ?-  -.wil
        $&  (ta-lk-withdrawal p.wil ped)
        $|  (ta-lk-error p.wil ped)
      ==
    =.  don  &
    =<  sh-done
    ?-  -.wil
      $&  (~(sh-withdrawal sh osol) p.wil)
      $|  (~(sh-error sh osol) p.wil)
    ==
  ::
  ++  ta-writ-plan                                      ::>  receive plan
    |=  {wir/wire rot/riot}
    ^+  +>
    ?~  pen  +>  ::  probably received after timeout.
    =.  don  &
    =+  ped=(~(got by q.pends) u.pen)
    ?.  ?=({@ *} wir)  !!
    =+  who=(slav %p i.wir)
    ?+  t.wir  ~&([%weird-writ-wire wir] !!)
        {$transfer currency cord $~}
      ::NOTE  =* because {... cur/currency ...} doesn't work...
      =*  cur  i.t.t.wir
      =*  val  i.t.t.t.wir
      ::TODO  PASTE1 fix copy-paste code/strings
      ?~  rot
        =>  %=  .  +>.$  ::TODO  NF1 investigate =.(+>.$ +>.$) nest-fail
          ?~  aud.ped  +>.$
          =-  (ta-lk-error - ped)
          "No {(cur-net cur)} address for {(scow %p who)}."
        ==
        sh-done:(~(sh-unknown sh osol) who cur)
      =+  adr=(get-address (plan q.q.r.u.rot) cur)
      ?~  adr
        =>  %=  .  +>.$  ::TODO  NF1
          ?~  aud.ped  +>.$
          =-  (ta-lk-error - ped)
          "No {(cur-net cur)} address for {(scow %p who)}."
        ==
        sh-done:(~(sh-unknown sh osol) who cur)
      (ta-transfer u.adr cur (trip val) aud.ped `who)
    ==
  ::
  ++  ta-read-grams                                     ::>  parse grams for cmd
    |=  gaz/(list telegram:talk)
    ^+  +>
    ?~  gaz  +>
    =*  gam  i.gaz
    ?:  (~(has in heard) p.q.gam)  $(gaz t.gaz)
    =.  heard  (~(put in heard) p.q.gam)
    =*  sep  r.r.q.gam
    =.  nomes
      ?.  =((clan p.gam) %pawn)  nomes
      (~(put by nomes) (cite p.gam) p.gam)
    ?:  ?&  =(p.gam our.bol)
            ?=($lin -.sep)
            =((find "!tip ~" (trip q.sep)) [~ 0])
        ==
      =+  res=(ta-parse-gram q.sep)
      ?~  res  +>.$
      =.  +>.$  (ta-transfer who.u.res cur.u.res val.u.res `q.q.gam ~)
      $(gaz t.gaz)
    $(gaz t.gaz)
  ::
  ++  ta-parse-gram                                     ::>  parse "!tip ~x c v"
    ::TODO  do better than just copy-pasting from sh-parse.
    |=  msg/cord
    ^-  (unit {who/@p val/tape cur/currency})
    %+  rush  msg
    ;~  plug
      ;~  pfix  (jest '!tip ~')
      ;~  pose
        %+  sear
          |=  r/(list @t)
          =+  (roll r |=({c/@t t/tape} (weld t (trip c))))
          (~(get by nomes) ['~' -])
        ;~(plug til:ab til:ab cab til:ab til:ab (easy ~))
        ::
        fed:ag
      ==  ==
      ::
      ;~  pfix  ace
        %+  cook
          |=  {a/tape b/tape}
          ?~  b  a
          :(weld a "." b)
        =+  (plus nud)
        ;~(plug - ;~(pose ;~(pfix dot -) (easy ~)))
      ==
      ::
      ;~  pfix  ace
        %-  perk  :~
          %btc-test    %btc
          %ltc-test    %ltc
          %doge-test   %doge
        ==
      ==
    ==
  ::
  ::>  talking
  ::
  ++  ta-lk-send                                        ::>  speech to audience
    |=  {aud/audience:talk sep/speech:talk}
    ^+  +>
    ::NOTE  this is such a mess, can't wait for new talk.
    %^  ta-deal  %poke  /speak
    :^  [our.bol %talk]
      %talk-command  %publish
    :_  ~
    :+  (shaf %thot eny.bol)
      aud
    [now.bol *bouquet:talk sep]
  ::
  ++  ta-lk-error                                       ::>  speak error
    |=  {err/error ped/pending}
    ^+  +>
    ?~  aud.ped  !!
    %+  ta-lk-send  u.aud.ped
    :+  %fat
      [%text [(crip err) ~]]
    :+  %app  dap.bol
    ?+  -.act.ped  (crip err)
      $transfer   'Failed to transact.'
    ==
  ::
  ++  ta-lk-withdrawal                                  ::>  speak confirmation
    |=  {wil/withdrawal ped/pending}
    ^+  +>
    ?~  aud.ped  !!
    ?.  ?=($transfer -.act.ped)  !!
    ?^  who.act.ped  !!
    %+  ta-lk-send  u.aud.ped
    :+  %fat
      :-  %text
      :~  (crip "paid: {paid.wil}:")
          (crip "sent: {sent.wil}")
          (crip " fee: {feen.wil}")
          (crip "txid: {txid.wil}")
          (crip "https://chain.so/tx/{(cur-net coin.wil)}/{txid.wil}")
      ==
    =-  [%app dap.bol (crip -)]
    "Confirmed: {val.act.ped} {(scow %tas coin.wil)} to {(cite `@p`who.act.ped)}."
  ::
  ++  sh                                                ::>  per console
    |_  {ost/bone share/sole-share}
    ::
    ++  sh-done                                         ::<  fold core
      +>(soles (~(put by soles) ost share))
    ::
    ::>  emitters
    ::
    ++  sh-deal                                         ::>  deal card
      |=  c/card
      +>(moves [[ost.bol c] moves])
    ::
    ++  sh-act                                          ::>  store action
      |=  a/action
      +>(actions [a actions])
    ::
    ++  sh-effect                                       ::>  send console effect
      |=  fec/sole-effect
      (sh-deal %diff %sole-effect fec)
    ::
    ::>  input
    ::
    ++  sh-sole-action                                  ::>  process sole-action
      |=  act/sole-action
      ^+  +>
      ?-  -.act
          $det                                          ::  buffer edit
        =^  inv  share  (~(transceive sole share) +.act)
        =+  fix=(sh-sanitize inv buf.share)
        ?~  lit.fix
          +>.$
        ::  just capital correction.
        ?~  err.fix
          (sh-rectify fix)
        ::  allow interior edits and deletes.
        ?.  &(?=($del -.inv) =(+(p.inv) (lent buf.share)))
          +>.$
        (sh-rectify fix)
        ::
          $ret                                          ::  buffer submit
        sh-perform
        ::
          $clr                                          ::  clear/reset
        +>
      ==
    ::
    ++  sh-perform                                      ::>  act on input
      =+  fix=(sh-sanitize [%nop ~] buf.share)
      ::  invalid, fixable input.
      ?^  lit.fix
        (sh-rectify fix)
      =+  act=(rust (tufa buf.share) sh-parse)
      ::  incomplete input.
      ?~  act  (sh-effect %bel ~)
      ::  perform work.
      %.  u.act
      =<  sh-act
      =+  buf=buf.share
      ::  clear sole buffer.
      =^  cal  share  (~(transmit sole share) [%set ~])
      ::  display command to the user.
      %-  sh-effect
      :*  %mor
          [%nex ~]
          [%det cal]
          ::  don't echo coin switches or api keys.
          ?:  ?=($coin -.u.act)  ~
          =.  buf  ::TODO  =?
            ?:  &(?=($key -.u.act) ?=(^ key.u.act))
              `(list @)`"key xxxx-xxxx-xxxx-xxxx"
            ?:  &(?=($pin -.u.act) ?=(^ pin.u.act))
              `(list @)`"pin ..."
            buf
          :_  ~
          [%txt (sh-prec (tufa `(list @)`buf))]
      ==
    ::
    ++  sh-sanitize                                     ::>  parse & sanitize cli
      |=  {inv/sole-edit buf/(list @c)}
      ^-  {lit/(list sole-edit) err/(unit @u)}
      =+  res=(rose (tufa buf) sh-parse)
      ::  no error, no problem.
      ?:  ?=($& -.res)  [~ ~]
      ::  parser errorred, so we produce the inverse
      ::  change and error location.
      [[inv]~ `p.res]
    ::
    ++  sh-rectify                                      ::>  fix console input
      |=  {lit/(list sole-edit) err/(unit @u)}
      ^+  +>
      ?~  lit  +>
      =^  lic  share
          %-  ~(transmit sole share)
          `sole-edit`?~(t.lit i.lit [%mor lit])
      %-  sh-effect
      [%mor [%det lic] ?~(err ~ [%err u.err]~)]
    ::
    ++  sh-parse                                        ::>  parse console input
      |^
      %+  knee  *action  |.  ~+
      ;~  pose
        ;~((glue ace) (perk %coin ~) curc)              ::  coin btc
        ::
        ;~  (glue ace)                                  ::  key xxxx-xxxx-xxx...
          (perk %key ~)
          (sopt apik)
        ==
        ::
        ;~  (glue ace)                                  ::  pin the secret
          (perk %pin ~)
          (sopt (cook crip ;~(plug next (plus next))))
        ==
        ::
        ;~  (glue ace)                                  ::  address 12abCD...
          (perk %address ~)
          (sopt (cook crip (plus ;~(pose hig low nud))))
        ==
        ::
        (comd %balance)                                 ::  balance
        ::
        ;~  (glue ace)                                  ::  transfer ~zod 1.23
          (perk %transfer ~)
          targ
          (cook |=(t/tape [coin.style t]) valu)
        ==
        ::
        ;~  plug                                        ::  talk y
          (perk %talk ~)
          (punt ;~(pfix ace lobe))
        ==
        ::
        (comd %pending)                                 ::  pending
        ::
        (comd %help)                                    ::  help
      ==
      ::
      ++  ship  ;~(pfix sig fed:ag)                     ::<  ship
      ::
      ++  comd  |*(a/term (cold [a ~] (perk a ~)))      ::<  single word action
      ::
      ++  sopt                                          ::>  rule or sig unit
        |*  a/rule
        ;~(pose (cook some a) (cold ~ sig))
      ::
      ++  lobe                                          ::>  y/n loob
        ;~  pose
          (cold %& ;~(pose (jest 'y') (jest '&')))
          (cold %| ;~(pose (jest 'n') (jest '|')))
        ==
      ::
      ++  targ                                          ::>  transaction target
        ;~  pose
          ship
          (plus ;~(pose hig low nud))
        ==
      ::
      ++  curc                                          ::>  currency
        %-  perk  :~                                    ::  longest match first
          %btc-test    %btc                             ::  so parser doesn't
          %ltc-test    %ltc                             ::  complete too early.
          %doge-test   %doge
        ==
      ::
      ++  apik                                          ::>  block.io api key
        =+  hep=(cold "-" hep)
        =+  kes=(stun [4 4] ;~(pose low nud))
        %+  cook  crip
        %+  cook  zing
        ;~(plug kes hep kes hep kes hep kes (easy ~))
      ::
      ++  valu                                          ::>  amount as tape
        %+  cook
          |=  {a/tape b/tape}
          ?~  b  a
          :(weld a "." b)
        =+  (plus nud)
        ;~(plug - ;~(pose ;~(pfix dot -) (easy ~)))
      --
    ::
    ::>  styling
    ::
    ++  sh-prompt                                       ::>  update prompt
      %^  sh-effect  %pro  &
      [%blockio "[{(scow %tas coin.style)}]: "]
    ::
    ++  sh-prec                                         ::>  prefix as echo
      |=  a/tape
      =-  (weld - a)
      %+  runt
        [(add 8 (lent (cite our.bol))) '·']
      " {(scow %tas coin.style)} > "
    ::
    ++  sh-pres                                         ::>  prefix as result
      |=  a/tape
      =-  (weld - a)
      (runt [(add 7 (lent (cite our.bol))) ' '] "| ")
    ::
    ++  sh-prin                                         ::>  prefix as info
      |=  a/tape
      =-  (weld - a)
      (runt [(add 7 (lent (cite our.bol))) ' '] ": ")
    ::
    ++  sh-pric                                         ::>  prefix as warning
      |=  a/tape
      =-  (weld - a)
      (runt [(add 6 (lent (cite our.bol))) ' '] "!! ")
    ::
    ::>  messages
    ::
    ++  sh-peer                                         ::>  print opening text
      ^+  .
      =<  sh-prompt
      %-  sh-effect  :-  %mor
      =-  (turn - |=(a/tape [%txt (sh-prin a)]))
      ^-  (list tape)
      :~  "To start off, select a `coin [currency]` and add a `key [api-key]`."
          "To do transactions, first enter your `pin [pincode]`."
          "For help, type `help`."
          "Note: changes to web.plan take 5 minutes to get picked up by the app."
      ==
    ::
    ++  sh-pending                                      ::>  show pending actions
      =-  (sh-effect [%mor [%txt "(inaccurate)"] (turn - |=({t/tape} [%txt t]))])
      (turn (~(tap by q.pends)) sh-pender)
    ::
    ++  sh-pender                                       ::>  render pend as tape
      |=  {num/@ud ped/pending}
      ^-  tape
      %+  weld  (scow %ud num)
      %+  weld  ?~(aud.ped " > " " > (talk) ")
      ?+  -.act.ped  "{(scow %tas -.act.ped)}"
          $balance
        "balance"
        ::
          $transfer
        =/  who/tape
          ?^  who.act.ped  who.act.ped
          (scow %p who.act.ped)
        "({(scow %tas cur.act.ped)}) transfer {who} {val.act.ped}"
      ==
    ::
    ++  sh-help                                         ::>  print help text
      =-  (sh-effect [%mor (turn - |=({t/tape} [%txt t]))])
      ^-  (list tape)  :~
        "::::  Block.io API client"
        "::  for ฿itcoin, Łitecoin, and Ðogecoin"
        "::::  Info"
        "::  - You probably don't want to put much of value into the block.io"
        "::    account you hook up to this."
        "::  - To prevent clock-sync issues, this app reads people's web.plan"
        "::    from 5 minutes ago. Your address changes take that long to take"
        "::    effect."
        "::::  Commands:"
        "::  coin [currency]"
        "::    set active coin (btc, ltc, doge, btc-test, ltc-test, doge-test)"
        "::  key [api-key]"
        "::    set block.io api key for active coin (format xxxx-xxxx-xxxx-xxxx)"
        "::    input ~ to forget key"
        "::  pin [pincode]"
        "::    set block.io pincode (required for transactions)"
        "::    input ~ to forget pin"
        "::  balance"
        "::    get total balance of active coin"
        "::  transfer [target] [amount]"
        "::    transfer an amount of active coin to the target (ship or address)"
        "::  talk \{y/n}"
        "::    toggle listening for in-talk commands"
        "::    responds to `!tip [~ship-name] [amount] [currency]`"
        "::::"
      ==
    ::
    ++  sh-no-key                                       ::>  tell no api key
      |=  cur/currency
      %+  sh-effect  %txt  %-  sh-pric
      "No API key for {(cur-net cur)}. `key abcd-12...` to set."
    ::
    ++  sh-no-pin                                       ::>  tell no pin
      %+  sh-effect  %txt  %-  sh-pric
      "No block.io pin. `pin your-secret` to set."
    ::
    ++  sh-unknown                                      ::>  tell no address info
      |=  {who/@p cur/currency}
      %+  sh-effect  %txt  %-  sh-pric
      "No {(cur-net cur)} address for {(scow %p who)}."
    ::
    ++  sh-error                                        ::>  display error
      |=  err/error
      (sh-effect %txt (sh-pric err))
    ::
    ++  sh-balance                                      ::>  display balance
      |=  bal/balance
      ^+  +>
      %-  sh-effect
      :-  %mor
      :~  [%txt (sh-pres "have: {have.bal}")]
          [%txt (sh-pres "pend: {pend.bal}")]
      ==
    ::
    ++  sh-withdrawal                                   ::>  display transaction
      |=  wil/withdrawal
      ^+  +>
      %-  sh-effect
      :-  %mor
      :~  [%txt (sh-pres "paid: {paid.wil}:")]
          [%txt (sh-pres "sent: {sent.wil}")]
          [%txt (sh-pres " fee: {feen.wil}")]
          [%txt (sh-pres "txid: {txid.wil}")]
          [%txt "https://chain.so/tx/{(cur-net coin.wil)}/{txid.wil}"]
      ==
    --
  --
::
++  peer-sole                                           ::>  new console
  |=  pax/path
  ^-  (quip move +>)
  ta-done:ta-peer-sole:ta
::
++  poke-sole-action                                    ::>  console event
  |=  act/sole-action
  ^-  (quip move +>)
  ta-done:(ta-sole-action:(taa /) act)
::
++  sigh-blockio-balance                                ::>  balance response
  |=  {wir/wire bal/(each balance error)}
  ^-  (quip move +>)
  ta-done:(ta-blockio-balance:(taa wir) bal)
::
++  sigh-blockio-withdraw                               ::>  balance response
  |=  {wir/wire wil/(each withdrawal error)}
  ^-  (quip move +>)
  ta-done:(ta-blockio-withdrawal:(taa wir) wil)
::
++  sigh-tang                                           ::>  error response
  |=  {wir/wire tan/tang}
  ^-  (quip move +>)
  %-  (slog >%blockio-sigh-tang< tan)
  [~ +>]
::
++  writ-plan                                           ::>  receive plan
  |=  {wir/wire rot/riot}
  ^-  (quip move +>)
  ?.  ?=({@ *} wir)  !!
  ta-done:(ta-writ-plan:(taa wir) t.wir rot)
::
++  made                                                ::>  data write result?
  |=  {wir/wire @ res/gage}
  ^-  (quip move +>)
  :_  +>
  ?+  -.res  ~|(gage+-.res !!)
    $|  (mean p.res)
    $&  =-  [ost.bol %info write+~ our.bol -]~
        (foal :(welp (tope beak-now ~) wir /[-.p.res]) p.res)
  ==
::
++  quit                                                ::>  killed by talk
  |=  wir/wire
  ta-done:ta-sub-talk:ta
::
++  wake                                                ::>  kicked by timer
  |=  {wir/wire $~}
  ^-  (quip move +>)
  ta-done:ta-wake:(taa wir)
::
++  diff-talk-report                                    ::>  accept talk report
  |=  {wir/wire rep/report:talk}
  ^-  (quip move +>)
  ?+  -.rep  !!
    $grams  ta-done:(ta-read-grams:(taa /) q.rep)
  ==
--
