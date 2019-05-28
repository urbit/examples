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
|=  hit/httr:eyre
?~  r.hit  !!
=/  my-json  (de-json:html q.u.r.hit)
?~  my-json  !!
=,  dejs:format
=/  my-map
  %-  (om same)
  u.my-json
=/  name  (~(got by my-map) %name)
=/  weather  (~(got by my-map) %weather)
=/  main  (~(got by my-map) %main)
=/  wind  (~(got by my-map) %wind)
%+  produce  %tang
=/  returned-name
  ?+  name  ""
    [%s *]  (scow %tas p.name)
  ==
=/  returned-temp
  %.  %temp
  %~  got  by
  %-  (om same)
  main
=/  temp
?+  returned-temp  ""
  [%s *]  (scow %tas p.returned-temp)
==
=/  returned-speed
  %.  %speed
  %~  got  by
  %-  (om same)
  wind
=/  wind-speed
  ?+  returned-speed  ""
    [%s *]  (scow %tas p.returned-speed)
  ==
::
:~  leaf+"Wind speed: {wind-speed} meters per second"
    leaf+"Temperature: {temp} degrees kelvin"
    leaf+"Results for {returned-name}"
==