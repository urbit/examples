recl   = React.createClass
div    = React.DOM.div
input  = React.DOM.input
button = React.DOM.button
textar = React.DOM.textarea

Page = recl({                                                         // top level component
  displayName: 'Page',

  render: function(){
    return  div({}, Compose({}), Inbox({messages:this.props.messages}))
  }
})

Compose = recl({                                                      // compose
  displayName: 'Mess',

  validate: function(to,sub,bod){                                   // validate outgoing
    valid = true
    if(to[0] !== "~" || to.length < 4)
      valid = "to"
    if(sub.length < 1)
      valid = "sub"
    if(bod.length < 1)
      valid = "bod"
    return valid
  },

  handleClick: function(){
    $to = $(this.getDOMNode()).find('.to')                            // aliases
    $sub = $(this.getDOMNode()).find('.sub')
    $bod = $(this.getDOMNode()).find('.bod')

    if(this.validate($to.val(),$sub.val(),$bod.val()) !== true) {   // validate
      $(this.getDOMNode()).find('.'+valid).focus()                    // return if needed
      return false
    }

    urb.send({                                                        // send to server
        to:   $to.val(),
        sub: $sub.val(),
        bod: $bod.val()
      }, {
      appl:"mail",
      mark:"mail-send",
    }),

    $to.val('')                                                       // reset
    $sub.val('')
    $bod.val('')
  },

  render: function(){
    return(
      div({},
        div({}, input({className:"to", placeholder: "To"})),
        div({}, input({className:"sub",placeholder: "Subject"})),
        div({}, textar({className:"bod",placeholder: "Body"})),
        button({onClick:this.handleClick}, "Send")
      )
    )
  }
})


Message = recl({                                                      // simple message
  render: function(){
    return  div({className:"Message"},
      div({className:"fom"}, this.props.message.fom),
      div({className:"sub"}, this.props.message.sub),
      div({className:"bod"}, this.props.message.bod))
  }
})

Inbox = recl({                                                        // list of received messages
  displayName: 'Inbox',

  render: function(){
   messages = []
   for (i in this.props.messages){
     messages.push(Message({message:this.props.messages[i]}))
   }
    return div({}, messages)
  }
})

$(document).ready(function(){                                         // render when ready
  mounted = React.render(Page({}), $("#container")[0])
  urb.bind("/", {appl:'mail'}, function(e,d){                      // bind to backend
    mounted.setProps({messages:d.data})
  })
})
