!:
^-  manx
;html
  ;head
    ;meta(charset "UTF-8");
    ;meta
      =name     "viewport"
      =content  "width=device-width, initial-scale=1.0";
    ;title: Example - Lead
    ;link(type "text/css", rel "stylesheet", href "/~~/pages/lead/lead.css");
    ;script(type "text/javascript", src "https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js");
    ;script(type "text/javascript", src "/~~/~/at/lib/js/urb.js");
  ==
  ;body
    ;h1#title: :lead
    ;div#cont
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
