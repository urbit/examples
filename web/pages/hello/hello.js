/* eslint-disable no-console */

// main

function helloWorld() {
  var helloWorld = 'Hello, world!'

  window.urb.send(
    helloWorld,                                         //  data
    {                                                   //  params
      appl: 'hello',                                    //  send to :hello
      mark: 'hello-world',                              //  data is of hello-world type
      ship: window.urb.user                             //  from me
    },
    function callback(error, response) {                // callback
      if (error || !response.data || response.fail) {
        console.warn('`urb.send` to ~' + window.urb.user + ' the data payload:');
        console.warn(helloWorld);
        console.warn('failed. Error:');
        console.warn(error);
        console.warn(response);
        return;
      }
      console.log('`urb.send` to ~' + window.urb.user + ' the data payload:');
      console.log(helloWorld);
      console.log('succeeded! Response:');
      console.log(response.data);
      document.getElementById('pokeButton').innerHTML = 'Look in your <code>:dojo</code>!';
    });
}

// onLoad

(function bindHello() {                                 //  bind to :hello at path:
  var path = '/web';                                    //  calls ++peer-web in /app/hello
  return window.urb.bind(
    path,                                               //  path
    {                                                   //  params
      appl: 'hello',                                    //  bind to :hello
      mark: 'json',                                     //  give me json
      ship: window.urb.user                             //  i'm me (authenticated)
    },
    function callback(error, response) {                //  callback
      if (error || !response.data || response.fail) {
        console.warn('urb.bind at path `' + path + '` failed. Error: ');
        console.warn(error);
        console.warn(response);
        return;
      }
      console.log('urb.bind at path: `' + path + '` succeeded! Response data: ');
      console.log(response.data);
      document.getElementById('helloWorld').innerHTML = response.data;
    });
}());

window.module = window.module || {};                    //  eslint-disable-line no-global-assign
module.exports = {
  helloWorld: helloWorld
};
