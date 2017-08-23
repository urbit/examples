::  This is a connector for the Tumblr API v2
::  
::  To see the information for the authenticated user
::  .^(user-info:tumblr %gx /=tumblr=/user/info/tumblr-user-info)
::  To see posts for a blog
::  .^((list post:tumblr) %gx /=tumblr=/blog/<identifier>/posts/tumblr-blog-posts)
::  To see posts for a blog starting at an offset
::  .^((list post:tumblr) %gx /=tumblr=/blog/<identifier>/posts/<offset num>/tumblr-blog-posts)
::  You can also use the generator to see your dashboard or a blog
::  +tumblr/feed <identifier|'dashboard'>
::
::
/?  314
/-  tumblr
/+  tumblr-parse, connector
::
!:
=>  |%
    ++  move  (pair bone card)
    ++  card  
      $%  {$diff sub-result}                            :: to update subscribers
          {$hiss wire {$~ $~} $httr {$hiss hiss}}       :: send an http request
      ==
    ::
    ::  Types of results we produce to subscribers.
    ::
    ++  sub-result
      $%  {$arch arch}                                  :: lists depth structure
          {$json json}                                  :: lets you send back just json
          {$tumblr-user-info user-info:tumblr}          :: info about authenticated user
          {$tumblr-blog-posts (list post:tumblr)}       :: return list of posts
          {$null $~}                                    :: nada
      ==
    --
=+  connector=(connector move sub-result)  ::  Set up connector library
::
|_  $:  hid/bowl                                        ::  contains data about this urbit
        hook/(map @t {id/@t listeners/(set bone)})      ::  map events to listeners for web hook usage
    ==
    ++  prep  _`.                                       ::  clear state when code changes
::
::  list of paths that the connector handles
::
++  places
  |=  wir/wire
  ^-  (list place:connector)
  =+  %^    helpers:connector                           :: set up connector lib
          ost.hid                                       :: the bone from this urbit
        wir                                             :: wire to keep track of where this request came from
      "https://api.tumblr.com/v2"                       :: api endpoint
  =>  |%
      ++  get-w-offset                                  :: request with params
        |=  {id/@t of/@t}
        ^-  move
        :*  ost  %hiss  wir  `~  %httr  %hiss
            %-  need
            ((cork crip epur) "https://api.tumblr.com/v2/blog/{(trip id)}/posts?offset={(trip of)}")  
            %get  ~  ~
        ==
      ++  read-json                                     :: if you just want to return json
        |=  jon/json  ^-  (unit sub-result)
        `json+jon                                       :: handle response from user info
      ++  read-user-info
        |=  jon/json  ^-  (unit sub-result)
        `tumblr-user-info+(need (user-info-r:tumblr-parse jon))
      ++  read-blog-posts                               :: handle response for posts
        |=  jon/json  ^-  (unit sub-result)
        `tumblr-blog-posts+(need (blog-posts-r:tumblr-parse jon))
      --
  :~  ^-  place                                         ::  /user
      :*  guard={$user $~}
          read-x=read-null
          read-y=(read-static %info %dashboard ~)
          sigh-x=sigh-strange
          sigh-y=sigh-strange
      ==
      ^-  place                                         ::  /user/info
      :*  guard={$user $info $~}
          read-x=(read-get /user/info)
          read-y=read-null
          sigh-x=read-user-info
          sigh-y=sigh-strange
      ==
      ^-  place                                         ::  /user/dashboard
      :*  guard={$user $dashboard $~}
          read-x=(read-get /user/dashboard)
          read-y=read-null
          sigh-x=read-blog-posts
          sigh-y=sigh-strange
      ==
      ^-  place                                         ::  /blog/<ident>/posts
      :*  guard={$blog @t $posts $~}
          read-x=|=(a/path (get /blog/[+<.a]/posts))
          read-y=read-null
          sigh-x=read-blog-posts
          sigh-y=sigh-strange
      ==
      ^-  place                                         ::  /blog/<ident>/posts/<offset>
      :*  guard={$blog @t $posts @u $~}
          ::read-x=|=(a/path (get-w-offset +<.a +>+.a))
          read-x=|=(a/path (get-w-offset +<.a +>+<.a))
          read-y=read-null
          sigh-x=read-blog-posts
          sigh-y=sigh-strange
      ==
  ==
::
::  When a peek on a path blocks, ford turns it into a peer on
::  /scry/{care}/{path}.  You can also just peer to this
::  directly.
::
::  We hand control to ++scry.
::
++  peer-scry
  |=  pax/path
  ^-  {(list move) _+>.$}
  ?>  ?=({care *} pax)
  :_  +>.$  :_  ~
  (read:connector ost.hid (places %read pax) i.pax t.pax)
::
::  HTTP response.  We make sure the response is good, then
::  produce the result (as JSON) to whoever sent the request.
::
::  From namespace
::  Respond to only this urbit
++  from-ns
  |=  {w/wire r/httr}
  ^-  (list move)
  ?.  ?=({$read care @ *} w)
    ~[[ost.hid %diff %null ~]]
  =*  style  i.w
  =*  ren  i.t.w
  =*  pax  t.t.w
  :_  ~
  :+  ost.hid  %diff
  (sigh:connector (places ren style pax) ren pax r)
::  From web-poke
::  Notify all subscribers (needed for web apps)
++  from-app
  |=  {w/wire r/httr}
  ^-  (list move)
  ?.  ?=({$poke $read care @ *} w)
    ~[[ost.hid %diff %null ~]]
  =*  style  i.t.w
  =*  ren  i.t.t.w
  =*  pax  t.t.t.w
  =/  subr/sub-result
  (sigh:connector (places ren style pax) ren pax r)
  %+  turn  
    (prey /path hid)
  |=  {o/bone *}
  :+  o
    %diff
  subr
::
++  sigh-httr
  |=  {way/wire res/httr}
  ^-  {(list move) _+>.$}
  ?:  ?=({$read *} way)
    :_  +>.$ 
    (from-ns way res)
  :_  +>.$ 
  (from-app way res)
::
::  HTTP error.  We just print it out, though maybe we should
::  also produce a result so that the request doesn't hang?
::
++  sigh-tang
  |=  {way/wire tan/tang}
  ^-  {(list move) _+>.$}
  %-  (slog >%gh-sigh-tang< tan)
  [[ost.hid %diff null+~]~ +>.$]
::
++  poke-tumblr-get-posts
  |=  {iden/@t idst/@u}
  ^-  (quip move +>.$)
  =/  pax/path  ?:(=(iden %dashboard) /x/user/dashboard /x/blog/[iden]/posts/(scot %u idst))
  ?>  ?=({care *} pax)
  :_  +>.$  :_  ~
  (read:connector ost.hid (places (welp /poke/read pax)) i.pax t.pax)
:: 
::  We can't actually give the response to pretty much anything
::  without blocking, so we just block unconditionally.
::
++  peer
  |=  pax/path
  :_  +>.$
  %+  turn  
    (prey pax hid)
  |=  {o/bone *}
  :^    o
      %diff
    %json
  (joba connect+(jape "success"))
++  peek
  |=  tyl/path
  ^-  (unit (unit (pair mark *)))
  ~ ::``noun/[ren tyl]
--
