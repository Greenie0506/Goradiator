var countdown;
$(document).ready(function(){
  $('#twitter').load('/twitter.js');
  $('#instagram').load('/instagram.js');
  $('#event').load('/events.js');
  $('#sponsor ul li:first').toggleClass('hidden').toggleClass('visible');
});


setInterval(function(){
  var visibleSponsor = $('#sponsor ul li.visible');
  if (visibleSponsor.is($('#sponsor ul li:last'))) {
    $('#sponsor ul li:first').toggleClass('hidden').toggleClass('visible');
  } else {
    visibleSponsor.next().toggleClass('hidden').toggleClass('visible');
  };
  visibleSponsor.toggleClass('hidden').toggleClass('visible');
}, 5000);

setInterval(function() {
  $('#twitter').load('/twitter.js');
}, 20000);

setInterval(function() {
  $('#instagram').load('/instagram.js');
}, 50000);

setInterval(function(){
  $('#event').load('/events.js');
}, 600000);

setInterval(function(){
  var visibleImage = $('#instagram ul li.visible');
  if (visibleImage.is($('#instagram ul li:last'))) {
    $('#instagram ul li:first').toggleClass('hidden').toggleClass('visible');
  } else {
    visibleImage.next().toggleClass('hidden').toggleClass('visible');
  }
  visibleImage.toggleClass('hidden').toggleClass('visible');
}, 5000);

setInterval(function(){
  countdown = countdown - 1;
  $('#countdown').html(prettyTime(countdown));
}, 1000);

function prettyTime (time) {
  var mod = time % (24*60*60);
  var hours = Math.floor(mod / (60*60));
  mod = mod % (60 * 60);
  var mins = Math.floor(mod / 60);
  mod = mod % 60;
  var secs = Math.floor(mod);
  if (secs < 10) { secs = "0" + secs};
  if (mins < 10) { mins = "0" + mins};
  var string = hours +":"+ mins +":"+ secs;
  return string;
}
