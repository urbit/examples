recl = React.createClass
div = React.DOM.div
ul = React.DOM.ul
li = React.DOM.li
input = React.DOM.input
span = React.DOM.span
button = React.DOM.button

Page = recl({
  render: function(){
    var display;
    if (this.props.turn == 'X'){display = 'X\'s turn'}
      else{display = 'O\'s turn'}
    return(
    div({},
    Board({}),
    span({}, display)
    )
    )}
})

Board = recl({
  render: function(){
    var elems = []
    for (var i=0; i<9; i++){
      //give row info
      if(i < 3){var row = 'top'}
      else{ 
        if(i < 6){var row = 'middle'}
        else {var row ='bottom'}}
      //give column info
      var column = 'right'
      if(i % 3 == 0){var column = 'left'}
      else{if(i == 1 || i == 4 || i == 7) var column = 'center'}
      
      elems.push(Box({row:row,column:column}))
    }
    return(
      div({id:"board"},
      elems)
    )
  }
})

Box = recl({
  getInitialState: function(){return {text: '  '}}, //hack
  render: function(){ 
    return(
      div({className:"box"}, 
        button({onClick:this.handleClick, className:this.props.row+"-"+this.props.column}, 
          [this.state.text]
      ))
    )
  },
  handleClick: function(){
    if (this.isValid(this.state)){
      if(this.state.text == '  '){
        urb.send({
          appl:"tic",
          data:{
              row:this.props.row,
              column:this.props.column,
              space:mounted.props.turn.toLowerCase()},
          mark:"json"
        })
        this.state.text =  mounted.props.turn;
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
  mounted = React.render(
    Page({turn: 'X'}), $("#container")[0])
    urb.bind("/", function(err,d){
    for (i in d.data){
      for (j in d.data[i]){
        $el = $("."+i+"-"+j)        //need "." to get class with jquery
        $el.text(d.data[i][j].toUpperCase())
        console.log(i, j, d.data[i][j], $el)
      }
    } 
    })
})
