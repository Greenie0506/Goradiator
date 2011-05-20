$(document).ready(function(){
$('#twitter').load('/twitter.js');
$('#instagram').load('/instagram.js');
$('#nextEvent').load('/events.js');
});
setInterval(function() {
  $('#twitter').load('/twitter.js');
}, 5000);

setInterval(function() {
  $('#instagram').load('/instagram.js');
}, 1000);

setInterval(function(){
  $('#nextEvent').load('/event.js');
}, 600000);
