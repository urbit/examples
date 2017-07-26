!:
;html
  ;head
    ;link(type "text/css", rel "stylesheet", href "/~~/pages/lead/lead.css");
    ;script(type "text/javascript", src "//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js");
    ;script(type "text/javascript", src "/~~/~/at/lib/js/urb.js");
    ;title: Leaderboard Example - Urbit
  ==
  ;body
    ;div#cont
      ;h1#name: :lead
      ;input#add(type "text", placeholder "NAME");
      ;input#go(type "button", value "Add");
      ;div#err(class "disabled");
      ;ul#board
        ;li
          ;div(class "info")
            ;div(class "scor"):"Points"
            ;div(class "name"):"Name"
          ==
        ==
      ==
    ==
    ;script(type "text/javascript", src "/~~/pages/lead/lead.js");
  ==
==
