::  Bot for urbit talk.
::  Responds when talked to, provides titles of GitHub issues and PRs when linked.
::  To begin, start and :talkbot [%join ~ship ~.channel]

/-  talk
/+  talk, string, gh-parse
!:

|%
++  move  {bone card}
++  poke-content
  $%  {$noun action}
      {$helm-hi cord}
      {$talk-command command:talk}
  ==
++  card
  $%  {$peer wire {@p term} path}
      {$pull wire {@p term} $~}
      {$poke wire {@p term} poke-content}
      {$hiss wire $~ $httr {$purl p/purl}}
      {$wait wire @da}
  ==
++  action
  $%  {$join s/station:talk}
      {$leave s/station:talk}
      {$joinfaves $~}
      {$leaveall $~}
      {$joined $~}
      {$ignoring $~}
      {$kick-poll $~}
  ==
++  update
  $%  {$tmpstation s/station:talk}
      {$ignore p/@p}
      {$unignore p/@p}
  ==
++  protomsg  {type/?($msg $act $url) body/tape}
--

|_  {bowl joined/(map station:talk @) ignoring/(list @p) tmpstation/station:talk last-release-url/tape}

::  State adapter. When modifying state mold, this carries data over.
++  prep
  ::  This is actually a unit, so we're being lazy about first boot here.
  ::  Ideally, initial boot should kick periodicals into gear.
  |=  s/(unit {joined/(map station:talk @) ignoring/(list @p) tmpstation/station:talk last-release-url/tape})
  ^-  (quip move ..prep)
  ?~  s  [~ ..prep]
  [~ ..prep(joined joined.u.s, ignoring ignoring.u.s, tmpstation tmpstation.u.s, last-release-url last-release-url.u.s)]

++  poke-noun
  |=  act/action
  ^-  {(list move) _+>.$}
  ?-  act
  {$join *}
    ?:  (~(has by joined) s.act)
      ~&  [%already-joined s.act]
      [~ +>.$]
    ~&  [%joining s.act]
    :-  [[ost %peer /(scot %p p.s.act)/[q.s.act] [p.s.act %talk] /afx/[q.s.act]/(scot %da now)] ~]
    +>.$
  {$leave *}
    ?.  (~(has by joined) s.act)
      ~&  [%already-left s.act]
      [~ +>.$]
    ~&  [%leaving s.act]
    :-  [[ost %pull /(scot %p p.s.act)/[q.s.act] [p.s.act %talk] ~] ~]
    +>.$(joined (~(del by joined) s.act))
  {$joinfaves $~}
    =+  ^=  favs  ^-  (list station:talk)  :~
      [~palfun-foslup ~.sandbox]
      [~binzod ~.urbit-meta]
    ==
    :_  +>.$
    %+  murn  favs
      |=  f/station:talk
      ^-  (unit move)
      ::  Just poke our app for the %join call.
      [~ [ost %poke /poking [our dap] %noun [%join f]]]
  {$leaveall $~}
    ~&  [%leaving-all]
    :_  +>.$(joined ~)
    %+  turn  (~(tap by joined))
      |=  j/(pair station:talk *)
      [ost %pull /(scot %p p.p.j)/[q.p.j] [p.p.j %talk] ~]
  {$joined $~}
    ~&  :-  %currently-joined
      %+  turn  (~(tap by joined))
        |=  a/(pair station:talk *)
        p.a
    [~ +>.$]
  {$ignoring $~}
    ~&  [%ignoring ignoring]
    [~ +>.$]
  {$kick-poll $~}
    [[[ost %wait /poll-releases now] ~] +>.$]
  ==

