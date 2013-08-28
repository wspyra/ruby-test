window.ClientSideValidations.validators.remote['postal_code'] = function(element, options) {
    if ($.ajax({
        url: '/validators/postal_code',
        data: { id: element.val() },
        async: false
    }).status == 404) { return options.message; }
}

window.ClientSideValidations.validators.local['email_format'] = function (element, options) {
    console.log(element);
    console.log(options);
    if(!/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.test(element.val())) {
        return options.message;
    }
}
