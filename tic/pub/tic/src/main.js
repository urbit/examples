recl    = React.createClass                                      //  alias names
div     = React.DOM.div
ul      = React.DOM.ul
li      = React.DOM.li
input   = React.DOM.input
span    = React.DOM.span
button  = React.DOM.button

/*

----------
| page
| ----------
| | board
| | ----------
| | | box


the page uses three components, which are nested inside one another. 

*/


Page = recl({                                                    //  page component
  render: function(){
    return (
      div({className:"load-"+this.props.load},                   //  lock screen
        Board({board:this.props.board}),
        div({className:"turn"}, utf(this.props.turn))
      )
    )}
})

Board = recl({                                                   //  board component
  render: function(){
    var elems = []
    for(i=0;i<3;i++) {                                           //  construct row / column
      if(i===0) { row = 'top' }
      if(i===1) { row = 'middle' }
      if(i===2) { row = 'bottom' }

      for(p=0;p<3;p++) {
        if(p===0) { col = 'left' }
        if(p===1) { col = 'center' }
        if(p===2) { col = 'right' }
        text = "  "
        if(this.props.board[i]) {
          if(this.props.board[i][p]) {
            text = this.props.board[i][p]
          }
        }
        elems.push(Box({row:row,col:col,text:text}))             //  pass info to boxes
      }
    }

    return(
      div({id:"board"},elems)
    )
  }
})

Box = recl({                                                     //  box component
  getInitialState: function() { return {text:this.props.text}; },//  state is just 'x' or 'o'

  componentWillReceiveProps: function(nextProps) {
    if(mounted.props.load === false)                             //  only accept change when not loading
      this.setState({text:nextProps.text})                       //  this prevents overwriting our state
  },

  isValid : function(state){                                     //  confirm that box isnt taken
    return !(state.text.length > 0)
  },

  handleClick: function(){                                       //  box is clicked
    if(mounted.props.load == true)
      return false

    if (this.isValid(this.state)){
      urb.send({                                                 //  if valid, send an update
        appl:"tic",
        data:{
            row:this.props.row,
            col:this.props.col,
            space:mounted.props.turn.toLowerCase()},
        mark:"json"
      })
      this.setState({text:mounted.props.turn})                   //  update our state
      turn = mounted.props.turn == 'x' ? 'o' : 'x'               //  change turns
      mounted.setProps({                                         //  update turn in parent
        turn:turn,
        load:true
      })
    }
  },

  render: function() { 
    return(
      div({className:"box",key:this.props.row+"-"+this.props.col},  //  react likes keys for uniqueness
        button({
          onClick:this.handleClick,
          className:this.props.row+"-"+this.props.col
        }, utf(this.state.text)) 
      )
    )
  }
})




$(document).ready(function(){                                    //  setup when ready
  utf = function(t) {                                            //  utf-ify our xs and os
    _t = ""
    if(t == "x")
      _t = "✕"
    if(t == "o")
      _t = "◯"
    return _t
  }

  mounted = React.render(Page({turn:'x',board:{}}), $("#container")[0])  //  render top level component
  urb.bind("/",{appl:"tic"}, function(err,d) {                   //  bind to / for updates
    mounted.setProps({                                           //  when we get an update
      load:false,                                                //  set top level props
      board:d.data
    }) 
  })
})