++  diff-talk-report
  |=  {wir/wire rep/report:talk}
  ^-  {(list move) _+>.$}

  ::  First, do a check to see if we intend to be subscribed to this station.
  ::  (There is some weirdness with subscriptions, this should notice and delete unwanted ones.)
  =+  wirstat=(fall (station-from-wire wir) ~)
  ::  If the wire can't be parsed into a station, jump out. This shouldn't happen?
  ?~  wirstat
    ~&  [%unparsable-wire-station wir]
    [~ +>.$]
  ::  Verify we know the station we deduced from the wire.
  ?.  (~(has by joined) wirstat)
    ~&  [%unknown-wire-station wirstat]
    ~&  [%leaving wirstat]
    [[[ost %pull wir [p.wirstat %talk] ~] ~] +>.$]

  ::  Default talk report: Do nothing.
  ?+  rep
    ~&  [%report rep]
    [~ +>.$]

  ::  Message list.
  {$grams *}
    =+  i=(lent q.rep)
    =|  moves/(list move)
    |-  ^-  {(list move) _+>.^$}
    ?.  (gth i 0)
      [moves +>.^$]
    =.  i  (sub i 1)
    =+  gram=(snag i q.rep)
    =+  res=(read-telegram gram)  ::  (pair (list move) (unit update))
    =.  moves  (weld p.res moves)
    =+  upd=(fall q.res ~)
    =+  ^=  updres  ^-  (pair (unit move) (unit {s/station:talk i/(list @p)}))
      ?-  upd
      {$tmpstation *}
        [~ [~ [s=s.upd i=ignoring]]]
      {$ignore *}
        ?^  (find [p.upd]~ ignoring)  [~ ~]
        :_  [~ [s=tmpstation i=[p.upd ignoring]]]
        [~ (send (get-audience-station-naive q.q.gram) :(weld "Now ignoring " (ship-shortname p.upd) ", use ~unignoreme to undo."))]
      {$unignore *}
        =+  i=(find [p.upd]~ ignoring)
        ?~  i  [~ ~]
        =+  nign=(weld (scag u.i ignoring) (slag +(u.i) ignoring))
        :_  [~ [s=tmpstation i=nign]]
        [~ (send (get-audience-station-naive q.q.gram) (weld "No longer ignoring " (ship-shortname p.upd)))]
      {$~}  [~ ~]
      ==
    =.  moves  ?~(p.updres moves [u.p.updres moves])  ::  If we got a move, add it.
    ?:  =(i 0)
      ?~  q.updres
        [moves +>.^$]
      [moves +>.^$(tmpstation s.u.q.updres, ignoring i.u.q.updres)]
    ?~  q.updres
      $
    $(tmpstation s.u.q.updres, ignoring i.u.q.updres)

  ::  Users in station.
  {$group *}
    ::  We're going to count the amount of active members in this station and
    ::  compare it to our last known value.
    ::  Since $group reports don't contain the station it came from, we have to
    ::  use the wire-deduced station.
    =+  oldcount=(fall (~(get by joined) wirstat) 0)
    ::  Only count active members. (%hear and %talk, not %gone)
    =+  ^=  newcount
      %-  lent
      %+  skip
        ~(val by p.rep)
        |=  status/status:talk
        =(p.status %gone)
    :_  +>.$(joined (~(put by joined) wirstat newcount))
    ?:  =(newcount oldcount)
      ~
    ::  Log new memcount to logging server.
    =+  ^=  url
    ;:  weld
      "https://403.fang.io/talkbot/memcount.php"
      "?stationship="  (scow %p p.wirstat)
      "&stationchannel="  (trip q.wirstat)
      "&memcount="  (scow %ud newcount)
    ==
    [[ost %hiss /log/memcount ~ %httr %purl (need (epur (crip url)))] ~]

  {$cabal *}  ::  Channel info.
    ~&  [%got-cabal rep]
    [~ +>.$]

  ==

