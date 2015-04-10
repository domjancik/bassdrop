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

var start_loading = function() {
    $('#content').addClass('fadeOut animated');
    $('#loading').addClass('visible');
}

var stop_loading = function() {
    $('#content').removeClass('fadeOut');
    $('#loading').removeClass('visible');
}

var init_loading_animation = function() {
    $(window).on('page:before-change', start_loading);
    $(document).on('page:before-unload', stop_loading);
}

var init_avatar_carousels = function() {
    var avatar_links = $('.avatar-carousel');
    if (avatar_links.length > 0) {
        avatar_links.each(function(index) {
            $.getScript($(this).attr('data-avatars-src'));
        })
    }
}

var initialized = false;
var init = function() {
    //if (!initialized) return;
    initialized = true;

    new WOW().init();

    $('.grid-carousel').slick({
        autoplay: true,
        arrows: false,
        dots: true,
        autoplaySpeed: 4000
    });

    // Put stuff here because application.js wasn't always called :(
    $(document).foundation();

    // Autoload playlists
    var plist_link = $('#playlist_link')
    if (plist_link.length > 0) {
        $.getScript(plist_link.attr('href'))
    }



    var infinite = new Waypoint.Infinite({
        element: $('.infinite-container')[0],
        offset: '110%'
    });

    init_loading_animation();
    init_avatar_carousels();
}

var deinit = function() {
    initialized = false;
}

$(document).on('page:load', init);
$(document).on('load', init);
$(document).on('ready', init);
$(document).on('page:before-load', init);

$(window).on('page:before-change', deinit);
$(document).on('page:before-unload', deinit);