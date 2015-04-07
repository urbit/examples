recl = React.createClass
div = React.DOM.div
ul = React.DOM.ul
li = React.DOM.li
input = React.DOM.input
span = React.DOM.span
button = React.DOM.button
//display turn must change


Page = recl({
  render: function(){
  
    if (this.props.turn == 'X') 
      var display = 'X\'s turn'
    else
      var display = 'O\'s turn'

    return (
      div({},
        Board({board:this.props.board}),
        span({}, display)
      )
    )}
})

Board = recl({
  render: function(){
    var elems = []
    for(i=0;i<3;i++) {
      if(i===0) { row = 'top' }
      if(i===1) { row = 'middle' }
      if(i===2) { row = 'bottom' }

      for(p=0;p<3;p++) {
        if(p===0) { col = 'left' }
        if(p===1) { col = 'center' }
        if(p===2) { col = 'right' }
/[xo]/.test(
        text = "  "
        if(this.props.board[i]) {
          if(this.props.board[i][p]) {
            text = this.props.board[i][p]
          }
        }
        elems.push(Box({row:row,col:col,text:text}))
      }
    }

    return(
      div({id:"board"},
      elems)
    )
  }
})

Box = recl({
  getInitialState: function(){return {text:this.props.text}},
  
  render: function(){ 
    return(
      div({className:"box",key:this.props.row+"-"+this.props.col}, //key for access later?
        button({
          onClick:this.handleClick,
          className:this.props.row+"-"+this.props.col
        }, this.props.text) 
      )
    )
  },

  handleClick: function(){
    if (this.isValid(this.state)){
      if(this.state.text.trim().length === 0){
        urb.send({
          appl:"tic",
          data:{
              row:this.props.row,
              column:this.props.col,
              space:mounted.props.turn.toLowerCase()},
          mark:"json"
        })
        this.setState({text:mounted.props.turn})
        mounted.setProps(
           mounted.props.turn == 'X'
           ? {turn:'O'}
           : {turn:'X'}
        )
      }
    }
  },

  isValid : function(state){
    var valid = true;
    if(state.text == 'X' || state.text == 'O'){
      valid = false;
      alert("false")
    }
    return valid;
  }
})




$(document).ready(function(){
  mounted = React.render(Page({turn:'X',board:{}}), $("#container")[0])
  urb.bind("/",{appl:"tic"}, function(err,d) { mounted.setProps({board:d.data}) })
})