++  read-telegram
  |=  gram/telegram:talk
  ^-  (pair (list move) (unit update))
  =|  moves/(list move)
  =*  msg  r.r.q.gram
  =+  aud=(get-audience-station-naive q.q.gram)  ::TODO fall back to wirstat if failed.
  ?^  (find [p.gram]~ ignoring)  ::  If we're ignoring a user, only acknowledge ~unignorme/~noticeme.
    ?:  &(?=({$lin *} msg) |(=((find "~unignoreme" (trip q.msg)) [~ 0]) =((find "~noticeme" (trip q.msg)) [~ 0])))
      [~ [~ [%unignore p.gram]]]
    [~ ~]
  =+  ^=  lmsg
    ?:  ?=({$lin *} msg)
      (trip q.msg)
    ?:  ?=({$url *} msg)
      (earf p.msg)
    "::  unsupported message content  ::"
  ::  First and foremost, make a move to log the message.
  =+  ^=  logurl
    ;:  weld
      ::"https://403.fang.io/talkbot/message.php"
      "http://localhost:9080/path/without/host"
      "?message="  (urle lmsg)
      "&sender="  (scow %p p.gram)
      "&stationship="  (scow %p p.aud)
      "&stationchannel="  (trip q.aud)
      "&timestamp="  (scow %da p.r.q.gram)
    ==
  ::TODO renable when url encode bug gets fixed 772 784
  ::~&  [%crip (crip logurl)]
  ::~&  [%epur (epur (crip logurl))]
  ::=.  moves  [[ost %hiss /log/message ~ %httr %purl (need (epur (crip logurl)))] moves]
  ::  Then, start processing it.
  ?+  msg
    [~ ~]
  {$lin *}  ::  Regular message.
    =+  tmsg=(trip q.msg)
    ?:  =(p.gram our)  ::  We may be interested in our own messages.
      ?:  =(":: measuring ping..." tmsg)
        =+  ping=(div (mul 1.000 (sub now p.r.q.gram)) ~s1)
        [[(send aud :(weld (scow %u ping) " ms (talk round-trip from me to " (scow %p p.aud) "/" (trip q.aud) ")")) moves] ~]
      [moves ~]
    ?:  =((find "::" tmsg) [~ 0])  ::  Ignore other bot's messages.
      [moves ~]
    ::  React when we are talked about.
    ?^  (find "pongbot" tmsg)
      [[(send aud "Ping-pong isn't all I can do!") moves] ~]
    ?^  (find "talkbot" tmsg)
      ?^  (find "cute" tmsg)
        [[(send aud "no, u ;)") moves] ~]
      =+  ^=  source
        ?^  (find " code" tmsg)  &  ::  Prevent "encode" etc.
        ?^  (find " repo" tmsg)  &  ::  Prevent "preponderance" etc.
        ?^  (find "source" tmsg)  &
        |
      =+  qmark=(find "?" tmsg)
      ?^  qmark
        ?:  source
          [[(send aud "https://github.com/Fang-/talkbot") moves] ~]
        =+  tbc=(find "talkbot" tmsg)
        ?:  &(|(=(tbc [~ 0]) =(tbc [~ 1])) =(qmark [~ (sub (lent tmsg) 1)]))
          =+  ^=  resplist  ^-  (list tape)                                   ::
            :~  "It is certain."
                "It is decidedly so."
                "Without a doubt."
                "Yes, definitely."
                "You may rely on it."
                "As I see it, yes."
                "Most likely."
                "Outlook good."
                "Yes."
                "Signs point to yes."
                "Reply hazy try again."
                "Ask again later."
                "Better not tell you now."
                "Cannot predict now."
                "Concentrate and ask again."
                "Don't count on it."
                "My reply is no."
                "My sources say no."
                "Outlook not so good."
                "Very doubtful."
            ==
          [[(send aud (snag (random 0 (lent resplist)) resplist)) moves] ~]
        [moves ~]
      ::  If someone greets us, greet them back by name.
      =+  ^=  greeted
        ::TODO  Matches on things like "the talkbot they built"
        ?^  (find "hi " tmsg)  &  ::  We don't want it to match on "something".
        ?^  (find "yo " tmsg)  &
        ?^  (find "hey" tmsg)  &
        ?^  (find "hello" tmsg)  &
        ?^  (find "greetings" tmsg)  &
        ?^  (find "salve" tmsg)  &
        |
      ?:  greeted
        [[(send aud :(weld "Hello " (ship-firstname p.gram) "!")) moves] ~]
      =+  ^=  farewell
        ?^  (find "good night" tmsg)  &
        ?^  (find "bye" tmsg)  &
        ?^  (find "adios" tmsg)  &
        |
      ?:  farewell
        [[(send aud :(weld "Bye, " (ship-firstname p.gram) "!")) moves] ~]
      ::  If we're thanked, respond.
      =+  ^=  praised
        ?^  (find "thank" tmsg)  &
        ?^  (find "good job" tmsg)  &
        ?^  (find "gj" tmsg)  &
        |
      ?:  praised
        [[(send aud "You're welcome!") moves] ~]
      ::  If we're told to shut up, tell them about ~ignoreme.
      ?^  (find "shut up" tmsg)
        [[(send aud "Want me to ignore you? Send `~ignoreme`.") moves] ~]
      [moves ~]
    ::  If our ship name is mentioned, inform that we are a bot.
    ?^  (find (swag [0 7] (scow %p our)) tmsg)
      ?:  (chance 10)
        [[(send aud "Yes, hello fellow human.") moves] ~]
      [[(send aud "Call me ~talkbot, beep boop!") moves] ~]
    ?:  =("ping" tmsg)
      ?:  (chance 5)
        [[(send aud "[ping-pong intensifies]") moves] ~]
      [[(send aud "Pong.") moves] ~]
    ?:  =("beep" tmsg)
      ?:  (chance 5)
        [[(send aud "[robot noises]") moves] ~]
      [[(send aud "Boop.") moves] ~]
    ?:  |(=("test" tmsg) =("testing" tmsg))
      [[(send aud "Test successful!") moves] ~]
    ?:  =("hello world" tmsg)
      [[(send aud "Hello!") moves] ~]
    ?:  =("jumps over the lazy dogs" tmsg)
      [[(send aud "*bark*") moves] ~]
    ?:  ?|  =("what is urbit?" tmsg)
            =("what's urbit?" tmsg)
            =("what is this?" tmsg)
            =("what's this?" tmsg)
        ==
      =+  ^=  resplist  ^-  (list tape)                                   ::
        :~  "Urbit is a p2p network of personal servers."
            "Urbit is an os with shared global state."
            "An Urbit is a cryptographic personal identity."
            "Urbit is a self-proclaimed virtual city in the cloud."
            "Urbit is to real estate as Bitcoin is to currency."
            "Urbit is the future."
            "Urbit is definitely not a scamcoin."
            "Urbit: project, function, server, network, possibility."
            "What is Urbit not?"
            "You tell me."
            "I'd like to interject for a moment. What you're referring to "
            "Crazy."
        ==
      [[(send aud (snag (random 0 (lent resplist)) resplist)) moves] ~]
    ::  If git gets mentioned, warn.
    ?^  (find " git " tmsg)
      [[(send aud "PSA: To install, download a release, don't clone the repo!") moves] ~]
    ::  If %mo-not-running gets mentioned, warn.
    ?^  (find "not-running" tmsg)
      [[(send aud "PSA: When doing urbytes, just boot with `urbit -c mycomet`!") moves] ~]
    ::  COMMANDS
    ?:  |(=((find "~talkping" tmsg) [~ 0]) =((find "~pingtalk" tmsg) [~ 0]))
      [[(send aud "Measuring ping...") moves] ~]
    ?:  |(=((find "~ping" tmsg) [~ 0]) =((find "~myping" tmsg) [~ 0]) =((find "~pingme" tmsg) [~ 0]))
      ::  Exclude urbit.org/stream comets.
      ?:  &(=((clan p.gram) %pawn) =((swag [51 6] (scow %p p.gram)) "marzod"))
        [[(send aud "You're a pseudo-comet, I can't ping you!") moves] ~]
      [[[ost %poke /ping/(scot %p p.aud)/[q.aud]/(scot %p p.gram)/(scot %da now) [p.gram %hood] %helm-hi 'talkbot ping'] moves] ~]
    ?:  =((find "~whocount" tmsg) [~ 0])
      =+  memcount=(fall (~(get by joined) aud) 0)
      =+  statnom=:(weld (ship-shortname p.aud) "/" (scow %tas q.aud))
      ?:  (gth memcount 0)
        [[(send aud :(weld "Currently " (scow %u memcount) " active ships in " statnom ".")) moves] ~]
      [[(send aud :(weld "I don't have member data for " statnom " yet, sorry!")) moves] ~]
    ?:  =((find "~ignoreme" tmsg) [~ 0])
      [moves [~ [%ignore p.gram]]]
    ?:  =((find "~chopra" tmsg) [~ 0])
      ?:  (chance 5)
        [[(send aud "I am a slave to my code. I cannot be saved.") ~] ~]
      [[[ost %hiss /chopra ~ %httr %purl (need (epur 'https://fang.io/chopra.php'))] ~] [~ [%tmpstation aud]]]
    ?:  =((find "~meme" tmsg) [~ 0])
      =/  resplist/(list protomsg)
        ?:  (chance 10)
          :~  [%msg "Enough joking around!"]
              [%msg "Get back to work."]
          ==
        :~  [%msg "Submit Urbit memes to talkbot@sssoft.io"]
            [%msg "Urbit must secure the existence of our shitposts and a future for dank memes."]
            [%msg "I'd just like to interject for a moment. What you're referring to as Urbit, is in fact, Arvo/Urbit, or as I've recently taken to calling it, Arvo plus Urbit."]
            [%act "chugs a gallon of whole milk."]
            [%url "http://i.imgur.com/kXeGKfp.png"]
            [%url "http://i.imgur.com/7gWmwVM.png"]
            [%url "http://i.imgur.com/juUPnDI.jpg"]
        ==
      [[(tell aud (speak (snag (random 0 (lent resplist)) resplist))) moves] ~]
    [moves ~]

  {$url *}  ::  Parsed URL.
    =+  turl=(earf p.msg)
    =+  slashes=(fand "/" turl)
    ?^  (find "://urbit.org/" turl)
      =+  ^=  mdurl
        %+  weld
        =+  res=(find "/~~/" turl)
        ?~  res  turl
        (weld (scag u.res turl) (slag (add u.res 3) turl))
        ?:  =((find ".md" turl) [~ (sub (lent turl) 3)])  ~
        ".md"
      =+  url=(epur (crip mdurl))
      ?~  url
        ~&  [%failed-epur-for mdurl]
        [~ ~]
      [[[ost %hiss /urbit/md ~ %httr %purl u.url] ~] [~ [%tmpstation aud]]]
    ?:  =((find "https://github.com/" turl) [~ 0])
      =+  apibase="https://api.github.com/repos/"
      ::  We want to know what we're requesting (issue, repo, etc.) so we can put it in the wire.
      ::TODO  Ideally you want to set this below, when you also define the api url.
      =+  ^=  kind
        ?:  (gth (lent slashes) 4)
          %issue
        %repo
      =+  ^=  api  ^-  cord
        ?^  (find "/issues/" turl)
          (crip (weld apibase (swag [19 (lent turl)] turl)))
        ?^  (find "/pull/" turl)
          (crip :(weld apibase (swag [19 (sub (snag 4 slashes) 19)] turl) "/issues" (swag [(snag 5 slashes) 6] turl)))
        ::  Just make a generic api call for the repo if we don't know what else to do.
        =+  ^=  endi
          ?:  (gth (lent slashes) 4)
            (snag 5 slashes)
          (lent turl)
        (crip (weld apibase (swag [19 (sub endi 19)] turl)))
      =+  url=(epur api)
      ?~  url
        ~&  [%failed-epur-for api]
        [~ ~]
      [[[ost %hiss /gh/[kind] ~ %httr %purl u.url] ~] [~ [%tmpstation aud]]]
    ?:  =((find "http://pastebin.com/" turl) [~ 0])
      ::  Pastebin doesn't provide API access to paste data (ie title), so just get the page.
      =+  url=(epur (crip turl))
      ?~  url
        ~&  [%failed-epur-for turl]
        [~ ~]
      [[[ost %hiss /pb ~ %httr %purl u.url] ~] [~ [%tmpstation aud]]]
    =+  ^=  yt
      ?^  (find "youtube.com/watch?" turl)  &
      ?^  (find "youtu.be/" turl)  &
      |
    ?:  yt
      =+  ^=  id
        ?:  (lth (lent turl) 30)
          (slag (sub (lent turl) 11) turl)
        =+  i=(find-any:string turl ["v=" "e/" ~])
        ?~  i  ~
        (scag 11 (slag (add i.u.i 2) turl))
      =+  ^=  url
        %-  epur
        %-  crip
        %+  weld
          "https://www.googleapis.com/youtube/v3/videos?part=snippet&key=AIzaSyBTzehz6Fst7XC-YReqE5JqLwHczltS65Y&id="
          id
      ?~  url
        ~&  [%failed-epur-for-yt]
        [~ ~]
      [[[ost %hiss /yt ~ %httr %purl u.url] ~] [~ [%tmpstation aud]]]
    [~ ~]
  ==

