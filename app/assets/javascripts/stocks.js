var initStockLookup = function() {
    var $stockLookupForm = $('#stock-lookup-form');
    $stockLookupForm.on('ajax:before', function(event, data, status) {
       showSpinner();
    });

    $stockLookupForm.on('ajax:success', function(event, data, status) {
        $('#stock-lookup').replaceWith(data);
        initStockLookup();
    });

    $stockLookupForm.on('ajax:error', function(event, xhr, status, error) {
        $('#stock-lookup-results').replaceWith(' ');
        $('#stock-lookup-errors').replaceWith('Stock was not found.');
        hideSpinner();
    });

    $stockLookupForm.on('ajax:after', function(event, data, status) {
        hideSpinner();
    });
};

$(document).ready(function() {

    initStockLookup();

});