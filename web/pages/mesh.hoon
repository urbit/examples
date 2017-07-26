!:
^-  manx
;html
  ;head
    ;meta
      =charset  "UTF-8";
    ;meta
      =name     "viewport"
      =content  "width=device-width, initial-scale=1.0";
    ;title: Examples - Mesh
    ;script
      =type  "text/javascript"
      =src   "https://d3js.org/d3.v4.js";
    ;script
      =type  "text/javascript"
      =src   "/~~/~/at/lib/js/urb.js";
    ;link
      =type  "text/css"
      =rel   "stylesheet"
      =href  "/~~/pages/mesh/mesh.css";
  ==
  ;body
    ;h1: :mesh
    ;svg;
    ;div(class "inputs")
      ;input
        =id           "subscribeBox"
        =class        "subscribe"
        =type         "text"
        =maxlength    "57"
        =placeholder  "~tonlur-sarret";
      ;div(class "colors")
        ;input
          =class    "color"
          =type     "radio"
          =style    "background: #ee3124"
          =onclick  "selectColor('#ee3124');";
        ;input
          =class    "color"
          =type     "radio"
          =style    "background: #ffac6e"
          =onclick  "selectColor('#ffac6e');";
        ;input
          =class    "color"
          =type     "radio"
          =style    "background: #ffd522"
          =onclick  "selectColor('#ffd522');";
        ;input
          =class    "color"
          =type     "radio"
          =style    "background: #9ee574"
          =onclick  "selectColor('#9ee574');";
        ;input
          =class    "color"
          =type     "radio"
          =style    "background: #317bff"
          =onclick  "selectColor('#317bff');";
        ;input
          =class    "color"
          =type     "radio"
          =style    "background: #d27dff"
          =onclick  "selectColor('#d27dff');";
      ==
    ==
    ;script
      ; document.getElementById('subscribeBox').addEventListener(
      ;   'keyup',
      ;   function fetchOnEnter(event) {
      ;     if (!event) { event = window.event; }
      ;     event.preventDefault();
      ;     if (event.keyCode === 13) { subscribe(); }
      ;   }, false);
    ==
    ;script
    =type  "text/javascript"
    =src   "/~~/pages/mesh/mesh.js";
  ==
==
