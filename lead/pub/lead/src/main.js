$(function() {
  var vat, _vat,
      $board, $add, $go, $err

  $board  = $('#board')
  $add    = $('#add')
  $go     = $('#go')
  $err    = $('#err')
  
  append_row = function(name,scor) {
    id = name.replace(/[!\"#$%&'\(\)\*\+,\.\/:;<=>\?\@\[\\\]\^`\{\|\}~]/g, '')
    $row = $("<li id='"+id+"' class='row' data-id='"+name+"'></li>")
    $info = $("<div class='info'></div>")
    info = "<div class='scor'>"+scor+"</div>"+
           "<div class='name'>"+name+"</div>"
    $info.html(info)
    $row.append($info)
    $row.append("<div class='bump'>+1</div>")
    $board.append($row)
  }
  
  render = function() {
    $board.find('li.row').remove()
    _vat = []
    keys = Object.keys(vat)
    for(k in keys) {
      _vat.push([keys[k],vat[keys[k]]])
    }
    _vat.sort(function(a,b) { return b[1] - a[1]; })
    for(k in _vat) {
      append_row(_vat[k][0],_vat[k][1])
    }
  }
  
  add = function() {
    window.urb.send(
      {"new-lead":$add.val()}
    ,function(err,res) {
      if(err)
        return $err.removeClass('disabled').text("There was a communication error. Sorry!")
      if(res.data !== undefined && 
         res.data.ok !== undefined && 
         res.data.ok !== true)
        $err.removeClass('disabled').text(res.data.res)
      else
        $add.val('')
      $add.attr('disabled', false).removeClass('disabled')
      $go.attr('disabled', false).removeClass('disabled')
    })
    $go.attr('disabled', true).addClass('disabled')
    $add.attr('disabled', true).addClass('disabled')
    $err.addClass('disabled').text('')
  }

  $add.on("keyup", function(e) {
    if(e.keyCode == 13)
      add()
  })

  $go.on("click", add)
  
  $board.on('click', '.bump', function(e) {
    $t = $(e.target).closest('li')
    $t.addClass('disabled')
    window.urb.send(
      {"add-lead":$t.attr('data-id')}
    ,function(err,res) {
      $t.removeClass('disabled')
    })
  })

  
  window.urb.appl = "lead"
  window.urb.bind('/',
    function(err,dat) {
      vat = dat.data
      render()
    } 
  )
  window.urb.bind("/data",function(err,res) {
    if(!err) {
      if(res.data && res.data['upd-lead']) {
        name = Object.keys(res.data['upd-lead'])[0]
        scor = res.data['upd-lead'][name]
        vat[name] = scor
        render()
      }
    }
  })
})
