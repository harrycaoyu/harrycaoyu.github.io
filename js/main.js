$(function() {

    if ($('.sticky').length > 0) {

        var offset = $('.sticky').offset().top;

        $(window).scroll(function() {
            if ($(window).scrollTop() >= offset) {
               $('.sticky').addClass('fixed');
            } else {
               $('.sticky').removeClass('fixed');
            }
        });
    }

    $.localScroll({offset: -70});

    // set up Google Analytics for contact link
    $('#contactButton').on('click', function() {
        ga('send', 'event', 'button', 'click', 'contact button');
    });

    // typeform code
    (function(){var qs,js,q,s,d=document,gi=d.getElementById,ce=d.createElement,gt=d.getElementsByTagName,id='typef_orm',b='https://s3-eu-west-1.amazonaws.com/share.typeform.com/';if(!gi.call(d,id)){js=ce.call(d,'script');js.id=id;js.src=b+'share.js';q=gt.call(d,'script')[0];q.parentNode.insertBefore(js,q)}})()
});