//
//  simple todo list
//  javascript
////
  // 

//
////  ~fyr ~sivtyv-barnel
  //

var spawn = function(time){
  if(time == null) time = urb.util.toDate(new Date())
  return  $('<span />').append(
      $('<input>')
        .addClass('item')
        .attr('created', time), 
      $('<button>').addClass('del').text('x'),
      $('<button>').addClass('done').text('✓')
    )
}
spawn().appendTo('#container')


$('#container').on('click', '.del', function(event){
  $ele = $(this).parent().find('.item')
  $ele.val('')
  urb.send({appl:'todo',data:[$ele.attr('created'), '']})
  if($('#container').children().length > 1)
    $ele.parent().remove()
})

$('#container').on('click', '.done', function(event){
  $(this).parent().animate({height: "0px"})
  $ele = $(this).parent().find('.item')
  $ele.val('')
  urb.send({appl:'todo',data:[$ele.attr('created'), '']})
  if($('#container').children().length > 1)
    $ele.parent().remove()
})


var deferred = {}
defer = function(key,f){
  clearTimeout(deferred[key])
  deferred[key] = setTimeout(f, 500)
}


$('#container').on('keyup', '.item', function(event){
  $ele = $(this)
  defer($ele.attr('created'), function(){
    urb.send({appl:'todo',data:[$ele.attr('created'), $ele.val()]})
    if(event.keyCode == 13 && $ele.val() != '') 
      spawn()
        .insertAfter($ele.parent())
        .find('.item')
        .focus()
    else if(event.keyCode == 8 && $ele.val() == '') {
      next = $ele.parent().prev().find('.item')
      if(!next.length)
        next = $ele.parent().next().find('.item')
      if(next.length){
        next.focus()
        $ele.parent().remove()
      }
    }
  })
})

urb.subscribe({appl:"todo",path:"/"}, function(err, d){
  if(!d.data.items) return
  d.data.items.reverse()
  for(entry of d.data.items){
    selector = '#container .item[created = "' + entry.created +'"]'
    element = $(selector)
    if(element.length == 0){  // selector failed
      element = spawn(entry.created).prependTo('#container').find('.item')
    }
    element.val(entry.text)
  }
})