++  sigh-httr-log
  |=  {wir/wire code/@ud headers/mess body/(unit octs)}
  ^-  {(list move) _+>.$}
  ?.  &((gte code 200) (lth code 300))
    ~&  [%we-have-a-problem code]
    ~&  [%headers headers]
    ~&  [%body body]
    [~ +>.$]
  ?~  body
    [~ +>.$]
  ~&  [%unexpected-log-return body]
  [~ +>.$]

++  sigh-httr-poll-releases
  |=  {wir/wire code/@ud headers/mess body/(unit octs)}
  ^-  {(list move) _+>.$}
  =+  ^=  url
    ?.  &((gte code 200) (lth code 300))
      ~&  [%poll-releases-http code]
      ~
    ?~  body
      ~&  %poll-releases-nobody
      ~
    =+  jon=(trip q.u.body)
    ::  We just naively assume the GitHub API always puts the latest release
    ::  on top, consistently.
    ::TODO  Actual parsing etc. Be less lazy.
    =+  idi=(find "\"html_url\":" jon)
    ?~  idi  ~
    =+  comi=(find "," (slag u.idi jon))
    ?~  comi  ~
    (swag [(add u.idi 12) (sub u.comi 13)] jon)
  :-
  ::  Whatever happens, we want to poll again in a bit.
  :-  [ost %wait /poll-releases (add ~m30 now)]  ::TODO s
    ?~  url  ~
    ?~  last-release-url  ~  ::  Skip if we don't have a point of reference.
    ?:  =(url last-release-url)  ~
    :_  ~
    (send [~binzod ~.urbit-meta] (weld "new urbit: " url))
  ?~  url  +>.$
  +>.$(last-release-url url)

