$(function() {

    if ($(".sticky").length > 0) {

        var offset = $(".sticky").offset().top;

        $(window).scroll(function() {
            if ($(window).scrollTop() >= offset) {
               $(".sticky").addClass("fixed");
            } else {
               $(".sticky").removeClass("fixed");
            }
        });
    }

    $.localScroll({offset: -70});
});
