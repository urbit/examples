recl = React.createClass
div = React.DOM.div
input = React.DOM.input
button = React.DOM.button
textar = React.DOM.textarea

$(document).ready(function(){
  mounted = React.render(
    Page({}), $("#container")[0]
    )
})

Page = recl({
  render: function(){
    return(div({}), MessForms({}))
  }
})

MessForms = recl({
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
