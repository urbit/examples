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
=/  name
%.  %name
%~  got  by
my-map
=/  weather
%.  %weather
%~  got  by
my-map
=/  main
%.  %main
%~  got  by
my-map
=/  wind
%.  %wind
%~  got  by
my-map
%+  produce  %tang
=/  returned-name  ?~  name  ""  ?+  p.name  ""  @t  (scow %tas p.name)  ==
=/  returned-temp
%.  %temp
%~  got  by
%-  (om same)
main
=/  temp  ?~  returned-temp  ""  ?+  p.returned-temp  ""  @ta  (scow %tas p.returned-temp)  ==
=/  returned-speed
%.  %speed
%~  got  by
%-  (om same)
wind
=/  wind-speed  ?~  returned-speed  ""  ?+  p.returned-speed  ""  @ta  (scow %tas p.returned-speed)  ==
::
:~  leaf+"Wind speed: {wind-speed} meters per second"
    leaf+"Temperature: {temp} degrees kelvin"
    leaf+"Results for {returned-name}"
==