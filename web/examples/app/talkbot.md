# `:talkbot`

Source:

-   `/app/talkbot.hoon`

`:dojo`:

    ~your-urbit-1:talk[] ;create channel %examples 'example channel'
    ~your-urbit-1:dojo/examples> |start %talkbot
    ~your-urbit-1:dojo/examples> :talkbot [%join our %examples]
    ~your-urbit-2:talk[] ;join ~your-urbit-2/examples
    ~your-urbit-2:talk+ test

`~your-urbit-1` running `:talkbot` will auto-respond with:

    ~your-urbit-1+ :: test successful!

<br />

See: [~talkbot, the one and only](https://github.com/Fang-/talkbot)

Thanks, `~palfun-foslup`!