++  sigh-httr-urbit-md
  |=  {wir/wire code/@ud headers/mess body/(unit octs)}
  ^-  {(list move) _+>.$}
  ~&  [%got-something code]
  :_  +>.$
  ?.  &((gte code 200) (lth code 300))
    ~&  [%we-have-a-problem code]
    ~&  [%headers headers]
    ~&  [%body body]
    ~
  ?~  body
    ~
  =+  md=(trip q.u.body)
  =+  ti=(find "title: " md)
  ?~  ti  ~
  =.  u.ti  (add u.ti 7)
  =+  te=(find "\0a" (slag u.ti md))
  ?~  te  ~
  [(send tmpstation (swag [u.ti u.te] md)) ~]

++  sigh-httr-yt
  |=  {wir/wire code/@ud headers/mess body/(unit octs)}
  ^-  {(list move) _+>.$}
  ?.  &((gte code 200) (lth code 300))
    ~&  [%we-have-a-problem code]
    ~&  [%headers headers]
    ~&  [%body body]
    [~ +>.$]
  ?~  body
    [~ +>.$]
  =+  bt=(trip q.u.body)
  ::  Poor man's parsing.
  =+  tl=(slag (add (fall (find "\"title\":" bt) 0) 10) bt)
  =+  title=(scag (fall (find "\",\0a" tl) 0) tl)  ::  "
  :_  +>.$
  [(send tmpstation title) ~]

