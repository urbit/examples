div    = React.DOM.div
ul     = React.DOM.ul
li     = React.DOM.li
input  = React.DOM.input
button = React.DOM.button

recl   = React.createClass

Page = recl({                                                         // top level component
  render: function(){return (
    div({},
    AddFixture({load:this.props.load,fixtures:this.props.fixture}),
    Fixtures({fixturesList:this.props.fixturesList}),
    Standings({fixturesList:this.props.fixturesList})
    )
  )},
})

AddFixture = recl({                                                   // add component
  _handleClick: function() { this.submit(); },                        // click and
  _handleKey: function(e) { if(e.keyCode == 13) this.submit(); },     // enter go to the same place

  validRange: function(score){                                        // foosball is  played to 10
    if(score < 0 || score > 10) return false
    return true
  },

  isValid: function(bscore,yscore,bcons,ycons){                       // validate input
    valid = true
    if(bcons.length === 0 || 
       ycons.length === 0 || 
       isNaN(bscore) || 
       isNaN(yscore)) { 
      valid = "Something isn't quite right with your input"
      return valid
    }
    if(this.validRange(bscore) && this.validRange(yscore)){
      if(bscore == 10 || yscore == 10){
        if(yscore == 10 && bscore == 10) valid = "Scores can't both be 10?"
      } else valid = "Scores aren't quite right"
    } else valid = "Scores aren't quite right"
    if(bcons.toLowerCase() == ycons.toLowerCase())
      valid = "Two players can't be the same!"
    return valid
  },

  submit: function() {
    if(this.props.load === true)
      return false

    $el = $(this.getDOMNode())                                        // cache for jquery calls

    bcons = $el.find('#bcons').val().trim()                           // get values for b and y
    bscore = parseInt($el.find('#bscore').val().trim())

    ycons = $el.find('#ycons').val().trim()
    yscore = parseInt($el.find('#yscore').val().trim())

    if(this.isValid(bscore,yscore,bcons,ycons) !== true) {            // validate 
      alert(valid) 
      return false
    }

    mounted.setProps({load:true})

    urb.send({                                                        // send to server
        bcons:bcons, 
        ycons:ycons, 
        bscore:bscore, 
        yscore:yscore
    }, function(){
      newFixturesList = mounted.props.fixturesList.slice();           // copy the fixtures list
      newFixturesList.push({                                          // add our new fixture
        bcons:bcons,
        ycons:ycons, 
        bscore:bscore, 
        yscore:yscore,
        pending:true
      })
      mounted.setProps({fixturesList:newFixturesList})                // set props in the parent
      $el.find('#bcons').val('');                                     // reset on callback
      $el.find('#bscore').val('');
      $el.find('#ycons').val('');
      $el.find('#yscore').val('');
      return;
    })
  },

  render: function() {
    return div({id:"afix"},
      [div({className:'contestant'},'Contestant'),
       div({className:'score'},'Score'),
       div({className:'score'},'Score'),
       div({className:'contestant'},'Contestant'),
       input({
        className:'contestant black', 
        id:'bcons', 
        onKeyDown:this._handleKey}),
       input({
        className:'score black', 
        id:'bscore', 
        onKeyDown:this._handleKey}),
       input({
        className:'score yellow', 
        id:'yscore', 
        onKeyDown:this._handleKey}),
       input({
        className:'contestant yellow', 
        id:'ycons', 
        onKeyDown:this._handleKey}),
       button({
        id:'entrees', 
        onClick:this._handleClick}, 
        'Submit')
    ])
  }
})

Fixture = recl({
  render: function() {
    klass = 'fixture'
    if(this.props.pending) klass += ' pending'
    return li({className:klass}, 
            [div({className:'contestant'}, this.props.bcons),
             div({className:'score'}, this.props.bscore),
             div({className:'score'}, this.props.yscore),
             div({className:'contestant'}, this.props.ycons)])
  }
})

//List all played fixtures
Fixtures = recl({
  render: function(){
    return (ul({className:'fixturesList'}, this.props.fixturesList.map(Fixture)))
  }
})

Standing = recl({
  render: function(){
    return li({},
      [div({className:'standElem'},this.props.player), 
       div({className:'standElem'},this.props.wins), 
       div({className:'standElem'},this.props.losses)])
  }
})

//update standings
Standings = recl({
  render: function(){
    var updatedRecords = fixturesToStandings(this.props.fixturesList)
    var sortedRecords = updatedRecords.sort(standingSort)
    heading = li({},
      [div({className: 'standElem'},'Player'), 
       div({className: 'standElem'},'Wins'), 
       div({className: 'standElem'},'Losses')
    ])
    return ul({className:"standings"},[heading, sortedRecords.map(Standing).reverse()]) //
  }
})

//sort players by record
standingSort = function (a,b){                
  switch(true){
    case a.wins  > b.wins: return 1;
    case a.wins  < b.wins: return -1;
    case a.losses < b.losses: return 1;
    case a.losses > b.losses: return -1;
    default: return (a.player).localeCompare(b.player);
  }
}


fixturesToStandings = function (fixtures) {
  var standings ={}
  for (i in fixtures){
    var fix = fixtures[i]
    if (!standings[fix.bcons]) standings[fix.bcons] = {wins:0, losses:0}
    if (!standings[fix.ycons]) standings[fix.ycons] = {wins:0, losses:0}
    if (fix.bscore == 10){
      var winner = fix.bcons
      var loser = fix.ycons
    }
    else if (fix.yscore == 10){
      var winner = fix.ycons
      var loser = fix.bcons
    } else if(true) throw 'wtf';
    standings[winner].wins++
    standings[loser].losses++
  }
  return Object.keys(standings).map(function(player){
    return({player:player, wins:standings[player].wins, losses:standings[player].losses})
  })
}

$(document).ready(function() {
  mounted = React.render(Page({players:[], fixturesList:[]}), $("#container")[0])
  urb.appl = "foos"
  urb.bind("/", function(err,d){
    mounted.setProps({
      load:false,
      fixturesList:d.data
    })
  })
})
