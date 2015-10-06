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

  validate: function(to,subj,body){                                   // validate outgoing
    valid = true
    if(to[0] !== "~" || to.length < 4)
      valid = "to"
    if(subj.length < 1)
      valid = "subj"
    if(body.length < 1)
      valid = "body"
    return valid
  },

  handleClick: function(){
    $to = $(this.getDOMNode()).find('.to')                            // aliases
    $subj = $(this.getDOMNode()).find('.subj')
    $body = $(this.getDOMNode()).find('.body')

    if(this.validate($to.val(),$subj.val(),$body.val()) !== true) {   // validate
      $(this.getDOMNode()).find('.'+valid).focus()                    // return if needed
      return false
    }

    urb.send({                                                        // send to server
        to:   $to.val(),
        subj: $subj.val(),
        body: $body.val()
      }, {
      appl:"mail",
      mark:"message",
    }),

    $to.val('')                                                       // reset
    $subj.val('')
    $body.val('')
  },

  render: function(){
    return(
      div({},
        div({}, input({className:"to", placeholder: "To"})),
        div({}, input({className:"subj",placeholder: "Subject"})),
        div({}, textar({className:"body",placeholder: "Body"})),
        button({onClick:this.handleClick}, "Send")
      )
    )
  }
})


Message = recl({                                                      // simple message
  render: function(){
    return  div({className:"Message"},
      div({className:"to"}, this.props.message.mez.to),
      div({className:"subj"}, this.props.message.mez.subj),
      div({className:"body"}, this.props.message.mez.body))
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
