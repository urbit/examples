`/click`

This app demonstrates how to send data from the browser to an urbit app.

Follow the instructions in the root readme to set up a fake galaxy and start the app. Then just click the button in the browser.

Let's briefly walk through what we just did. Clicking the 'poke' button triggered the 'on click' function in click.js, which sends typed data of the `examples-click` mark--specifically the text 'click'--to our `/click` app. `/click` receives this data on its `++poke-examples-click` arm, incrementing the number of `clicks` in our state. When we have a state change, `++peer-the-path` is called, sending the updated number of clicks to the client for display.


