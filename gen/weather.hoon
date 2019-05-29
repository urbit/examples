::  Fetch the current weather from the Open Weather Map API
::
::  Sign up for an API key here: https://home.openweathermap.org/users/sign_up
::  Then run in the dojo with your city, country and API key:
::
::    +weather "san+jose" "us" "YOUR_API_KEY_HERE"
::
/-  sole
/+  generators
=,  generators
:-  %get
|=  [* [city=tape country=tape appid=tape ~] ~]
^-  (sole-request:sole (cask tang))
=/  escaped-city  (en-urlt:html city)
=/  escaped-country  (en-urlt:html country)
%+  curl  (scan "http://api.openweathermap.org/data/2.5/weather?q={escaped-city}%2C{escaped-country}&APPID={appid}" auri:de-purl:html)
|=  hit=httr:eyre
?~  r.hit  !!
=/  my-json  (need (de-json:html q.u.r.hit))
=,  dejs:format
=/  my-map  ((om same) my-json)
=/  name  ((ot 'name'^sa ~) my-json)
=/  main  (~(got by my-map) %main)
=/  wind  (~(got by my-map) %wind)
=/  temp  (trip ((ot 'temp'^no ~) main))
=/  speed  (trip ((ot 'speed'^no ~) wind))
%+  produce  %tang
:~  leaf+"Wind speed: {speed} meters per second"
    leaf+"Temperature: {temp} degrees kelvin"
    leaf+"Results for {name}"
==
