function setVerdictFormVerdict() {
  $('.js-form-verdict-select').change(function() {
    var newVerdict = $(this).val();
    var newURL = $(this).data('newUrlBase') + '?v=' + newVerdict;

    window.location.href = newURL;
  });
}
