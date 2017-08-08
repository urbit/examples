::
::  /hoon/blog-post/tumblr/mar
::
::
/?    310
/-  tumblr
/+  tumblr-parse
!:
|_  bp/post:tumblr
++  grab
  |%
  ++  json
    |=  jon/^json
    ^-  post:tumblr
    %-  need
    (post:tumblr-parse jon)
  ++  noun  post:tumblr
  --
++  grow
  |%
  ++  joto
    |=  a/photo:tumblr
    %-  jobe
    =*  osa  original-size.a
    =*  asa  alt-sizes.a
    :~  caption+(jrip caption.a)
        :-  %original-size
        %-  jobe 
        :~  width+(jone width.osa) 
            height+(jone height.osa) 
            url+(jrip url.osa)
        ==
        :-  %alt-sizes 
        :-  %a  
        %+  turn 
          asa 
        |=  b/photo-size:tumblr 
        %-  jobe 
        :~  width+(jone width.b) 
            height+(jone height.b) 
            url+(jrip url.b)
        ==
    ==
  ++  jrip
    |=  a/@t
    (jape (trip a))
  ++  jlay
    |=  a/{width/@u embed-code/@t}
    (jobe width+(jone width.a) embed-code+(jrip embed-code.a) ~)
  ++  json
    ?-  -.bp
      $photo-post  %-  jobe
                   :~  blog-name+(jrip blog-name.bp)
                       id+(jone id.bp)
                       post-url+(jrip post-url.bp)
                       type+(jrip type.bp)
                       date+(jrip date.bp)
                       timestamp+(jone timestamp.bp)
                       format+(jrip format.bp)
                       caption+(jrip caption.bp)
                       :-  %tags 
                       a+(turn tags.bp |=(a/@t (jrip a)))
                       :-  %photos 
                       a+(turn photos.bp joto)
                   ==
      $video-post  %-  jobe
                   :~  blog-name+(jrip blog-name.bp)
                       id+(jone id.bp)
                       post-url+(jrip post-url.bp)
                       type+(jrip type.bp)
                       date+(jrip date.bp)
                       timestamp+(jone timestamp.bp)
                       format+(jrip format.bp)
                       caption+(jrip caption.bp)
                       :-  %tags 
                       a+(turn tags.bp |=(a/@t (jrip a)))
                       :-  %player
                       a+(turn player.bp jlay)
                   ==
      $quote-post  %-  jobe
                   :~  blog-name+(jrip blog-name.bp)
                       id+(jone id.bp)
                       post-url+(jrip post-url.bp)
                       type+(jrip type.bp)
                       date+(jrip date.bp)
                       timestamp+(jone timestamp.bp)
                       source-url+(jrip source-url.bp)
                       source-title+(jrip source-title.bp)
                       text+(jrip text.bp)
                       source+(jrip source.bp)
                       :-  %tags 
                       a+(turn tags.bp |=(a/@t (jrip a)))
                   ==
      $text-post   %-  jobe
                   :~  blog-name+(jrip blog-name.bp)
                       id+(jone id.bp)
                       post-url+(jrip post-url.bp)
                       type+(jrip type.bp)
                       date+(jrip date.bp)
                       timestamp+(jone timestamp.bp)
                       format+(jrip format.bp)
                       title+(jrip title.bp)
                       body+(jrip body.bp)
                       :-  %tags 
                       a+(turn tags.bp |=(a/@t (jrip a)))
                   ==
      $link-post   %-  jobe
                   :~  blog-name+(jrip blog-name.bp)
                       id+(jone id.bp)
                       post-url+(jrip post-url.bp)
                       type+(jrip type.bp)
                       date+(jrip date.bp)
                       timestamp+(jone timestamp.bp)
                       format+(jrip format.bp)
                       title+(jrip title.bp)
                       url+(jrip url.bp)
                       :-  %photos 
                       a+(turn photos.bp joto)
                       :-  %tags 
                       a+(turn tags.bp |=(a/@t (jrip a)))
                   ==
      $def-post   %-  jobe
                   :~  blog-name+(jrip blog-name.bp)
                       id+(jone id.bp)
                       post-url+(jrip post-url.bp)
                       type+(jrip type.bp)
                       date+(jrip date.bp)
                       timestamp+(jone timestamp.bp)
                       format+(jrip format.bp)
                       :-  %tags 
                       a+(turn tags.bp |=(a/@t (jrip a)))
                   ==
    ==
  --
--
