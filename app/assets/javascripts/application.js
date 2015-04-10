// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require foundation
//= require jquery.slick
//= require jquery.waypoints.min
//= require shortcuts/infinite.min
//= require_tree .
//$(function() {
//    $(document).foundation();
//
//    // Autoload playlists
    //var plist_link = $('#playlist_link')
    //if (plist_link.length > 0) {
    //    $.getScript(plist_link.attr('href'))
    //}
//});

var init_avatar_carousel = function(carousel) {
    carousel.slick({
        autoplay: true,
        arrows: false,
        dots: false,
        autoplaySpeed: Math.random() * 3000 + 1000,
        fade: true,
        pauseOnHover: false
    });
}