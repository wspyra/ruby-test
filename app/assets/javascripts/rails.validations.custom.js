
window.ClientSideValidations.validators.remote['postal_code'] = function(element, options) {
    if ($.ajax({
        url: '/validators/postal_code',
        data: { id: element.val() },
        async: false
    }).status == 404) { return options.message; }
}
