recl   = React.createClass
div    = React.DOM.div
input  = React.DOM.input
button = React.DOM.button
textar = React.DOM.textarea

Page = recl({
  displayName: 'Page',

  render: function(){
    return  div({}, Compose({}), Inbox({messages:this.props.messages}))
  }
})

Compose = recl({
  displayName: 'Mess',

  validate: function(to,subj,body){
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
    $to = $(this.getDOMNode()).find('.to')
    $subj = $(this.getDOMNode()).find('.subj')
    $body = $(this.getDOMNode()).find('.body')

    if(this.validate($to.val(),$subj.val(),$body.val()) !== true) {
      $(this.getDOMNode()).find('.'+valid).focus()
      return false
    }

    urb.send({
      appl:"urbmail",
      data: {
        to:   $to.val(),
        subj: $subj.val(),
        body: $body.val()
      }
    }),
    $to.val('')
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

Inbox = recl({
  displayName: 'Inbox',

  render: function(){
   messages = []
   for (i in this.props.messages){
     messages.push(Message({message:this.props.messages[i]}))
   }
    return div({}, messages)
  }
})

Message = recl({
  render: function(){
    return  div({className:"Message"},
      div({className:"to"}, this.props.message.to),
      div({className:"subj"}, this.props.message.subj),
      div({className:"body"}, this.props.message.body))
  }
})


$(document).ready(function(){
  mounted = React.render(Page({}), $("#container")[0])
  urb.bind("/", {appl:'urbmail'}, function(e,d){
    mounted.setProps({messages:d.data})
  })
})
