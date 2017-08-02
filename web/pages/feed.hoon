!:
^-  manx
;html
  ;head
    ;meta(charset "UTF-8");
    ;meta
      =name     "viewport"
      =content  "width=device-width, initial-scale=1.0";
    ;title: Examples - Feed
    ;script
      =type  "text/javascript"
      =src   "/~~/~/at/lib/js/urb.js";
    ;script
      =type  "text/javascript"
      =src   "/~~/pages/feed/feed.js";
    ;link
      =type  "text/css"
      =rel   "stylesheet"
      =href  "/~~/pages/feed/feed.css";
  ==
  ;body
    ;h1: :feed
    ;div(id "loading"): Loading...
    ;div(id "home");
    ;br;
    ;div
      ;input
        =id  "fetchBox"
        =type  "text"
        =placeholder  "~tonlur-sarret";
      ;br;
      ;button(onclick "fetch();"): Fetch
    ==
    ;br;
    ;div
      ;h1(id "shipDisplay", class "ship-display");
    ==
    ;br;
    ;div
      ;button
        =id       "subscribeButton"
        =class    "hidden"
        =onclick  "subscribe();": Subscribe
    ==
    ;br;
    ;div
      ;button
        =id       "unsubscribeButton"
        =class    "hidden"
        =onclick  "subscribe();": Unsubscribe
    ==
    ;br;
    ;div
      ;input
        =id  "postBox"
        =class  "hidden"
        =type  "text"
        =maxlength  "64"
        =placeholder  "Hello, world!";
      ;br;
      ;button
        =id  "postButton"
        =class  "hidden"
        =onclick  "fetch();": Post
    ==
    ;br;
    ;div(id "posts");
    ;script
      ; if (!(window.location.search)) {
      ;   document.getElementById('shipDisplay').innerHTML = '~' + window.urb.user;
      ; } else {
      ;   document.getElementById('home').innerHTML = '<button id="homeButton" onclick="home();">Home</button>';
      ;   document.getElementById('shipDisplay').innerHTML = '~' + window.location.search.substring(7);
      ; }

      ; document.getElementById('fetchBox').addEventListener('keyup', function fetchOnEnter(event) {
      ;   if (!event) { event = window.event; }
      ;   event.preventDefault();
      ;   if (event.keyCode === 13) { fetch(); }
      ; }, false);
      ; document.getElementById('postBox').addEventListener('keyup', function postOnEnter(event) {
      ;   if (!event) { event = window.event; }
      ;   event.preventDefault();
      ;   if (event.keyCode === 13) { sendPost(); }
      ; }, false);
      ; document.getElementById('loading').classList.remove('hidden');
    ==
  ==
==
