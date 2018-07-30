// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery_ujs
//= require turbolinks

//= require bootstrap
//= require_tree .

function gallery() {
    //document.getElementById("gallery")
    toggleFullScreen();
}
function slider() {
	var windowHeight = $(window).height();
	document.getElementById('slides').style.display = "block";
	var headerHeight = $("header").outerHeight();
	var calculatedHeight = windowHeight - headerHeight;
	var heightFill = $('.height-fill')
	$(heightFill).height(calculatedHeight);
	// superslides
	$(function() {
		$('#slides').superslides({
			//inherit_height_from : '.height-fill',
			hashchange : true,
			//play : 10000,
			pagination: false
			//animation : 'fade'
		});
		// $('#slides').on('mouseenter', function() {
			// $(this).superslides('stop');
			// console.log('Stopped')
		// });
		// $('#slides').on('mouseleave', function() {
			// $(this).superslides('start');
			// console.log('Started')
		// });
	});
}

function untoggle() {

	if (document.cancelFullScreen) {
		document.cancelFullScreen();
	} else if (document.mozCancelFullScreen) {
		document.mozCancelFullScreen();
	} else if (document.webkitCancelFullScreen) {
		document.webkitCancelFullScreen();
	}

}

function toggleFullScreen() {
	if ((document.fullScreenElement && document.fullScreenElement !== null) || (!document.mozFullScreen && !document.webkitIsFullScreen)) {
		if (document.documentElement.requestFullScreen) {
			document.documentElement.requestFullScreen();
		} else if (document.documentElement.mozRequestFullScreen) {
			document.documentElement.mozRequestFullScreen();
		} else if (document.documentElement.webkitRequestFullScreen) {
			document.documentElement.webkitRequestFullScreen(Element.ALLOW_KEYBOARD_INPUT);
		}
	}

	document.addEventListener("webkitfullscreenchange", function() {
		slider();
	}, false);
	document.addEventListener("fullscreenchange", function() {
		slider();
	}, false);
	document.addEventListener("msfullscreenchange", function() {
		slider();
	}, false);
	document.addEventListener("mozfullscreenchange", function() {

		slider();
	}, false);

}



	var ENTER = 13; //This is the js keycode for ENTER
	var left = 37;
	var right = 39;

function my_custom_keypress(e){
	console.log('hi');
  key = e.which;
  if(key == left){
	  window.location = $('#prev').attr('href');
  }
  else if(key == right){
      window.location = $('#next').attr('href'); //...and sends the user to that URL.
  }
}

$(document).on('keydown', my_custom_keypress); //when user presses a key, triggers our fxn



