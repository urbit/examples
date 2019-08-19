/* eslint-disable no-console */

// main

var feedURL = window.location.protocol + '//' + window.location.host + '/~~/pages/feed';
var redirectButton = '<button onclick="redirect()">Load your Feed!</button>';

function redirect() {
  window.location.href = feedURL;
}

function subscribe() {
  var design = {
    design: {
      party: 'feed',
      config: {
        sources: [
          '~' + window.urb.user + '/public'
        ],
        caption: '~' + window.urb.user + "'s Feed.",
        cordon: {
          posture: 'green',
          list: []
        }
      }
    }
  };

  window.urb.send(
    design,                                             // data
    {                                                   // params
      appl: 'talk',
      mark: 'talk-command',
      ship: window.urb.user
    },
    function subscribed(error, response) {              // callback
      if (error || !response.data || response.fail) {
        console.warn('`urb.send` to ~' + window.urb.user + ' the data payload:');
        console.warn(design);
        console.warn('failed. Error:');
        console.warn(error);
        console.warn(response);
        return;
      }
      console.log('`urb.send` to ~' + window.urb.user + ' the data payload:');
      console.log(design);
      console.log('succeeded! Response:');
      console.log(response.data);
      document.getElementById('feedButton').innerHTML = redirectButton;
      document.getElementById('loading').classList.add('hidden');
    });
}

function lookHouse(house) {
  var feedCreated = false;
  house.forEach(function checkForFeed(station) {
    if (station.name === 'feed') {
      document.getElementById('feedButton').innerHTML = redirectButton;
      feedCreated = true;
      document.getElementById('loading').classList.add('hidden');
    }
  });

  if (!(feedCreated === true)) {
    subscribe();
  }
}

// onLoad

(function bindHouse() {                                 // bind to all local stations on ship.
  var path = '/';                                       // path for `house`.
  return window.urb.bind(
    path,                                               // path
    {                                                   // params
      appl: 'talk',
      mark: 'json',
      ship: window.urb.user
    },
    function gotHouse(error, response) {                // callback
      if (error || !response.data || response.fail) {
        console.warn('urb.bind at path `' + path + '` failed. Error: ');
        console.warn(error);
        console.warn(response);
        return;
      }
      console.log('urb.bind at path: `' + path + '` succeeded! Response data: ');
      console.log(response.data);
      lookHouse(response.data.house);
    });
}());

window.module = window.module || {};                    // eslint-disable-line no-global-assign
module.exports = {
  redirect: redirect,
  subscribe: subscribe
};
