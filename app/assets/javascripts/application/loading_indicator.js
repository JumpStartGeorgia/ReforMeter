$(document).on('page:before-change', function() {
  $('.js-fade-in-out-loading-indicator').fadeIn();
});

$(document).on('page:change', function() {
  $('.js-fade-in-out-loading-indicator').css('display', 'none');
});
