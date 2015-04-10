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
    console.log("start loading");
    $('#content').addClass('fadeOut animated');
    $('#loading').addClass('visible');
}

var stop_loading = function() {
    console.log("stop loading");
    $('#content').removeClass('fadeOut');
    $('#loading').removeClass('visible');
}

var init_loading_animation = function() {
    console.log("init loading");
    $(window).load(stop_loading);
    //start_loading();
    //$(document).on('beforeunload', start_loading);
    $(document).on('pageshow', stop_loading);
}

var init_loading_links = function() {
    //$("a[target!=blank]").each( function() {
    //    var e = $(this);
    //    if (e.attr('href')[0] != '#')
    //        e.click(start_loading);
    //});

    $(document).click(function(e){
        if($(e.target).closest('a[target!=blank]').length) {
            start_loading();
        }
    });
}

//var is_chrome = navigator.userAgent.indexOf('Chrome') > -1;
//var is_explorer = navigator.userAgent.indexOf('MSIE') > -1;
//var is_firefox = navigator.userAgent.indexOf('Firefox') > -1;
//var is_safari = navigator.userAgent.indexOf("Safari") > -1;
//var is_opera = navigator.userAgent.toLowerCase().indexOf("op") > -1;
//if ((is_chrome)&&(is_safari)) {is_safari=false;}
//if ((is_chrome)&&(is_opera)) {is_chrome=false;}

var init_avatar_carousels = function() {
    //if (is_safari) return;
    var avatar_links = $('.avatar-carousel');
    if (avatar_links.length > 0) {
        avatar_links.each(function(index) {
            $.getScript($(this).attr('data-avatars-src'));
        })
    }
}