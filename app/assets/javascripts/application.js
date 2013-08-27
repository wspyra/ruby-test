// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require fancybox
//= require cocoon
//= require rails.validations
//= require rails.validations.formtastic
//= require rails.validations.custom
//= require i18n
//= require i18n/translations
//= require jquery_nested_form
//= require_tree .

function setLocale() {
  var locale = $('#language_select option:selected').val();
  window.location = '/' + $('#language_select option:selected').val();
}

$(document).ready(function(){
    $('a.fancybox').fancybox({'type': 'image'});

    $('.send_email').click(function(){

        var email = window.prompt(I18n.t('enter_email'));
        var id = $(this).attr('class').replace('send_email send_email_', '');

        if (null !== email && '' !== email) {
            var send_data = {email: email, id: 6};
            $.ajax({
                url: $(this).attr('href'),
                type: 'json',
                method: 'post',
                data: send_data,
                success: function() {
                    window.location.reload();
                }
            });
        }

        return false;
    });

    $('form').on('cocoon:after-insert', function(e) {
        $(e.delegateTarget).find('input').enableClientSideValidations();
    });

});
