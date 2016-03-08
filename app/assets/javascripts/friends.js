var initFriendLookup = function() {
    var $friendLookupForm = $('#friend-lookup-form');
    $friendLookupForm.on('ajax:before', function(event, data, status) {
        showSpinner();
    });

    $friendLookupForm.on('ajax:success', function(event, data, status) {
        $('#friend-lookup').replaceWith(data);
        initFriendLookup();
    });

    $friendLookupForm.on('ajax:error', function(event, xhr, status, error) {
        $('#friend-lookup-results').replaceWith(' ');
        $('#friend-lookup-errors').replaceWith('Person was not found.');
        hideSpinner();
    });

    $friendLookupForm.on('ajax:after', function(event, data, status) {
        hideSpinner();
    });
};

$(document).ready(function() {

    initFriendLookup();

});