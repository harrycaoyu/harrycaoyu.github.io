$(function() {

    var height = Math.min(document.body.clientHeight, document.body.clientWidth) * 0.8;

    $("#bubble-container").height(height).width(height);

    $(".portfolio").waypoint(function() {
        $(".gps_ring").addClass("ring_animate");
        $(".need_fast").addClass("fast").removeClass(".need_fast");
        $(".need_fast").addClass("slow").removeClass(".need_slow");
    }, { offset: 200 });

    $('.carousel').carousel();
});
