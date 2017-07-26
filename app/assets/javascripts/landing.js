/*Page Preloading*/


$(window).load(function () {
    $('#spinner').fadeOut();
    $('#preloader').delay(300).fadeOut('slow');
    setTimeout(function () {
        $('.first-slide div:first-child').addClass('fadeInDown');
    }, 100);
    setTimeout(function () {
        $('.first-slide div:last-child').addClass('fadeInRight');
    }, 100);
    setTimeout(function () {
        $('.color-switcher').addClass('slideInLeft');
    }, 100);
});

/*Document Ready*/
$(document).ready(function (e) {
    //prevent enter to submit
    $(window).keydown(function (event) {
        if (event.keyCode == 13) {
            event.preventDefault();
            return false;
        }
    });

    var quote_form = $('#home-zip-form');
    quote_form.validate({
        onkeyup: function (element, event) {
            if (event.which === 9 && this.elementValue(element) === "") {
                return;
            } else {
                this.element(element);
            }
        }
    });

    /********Responsive Navigation**********/
    $('.navi-toggle').on('click', function () {
        $('.main-navi').toggleClass('open');
    });

    $('.main-navi .has-dropdown a i').click(function () {
        $(this).parent().parent().find('.dropdown').toggleClass('expanded');
        return false
    });

    /*Hero Slider*/
    $('.hero-slider').bxSlider({
        mode: 'fade',
        adaptiveHeight: true,
        controls: false,
        video: true,
        touchEnabled: false
    });

    /*Adding Placeholder Support in Older Browsers*/
    $('input, textarea').placeholder();

    /*PopUnder Ads, open new window for lead form*/

    $('#f-zipcode').rules('add', {
        required: true,
        digits: true,
        zipcodeUS: true,
        remote: function () {
            return '/validate_zip/' + $('#f-zipcode').val() + '.json';
        }
    });

    quote_form.submit(function () {
        if (quote_form.valid()) {
            window.open("/get_quote?zip=" + $('#f-zipcode').val());
        }

    })
});

/*/Document ready*/