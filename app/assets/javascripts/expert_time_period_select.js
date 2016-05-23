function setupExpertTimePeriodSelect() {
  $('.js-change-expert-time-period').on('change', function(e) {
    var newTimePeriod = $(e.target).val();
    var currentURL = window.location.href;
    var newURL = $(this).data('baseUrl') + '/' + newTimePeriod;

    window.location.href = newURL;
  });
}
