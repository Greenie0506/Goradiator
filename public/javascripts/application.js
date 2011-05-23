var countdown; //initial value grabbed in event partial (for page loading convenience)
//times in seconds
var twitterReload = 20;
var instagramReload = 20;
var foursquareReload = 100;
var imageCycle = 5;

$(document).ready(function(){
  $('#twitter').load('/twitter.js');
  $('#instagram').load('/instagram.js');
  $('#event').load('/events.js');
  $('#sponsor ul li:first').toggleClass('hidden').toggleClass('visible');
  $('#foursquare').load('/foursquare.js');
});

//sponsor image cycling
setInterval(function () {
  var visibleSponsor = $('#sponsor .visible');

  if (visibleSponsor.is($('#sponsor li:last'))) {
    $('#sponsor li:first').toggleClass('hidden').toggleClass('visible');
  }
  else {
    visibleSponsor.next().toggleClass('hidden').toggleClass('visible');
  }
  visibleSponsor.toggleClass('hidden').toggleClass('visible');
}, imageCycle * 1000);

//twitter ajax
setInterval(function() {
  $('#twitter').load('/twitter.js');
}, twitterReload * 1000);

//instagram ajax
setInterval(function() {
  $('#instagram').load('/instagram.js');
}, instagramReload * 1000);

//foursquare image cycling
//setInterval(function(){
  //$('#foursquare').load('/foursquare.js');
//}, foursquareReload * 1000);

//
setInterval(function(){
  var visibleImage = $('#instagram ul li.visible');
  if (visibleImage.is($('#instagram ul li:last'))) {
    $('#instagram ul li:first').toggleClass('hidden').toggleClass('visible');
  } else {
    visibleImage.next().toggleClass('hidden').toggleClass('visible');
  }
  visibleImage.toggleClass('hidden').toggleClass('visible');
}, imageCycle * 1000);

setInterval(function(){
  countdown = countdown - 1;
  $('#countdown').html(prettyTime(countdown));
  if (countdown < 1) {
    $('#event').load('/events.js');
  }
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
