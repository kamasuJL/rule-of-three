/*global $*/

$(function(){
	$(window).scroll(function (){
		$('.js-fade').each(function(){
			var target = $(this);
			var targetPosition = target.offset().top;
			var windowScroll = $(window).scrollTop();
			var windowHeight = $(window).height();
			var triggerAt = targetPosition - windowHeight - 300;

			if (windowScroll > triggerAt){
				target.addClass('scroll');
			} else {
				target.removeClass('scroll');
			}
		});
	});
});
