// XXX  trailing fas breaks stuff?
$(function() {
  var clicks, $go, $clicks, $err

  $go     = $('#go')
  $clicks = $('#clicks')
  $err    = $('#err')

  $go.on("click",
    function() {
      window.urb.send(
        "click", {mark: "examples-click"}
      ,function(err,res) {
        if(err)
          return $err.text("There was an error. Sorry!")
        if(res.data !== undefined && 
           res.data.ok !== undefined && 
           res.data.ok !== true)
          $err.text(res.data.res)
        else
          console.log("poke succeeded");
      })
  })

  window.urb.appl = "examples-click"
  window.urb.bind('/the-path',
    function(err,dat) {
      clicks = dat.data.clicks
      $clicks.text(clicks)
    }
  )
})
