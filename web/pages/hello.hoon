!:
^-  manx
;html
  ;head
    ;meta(charset "utf-8");
    ;meta
      =name     "viewport"
      =content  "width=device-width, initial-scale=1.0";
    ;title: Examples - Hello
    ;link
      =rel   "stylesheet"
      =type  "text/css"
      =href  "/~~/pages/hello/hello.css";
    ;script
      =type  "text/javascript"
      =src   "/~~/~/at/lib/js/urb.js";
  ==
  ;body
    ;h1#title: :hello
    ;div
      ;h1(id "helloWorld");
      ;button
        =id  "pokeButton"
        =onclick  "helloWorld();": Poke me!
    ==
    ;script
      =type  "text/javascript"
      =src   "/~~/pages/hello/hello.js";
  ==
==
