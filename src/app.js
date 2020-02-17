require('./css/responsive.css');
require('./css/style.css');
require('./css/app.css');

require('./typed.js');

require('./images/favicon.png');
require('./images/favicon-16x16.png');
require('./images/favicon-32x32.png');
require('./images/favicon-96x96.png');
require('./images/Aberdeen_station.jpg');
require('./images/logo.png');

var StationCodes = require('./stationCodeLookup');

stationCodeHandler = function() {
  const error = document.getElementById('stationCodeError');

  stationCodeResult.innerText = '';
  if (this.value.length > 3) {
    error.innerText = "too many characters - only enter 3 letters";
  } else if (this.value.length < 3) {
    error.innerText = "Not enough characters - enter 3 letters";
  } else {
    error.innerText = "";
    stationCodeResult.innerText = StationCodes(this.value);
  }
};

/*global $, jQuery, alert*/
$(document).ready(function() {

  'use strict';

  onload = function () {
    const e = document.getElementById('stationCode');
    e.oninput = stationCodeHandler;
    e.onpropertychange = e.oninput; // for IE8
    // e.onchange = e.oninput; // FF needs this in <select><option>...
    // other things for onload()
  };

  // ========================================================================= //
  //  //SMOOTH SCROLL
  // ========================================================================= //
  $(document).on("scroll", onScroll);

  $('a[href^="#"]').on('click', function(e) {
    e.preventDefault();
    $(document).off("scroll");

    $('a').each(function() {
      $(this).removeClass('active');
      if ($(window).width() < 768) {
        $('.nav-menu').slideUp();
      }
    });

    $(this).addClass('active');

    var target = this.hash,
      menu = target;

    target = $(target);
    $('html, body').stop().animate({
      'scrollTop': target.offset().top - 80
    }, 500, 'swing', function() {
      window.location.hash = target.selector;
      $(document).on("scroll", onScroll);
    });
  });
  function onScroll(event) {
    if ($('.home').length) {
      var scrollPos = $(document).scrollTop();
      $('nav ul li a').each(function() {
        var currLink = $(this);
        var refElement = $(currLink.attr("href"));
      });
    }
  }

  // ========================================================================= //
  //  //NAVBAR SHOW - HIDE
  // ========================================================================= //

  $(window).scroll(function() {
    var scroll = $(window).scrollTop();
    if (scroll > 200 ) {
      $("#main-nav, #main-nav-subpage").slideDown(700);
      $("#main-nav-subpage").removeClass('subpage-nav');
    } else {
      $("#main-nav").slideUp(700);
      $("#main-nav-subpage").hide();
      $("#main-nav-subpage").addClass('subpage-nav');
    }
  });

  // ========================================================================= //
  //  // RESPONSIVE MENU
  // ========================================================================= //

  $('.responsive').on('click', function(e) {
    $('.nav-menu').slideToggle();
  });

  // ========================================================================= //
  //  Typed Js
  // ========================================================================= //

  var typed = $(".typed");

  $(function() {
    typed.typed({
      strings: ["ABD Aberdeen", "BET Bethnal Green", "ISAGN I See A Great Need", "GFT GeoffTech", "WRU West Ruislip"],
      typeSpeed: 100,
      loop: true,
    });
  });

});
