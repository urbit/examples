# speakrune

A simple generator that tells you how to pronounce a Rune (or any sequence of one or more symbols with Urbit names). 
Copy /gen into your ship, `|commit %home` and run `+speakrune "=>"` from the Dojo to test it out.

## How speakrune works

This is a simple example of how to create sets and maps and do lookups with them. A set of the input characters is created 
to check there are no invalid characters in the input and then a map of Urbit symbols to names is used to generate the 
output showing you how to pronounce the symbols.
