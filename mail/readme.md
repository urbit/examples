# mail

This app allows a ship to send an email-like message to another ship over the network.

##how it works and what to pay attention to
The major difference between mail and both foos and tic-tac-toe is that mail sends typed messages between ships over the network (see lines 75-77). For more info on how to make "moves" (aka system calls), check out the arvo proper reference section.

This is also the first time we've defined a data type for our system calls: `++move`. Although there is no formal definition for `++move` in zuse or gall, is is convention to do so in more complicated apps.

Lastly, this is the first time we've encountered `++pour`, which is the arm that receives responses to the requests we make `++note`. In this case the only response we receive is positive acknowledgement (aka a %nice) that we receive from our subscribers after we've sent them an update. All we do in response is send a %nice in return.