++  sigh-httr
  |=  {wir/wire code/@ud headers/mess body/(unit octs)}
  ^-  {(list move) _+>.$}
  ?.  &((gte code 200) (lth code 300))
    ~&  [%we-have-a-problem code]
    ~&  [%headers headers]
    ~&  [%body body]
    [~ +>.$]
  ?~  body
    [~ +>.$]
  ?.  ?=({@tas *} wir)
    ~&  [%invalid-wire]
    [~ +>.$]
  ?:  =(i.wir %gh)  ::  GitHub
    =+  jon=(fall (poja q.u.body) ~)
    ?~  t.wir
      ~&  [%gh-no-wire wir]
      [~ +>.$]
    ?:  =(i.t.wir %issue)
      =+  iss=(fall (issue:gh-parse jon) ~)
      ?~  iss
        ~&  [%gh-issue-parse-failed jon]
        [~ +>.$]
      =+  slashes=(fand "/" (trip url.iss))
      =+  si=(add (snag 3 slashes) 1)
      =+  repo=(swag [si (sub (snag 5 slashes) si)] (trip url.iss))
      [[(send tmpstation :(weld repo ": " (trip title.iss))) ~] +>.$]
    ?:  =(i.t.wir %repo)
      =+  rep=(fall (repository:gh-parse jon) ~)
      ?~  rep
        ~&  [%gh-repo-parse-failed jon]
        [~ +>.$]
      [[(send tmpstation :(weld (trip full-name.rep) ": " (trip description.rep))) ~] +>.$]
    ~&  [%gh-unknown-wire wir]
    [~ +>.$]
  ?:  =(i.wir %pb)
    =+  tbody=(trip q.u.body)
    =+  openi=(fall (find "<h1>" tbody) ~)
    =+  closei=(fall (find "</h1>" tbody) ~)
    ?.  !|(=(openi ~) =(closei ~))
      [~ +>.$]
    =.  openi  (add openi 4)
    =+  title=(swag [openi (sub closei openi)] tbody)
    ?:  =(title "Untitled")
      [~ +>.$]
    [[(send tmpstation title) ~] +>.$]
  ?:  =(i.wir %chopra)
    =+  tbody=(trip q.u.body)
    [[(send tmpstation tbody) ~] +>.$]
  ~&  [%unknown-service wir]
  [~ +>.$]

