var loader = {};
var image_cycle = {};
var countdown; //initial value grabbed in event partial (for page loading convenience)
var ms_in_hour = 60 * 60 * 1000;

//times in seconds
var instagramReload = 50;
var foursquareReload = 30;
var imageCycle = 5;

// per/hour
var twitter_max = 130;
var twitter_hash_percent = .75;
var twitter_hash_max = twitter_max * twitter_hash_percent;
var twitter_handle_max = twitter_max - twitter_hash_max;
var twitter_hash_reload = ms_in_hour / twitter_hash_max;
var twitter_handle_reload = ms_in_hour / twitter_handle_max;

$(document).ready(init_reloads);

function load_section(selector, url, opts) {
  var old_interval = loader[url];
  opts = opts || {};

  if (old_interval) {
    clearInterval(old_interval);
  }
  $(selector).load(url, opts.callback);
  if (opts.interval > 0) {
    loader[url] = setInterval(function() {
      $(selector).load(url, opts.callback);
    }, opts.interval);
  }
}

function load_instagram() {
  load_section('#instagram', '/instagram', {
    callback: cycle_instagram
  });
}

function init_reloads() {
  load_section('#event', '/events');
  load_section('#twitterHashtag', '/twitter/hashtag', {
    interval: twitter_hash_reload
  });
  load_section('#twitterHandle', '/twitter/handle', {
    interval: twitter_handle_reload
  });
  load_instagram();
  load_section('#foursquare', '/foursquare', {
    interval: foursquareReload * 1000
  });
}

function cycle_instagram() {
  clearInterval(image_cycle.instagram);
  image_cycle.instagram = setInterval(function () {
    var visibleImage = $('#instagram ul li.visible');

    if (visibleImage.length === 0 || visibleImage.is($('#instagram ul li:last'))) {
      load_instagram();
    }
    else {
      visibleImage.next().toggleClass('hidden').toggleClass('visible');
      visibleImage.toggleClass('hidden').toggleClass('visible');
    }
  }, imageCycle * 1000);
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
