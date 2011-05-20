$(document).ready(function(){
$('#twitter').load('/twitter.js');
$('#instagram').load('/instagram.js');
$('#event').load('/events.js');
});
setInterval(function() {
  $('#twitter').load('/twitter.js');
}, 20000);

setInterval(function() {
  $('#instagram').load('/instagram.js');
}, 20000);

setInterval(function(){
  $('#event').load('/event.js');
}, 600000);
