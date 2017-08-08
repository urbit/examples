:: Parser for Tumblr types
::
::
/-  tumblr
|%
::  get the response object out
++  user-info-r
  ^-  $-(json (unit user-info-r:tumblr))
  =+  jo
  %-  ot
  :_  ~
  'response'^user
::
::  parse the response object
++  user
  ^-  $-(json (unit user:tumblr))
  =+  jo
  %-  ot
  :_  ~
  'user'^user-info
::
++  user-info
  ^-  $-(json (unit user-info:tumblr))
  =+  jo
  %-  ot
  :~  'following'^ni
      'name'^so
      'default_post_format'^so
      'likes'^ni
      'blogs'^(ar blog)
  ==
++  blog
  ^-  $-(json (unit blog:tumblr))
  =+  jo
  %-  ot
  :~  'name'^so
      'title'^so
      'url'^so
      'tweet'^so
      'primary'^bo
      'followers'^ni
  ==
++  blog-posts-r
  ^-  $-(json (unit blog-posts-r:tumblr))
  =+  jo
  %-  ot
  :_  ~
  'response'^blog-posts
++  blog-posts
  ^-  $-(json (unit blog-posts:tumblr))
  =+  jo
  %-  ot
  :_  ~
  'posts'^(ar post)
++  post
  |=  jon/json
  ^-  (unit post:tumblr)
  =/  type  ((ot 'type'^so ~):jo jon)
  ~&  type
  ?~  type
    ~
  ?:  =(u.type 'photo')
    =/  a  (photo-post jon)
    ?~  a  ~
    `[%photo-post (need a)]
  ?:  =(u.type 'link')
    =/  b  (link-post jon)
    ?~  b  ~
    `[%link-post (need b)]
  ?:  =(u.type 'video')
    =/  d  (video-post jon)
    ?~  d  ~
    `[%video-post (need d)]
  ?:  =(u.type 'text')
    =/  e  (text-post jon)
    ?~  e  ~
    `[%text-post (need e)]
  =/  c  (def-post jon)
  ?~  c  ~
  `[%def-post (need c)]
  :: 
  ::?-  type
  ::  'photo'  (def-post jon)
  ::  'link'  (def-post jon)
  ::  'quote'  (def-post jon)
  ::  ::'video'  (def-post jon)
  ::  ::'text'  (def-post jon)
  ::==
++  photo
  ^-  $-(json (unit photo:tumblr))
  =+  jo
  %-  ot
  :~  'caption'^so
      'original_size'^photo-info
      'alt_sizes'^(ar photo-info)
  ==
++  quote-post
  |=  jon/json
  ^-  (unit post:tumblr)
  =/  out  %-  =<  
      %-  ot
      :~  'blog_name'^so
          'id'^ni
          'post_url'^so
          'type'^so
          'date'^so
          'timestamp'^ni
          'tags'^(ar so)
          'source_url'^so
          'source_title'^so
          'text'^so
          'source'^so
      ==
      jo
  jon
  ?~  out
    ~
  %=  out
    u  [%quote-post (need out)]
  ==
++  photo-info
  ^-  $-(json (unit {width/@u height/@u url/@t}))
  =+  jo
  %-  ot
  :~  'width'^ni
      'height'^ni
      'url'^so
  ==
++  player-info
  ^-  $-(json (unit {width/@u embed-code/@t}))
  =+  jo
  %-  ot
  :~  'width'^ni
      'embed_code'^so
  ==
++  photo-post
  ^-  $-(json (unit photo-post:tumblr))
  =+  jo
  %-  ot
  :~  'blog_name'^so
      'id'^ni
      'post_url'^so
      'type'^so
      'date'^so
      'timestamp'^ni
      'format'^so
      'tags'^(ar so)
      'caption'^so
      'photos'^(ar photo)
  ==
::
++  video-post
  ^-  $-(json (unit video-post:tumblr))
  =+  jo
  %-  ot
  :~  'blog_name'^so
      'id'^ni
      'post_url'^so
      'type'^so
      'date'^so
      'timestamp'^ni
      'format'^so
      'tags'^(ar so)
      'caption'^so
      'player'^(ar player-info)
  ==
++  link-post
  ^-  $-(json (unit link-post:tumblr))
  =+  jo
  %-  ot
  :~  'blog_name'^so
      'id'^ni
      'post_url'^so
      'type'^so
      'date'^so
      'timestamp'^ni
      'format'^so
      'tags'^(ar so)
      'title'^so
      'url'^so
      ::'link_author'^so
      ::'excerpt'^so
      ::'publisher'^so
      'photos'^(ar photo)
      ::'summary'^so
  ==
++  text-post
  ^-  $-(json (unit text-post:tumblr))
  =+  jo
  %-  ot
  :~  'blog_name'^so
      'id'^ni
      'post_url'^so
      'type'^so
      'date'^so
      'timestamp'^ni
      'format'^so
      'tags'^(ar so)
      'title'^so
      'body'^so
  ==
++  def-post
  ^-  $-(json (unit def-post:tumblr))
  =+  jo
  %-  ot
  :~  'blog_name'^so
      'id'^ni
      'post_url'^so
      'type'^so
      'date'^so
      'timestamp'^ni
      'format'^so
      'tags'^(ar so)
  ==
--
