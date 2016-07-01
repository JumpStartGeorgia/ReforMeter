function makeReformPageChangeable() {
  $('.js-load-new-reform-page').click(function() {
    var newQuarter = $('.js-reform-page-quarter-select').val();
    var newReform = $('.js-reform-page-reform-select').val();
    var newURL = $(this).data('newUrlBase') + '/' + newReform + '/' + newQuarter;

    window.location.href = newURL;
  });
}