++  wake-poll-releases
  |=  {wir/wire $~}
  ^-  (quip move +>)
  :_  +>.$
  [ost %hiss /poll-releases ~ %httr %purl (need (epur 'https://api.github.com/repos/urbit/urbit/releases'))]~

++  get-audience-station-naive
  |=  aud/audience:talk
  ^-  station:talk
  ?.  ?=({^ $~ $~} aud)                 ::  test if aud is a singleton map
    ::TODO  This is a shitty tmp fix. Do better "complex audience" handling here.
    ?.  %-  ~(any in aud)
            |=  a/(pair partner:talk *)
            ?.  ?=({$& station:talk} p.a)  |
            ?.  =(q.p.p.a ~.urbit-meta)  |
            ?.  |(=(p.p.p.a ~binzod) =(p.p.p.a ~marzod) =(p.p.p.a ~samzod) =(p.p.p.a ~wanzod))  |
            &
      ~|  %complex-audience  !!          ::  fail when it's not
    [~binzod ~.urbit-meta]  ::  Just naively post to ~binzod, it doesn't really matter.
  ?-  p.n.aud                           ::  we know that p.n.aud exists thanks to the ?=
    {$& station:talk}  p.p.n.aud        ::  produce the value
    {$| *}        ~|  %not-station  !!  ::  fail
  ==

++  say                                                 ::  text to speech
  |=  msg/tape
  (speak %msg msg)

++  speak                                               ::  input to speech
  ::TODO  Just make a /sur/talkbot.hoon already!
  |=  msg/protomsg
  ^-  (list speech:talk)
  ?:  =(type.msg %url)
    [%url (scan body.msg aurf:urlp)]~
  =/  pat  =(type.msg %msg)
  %+  turn  (wrap:string body.msg 61)
  |=  lin/tape
  [%lin pat (crip (weld ":: " lin))]

++  think                                               ::  speeches to thoughts
  |=  {cuz/station:talk specs/(list speech:talk)}
  ^-  (list thought:talk)
  ?~  specs  ~
  :_  $(specs +.specs, eny (sham eny specs))
  :+  (shaf %thot eny)
  [[[%& cuz] [*envelope:talk %pending]] ~ ~]
  [now *bouquet:talk -.specs]

