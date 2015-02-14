function clog(a){
  console.log(a)
}
clog("subscribing")
urb.subscribe({appl:"fbpost",path:"/"}, function(err, d){
  if(!d.data) {clog("null state"); return}
  if(d.data.first) $('#name').text("Hello, " + d.data.first + "!")
  // photo.src = d.data.photo
  $('#photo').attr('src', d.data.photo)
  console.log(d);
  
  })
clog("subscribed")


$('#photo').on('click', function(event){
  console.log('sending');
  urb.send({
    appl:'fbpost',
    data:['does this string send']
    })  
  })


// why do we need a for loop here on a subscription, are updates sent out in batches rather than on the fly?
