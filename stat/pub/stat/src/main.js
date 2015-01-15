window.urb.appl = "stat"

try {
  vat = JSON.parse($('#vat').text())
  if(!vat[window.urb.ship])
    vat[window.urb.ship] = ""
} catch (e) {
  console.log($('#vat').text())
  console.log('something wrong with that vat.')
}

render = function(vat) {
  $list = $("<ul></ul>")
  for(ship in vat) {
    $row = $("<li></li>")
    $row.append("<div class='ship'>"+ship+"</div>")
    
    $status = $("<input value='"+vat[ship]+"' />")
    if(ship == window.urb.ship &&
       window.urb.ship == window.urb.user)
      attr = {
        "type":"text",
        "class":"fiel mine"
        }
    else
      attr = {
        "type":"button",
        "class":"fiel their"
      }
    $status.attr(attr)
    $row.append($status)
    
    if(window.urb.ship == window.urb.user) {
      if(ship != window.urb.ship) {
        $subsc = $("<input value='- Unsubscribe' />")
        $subsc.attr({
          "data-ship":ship,
          "type":"button",
          "class":"actn unsub"
        })
        $row.append($subsc)
      }
    } else {
      $subsc = $("<input value='+ Subscribe' />")
      $subsc.attr({
        "type":"button",
        "class":"actn subsc"
      })
      $row.append($subsc)
    }
    
    $list.append($row)
  }
  $('#stat').html($list)
}

update = function() { 
  stat = $("input.mine").val()
  window.urb.send({
    "data":{"upd-stat":[window.urb.ship, stat]}
  },
    function(err,res) {
      console.log(arguments)
    }
  )
}

t = null
$("#stat").on("change", "input.mine", function(e) {
  if(t) { clearTimeout(t); }
  setTimeout(update,1000)
})
$('#stat').on("click", ".subsc", function(e) {
  $t = $(e.target)
  if($t.hasClass('disabled'))
    return false
  $t.addClass('disabled')
  window.urb.send({
    "data":{"sub-stat":window.urb.user}
  }, function(err,res) {
    console.log('req seub')
    console.log(arguments)
    $t.remove()
  })
})
$('#stat').on("click", ".unsub", function(e) {
  $t = $(e.target)
  if($t.hasClass('disabled'))
    return false
  $t.addClass('disabled')
  window.urb.send({
    "data":{"usu-stat":$(e.target).attr('data-ship')}
  }, function(err,res) {
    console.log('req seub')
    console.log(arguments)
    $t.remove()
  })
})

init_sub = function() {
  window.urb.subscribe({
    "path":"/data"
  }, function(err,res) {
    if(err) {
      console.log('subscrption error')
      console.log(arguments)
      return false;
    }
    console.log('subcsription event')
    console.log(arguments)
    if(!res.data.conn && !res.data.ok) {
      render(res.data)
    }
  })
}

init_sub()
render(vat)