function setQuarterFormQuarter() {
  $('.js-form-quarter-select').change(function() {
    var newQuarter = $(this).val();
    var newURL = $(this).data('newUrlBase') + '?q=' + newQuarter;

    window.location.href = newURL;
  });
}
