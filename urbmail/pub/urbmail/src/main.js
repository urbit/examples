recl = React.createClass
div = React.DOM.div
input = React.DOM.input
button = React.DOM.button
textar = React.DOM.textarea

Page = recl({
  displayName: 'Page',
  render: function(){
    return  div({}, MessForms({}), Inbox({messages:this.props.messages}))
  }
})

MessForms = recl({
  displayName: 'Mess',
  render: function(){
    return(
      div({},
        To({}),
        Subj({}),
        Body({}),
        button({onClick:this.handleClick}, "Send")
      )
    )
  },
  handleClick: function(){
    //if all are valid
    urb.send({
      appl:"urbmail",
      data: {
        to:   $(this.getDOMNode()).find('.to').val(),
        subj: $(this.getDOMNode()).find('.subj').val(),
        body: $(this.getDOMNode()).find('.body').val()
      }
    }),
    $(this.getDOMNode()).find('.to').val(''),
    $(this.getDOMNode()).find('.subj').val(''),
    $(this.getDOMNode()).find('.body').val('')
  }
})

To = recl({
  render: function(){
    return div({}, input({className:"to", placeholder: "To"}))
  }
})

Subj = recl({
  render: function(){
    return div({}, input({className:"subj",placeholder: "Subject"}))
  }
})

Body = recl({
  render: function(){
    return div({}, textar({className:"body",placeholder: "Body"}))
  }
})

Inbox = recl({
  displayName: 'Inbox',
  render: function(){
   msgList = []
   for (i in this.props.messages){
     msgList.push(MessageDisp({message: this.props.messages[i]}))
   }
    return div({}, msgList)
  }
})

MessageDisp = recl({
  render: function(){
    return  div({},
      div({}, this.props.message.to),
      div({}, this.props.message.subj),
      div({}, this.props.message.body))
  }
})


$(document).ready(function(){
  mounted = React.render(
    Page({}), $("#container")[0]
    )
  urb.bind("/", {appl:'urbmail'}, function(e,d){
    console.log(e,d.data)
    mounted.setProps({messages:d.data})
  })
})
