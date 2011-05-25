var countdown; //initial value grabbed in event partial (for page loading convenience)
var ms_in_hour = 60 * 60 * 1000;

//times in seconds
//var instagramReload = 50;
var foursquareReload = 30;
var imageCycle = 5;

// per/hour
var twitter_max = 130;
var twitter_hash_percent = .75;
var twitter_hash_max = twitter_max * twitter_hash_percent;
var twitter_handle_max = twitter_max - twitter_hash_max;
var twitter_hash_reload = ms_in_hour / twitter_hash_max;
var twitter_handle_reload = ms_in_hour / twitter_handle_max;

$(document).ready(function () {
  $('#sponsor ul li:first').toggleClass('hidden').toggleClass('visible');
  $('#event').load('/events');
  $('#twitterHashtag').load('/twitter/hashtag');
  $('#twitterHandle').load('/twitter/handle');
  $('#instagram').load('/instagram');
  $('#foursquare').load('/foursquare');

  init_reloads();
});

function reloadSection(selector, url, interval) {
  setInterval(function() {
    $(selector).load(url);
  }, interval);
}

function init_reloads() {
  reloadSection('#twitterHashtag', '/twitter/hashtag', twitter_hash_reload);
  reloadSection('#twitterHandle', '/twitter/handle', twitter_handle_reload);
  //reloadSection('#instagram', '/instagram', instagramReload * 1000);
  reloadSection('#foursquare', '/foursquare', foursquareReload * 1000);
}

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

//cycle instagram images 
setInterval(function(){
  var visibleImage = $('#instagram ul li.visible');
  if (visibleImage.is($('#instagram ul li:last'))) {
    //$('#instagram ul li:first').toggleClass('hidden').toggleClass('visible');
    $('#instagram').load('/instagram');
  } else {
    visibleImage.next().toggleClass('hidden').toggleClass('visible');
  }
  visibleImage.toggleClass('hidden').toggleClass('visible');
}, imageCycle * 1000);

setInterval(function(){
  countdown = countdown - 1;
  $('#countdown').html(prettyTime(countdown));
  if (countdown < 1) {
    $('#event').load('/events');
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