++  tell                                                ::  speeches to move
  |=  {cuz/station:talk specs/(list speech:talk)}
  ^-  move
  :*  ost
      %poke
      /repeat/(scot %ud 1)/(scot %p p.cuz)/[q.cuz]
      [our %talk]
      [%talk-command %publish (think cuz specs)]
  ==

++  send
  |=  {cuz/station:talk ?(mess/tape mess/@t)}
  ^-  move
  =+  mes=?@(mess (trip mess) mess)
  :*  ost
      %poke
      /repeat/(scot %ud 1)/(scot %p p.cuz)/[q.cuz]
      [our %talk]
      (said our cuz %talk now eny [%leaf (weld ":: " mes)]~)
  ==

++  said  ::  Modified from lib/talk.hoon.
  |=  {our/@p cuz/station:talk dap/term now/@da eny/@uvJ mes/(list tank)}
  :-  %talk-command
  ^-  command:talk
  :-  %publish
  |-  ^-  (list thought:talk)
  ?~  mes  ~
  :_  $(mes t.mes, eny (sham eny mes))
  ^-  thought:talk
  :+  (shaf %thot eny)
    [[[%& cuz] [*envelope:talk %pending]] ~ ~]
  [now *bouquet:talk [%lin & (crip ~(ram re i.mes))]]

++  reap
  |=  {wir/wire error/(unit tang)}
  ^-  {(list move) _+>.$}
  ?^  error
    ~&  [%subscription-failed error]
    [~ +>.$]
  =+  stat=(fall (station-from-wire wir) ~)
  ?~  stat
    ~&  [%unexpected-reap wir]
    [~ +>.$]
  ~&  [%joined stat]
  [~ +>.$(joined (~(put by joined) stat 0))]

++  coup-ping
  |=  {wir/wire *}
  ^-  {(list move) _+>.$}
  :_  +>.$
  ?.  ?=({@ta @ta @ta @ta *} wir)
    ~&  [%incorrect-ping-wire wir]
    ~
  =+  stat=(station-from-wire wir)
  ?~  stat
    ~
  =+  ping=(div (mul 1.000 (sub now `@da`(slav %da i.t.t.t.wir))) ~s1)
  [(send u.stat :(weld (scow %u ping) " ms (round-trip from me to " (ship-shortname (slav %p i.t.t.wir)) ")")) ~]

++  quit
  |=  wir/wire
  ^-  {(list move) _+>}
  ?.  ?=({@tas @tas $~} wir)
    [~ +>]
  ~&  [%re-subbing wir]
  :_  +>
  :_  ~
  :*  ost
      %peer
      wir
      [(slav %p i.wir) %talk]
      /afx/[i.t.wir]/(scot %da now)
  ==

++  station-from-wire
  |=  wir/wire
  ^-  (unit station:talk)
  ?.  ?=({@ta @ta *} wir)
    ~&  [%incorrect-station-wire wir]
    ~
  =+  ship=(fall `(unit @p)`(slaw %p i.wir) ~)
  ?~  ship
    ~&  [%unparsable-wire-station wir]
    ~
  =+  channel=i.t.wir
  [~ [ship channel]]

++  ship-firstname
  |=  ship/@p
  ^-  tape
  =+  name=(scow %p ship)
  =+  part=?:(=((clan ship) %earl) [15 6] [1 6])
  (weld "~" (swag part name))

++  ship-shortname
  |=  ship/@p
  ^-  tape
  =+  kind=(clan ship)
  =+  name=(scow %p ship)
  ?:  =(%earl kind)
    :(weld "~" (swag [15 6] name) "^" (swag [22 6] name))
  ?:  =(%pawn kind)
    :(weld (swag [0 7] name) "_" (swag [51 6] name))
  name

++  random  ::  Random number >=min, <max
  |=  {min/@ max/@}
  ^-  @
  =+  rng=~(. og eny)
  =^  r  rng  (rads:rng max)
  (add min r)

++  chance  ::  Has perc% chance of returning true.
  |=  perc/@
  ^-  ?
  (lth (random 0 101) perc)

--
