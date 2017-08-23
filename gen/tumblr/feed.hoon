::  Display tumblr feed
::
::::  /hoon/feed/tumblr/gen
  ::
/-    tumblr
!:
::::  
  ::
:-  %say
|=  $:  {now/@da eny/@uvJ bek/beak}
        {{who/@t $~} $~}
    ==
=/  pax  %+  welp 
           /(scot %p p.bek)/tumblr/(scot %da now) 
         ?:  =(who 'dashboard') 
           /user/dashboard/tumblr-blog-posts 
         /blog/[who]/posts/tumblr-blog-posts
:-  %tang
%+  turn  (flop .^((list post:tumblr) %gx pax))
|=  a/post:tumblr  ^-  tank
?-  -.a
  $photo-post  :+  %rose
                 [": " `~]
               :~  leaf+"PHOTO POST" 
                   leaf+"post url: {<(trip post-url.a)>}" 
                   leaf+"image url: {<(trip ->->+.photos.a)>}"
               ==
  $video-post  :+  %rose
                 [": " `~]
               :~  leaf+"VIDEO POST" 
                   leaf+"post url: {<(trip post-url.a)>}" 
                   leaf+"video caption: {<(trip caption.a)>}"
               ==
  $quote-post  :+  %rose
                 [": " `~]
               :~  leaf+"QUOTE POST" 
                   leaf+"post url: {<(trip post-url.a)>}" 
                   leaf+(trip text.a) 
                   leaf+(trip source.a)
               ==
  $link-post   :+  %rose
                 [": " `~]
               :~  leaf+"LINK POST" 
                   leaf+"post url: {<(trip post-url.a)>}" 
                   leaf+(trip title.a) 
                   leaf+(trip url.a)
               ==
  $text-post   :+  %rose
                 [": " `~]
               :~  leaf+"TEXT POST" 
                   leaf+"post url: {<(trip post-url.a)>}" 
                   leaf+(trip title.a) 
                   leaf+(trip body.a)
               ==
  $def-post    :+  %rose
                 [": " `~]
               :~  leaf+"DEFAULT POST" 
                   leaf+"post url: {<(trip post-url.a)>}"
               ==
==
