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
  $('#event').load('/event.js');
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

