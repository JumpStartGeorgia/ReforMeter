function setupExpertTimePeriodSelect() {
  $('.js-change-expert-time-period').on('change', function(e) {
    var newTimePeriod = $(e.target).val();
    var newURL = $(this).data('baseUrl') + '/' + newTimePeriod;

    window.location.href = newURL;
  });
}
