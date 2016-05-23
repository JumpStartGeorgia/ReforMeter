function setupTimePeriodSelect() {
  $('.js-change-time-period').on('change', function(e) {
    var newTimePeriod = $(e.target).val();
    var currentURL = window.location.href;
    var oldTimePeriod = currentURL.substring(currentURL.lastIndexOf('/') + 1,
                                             currentURL.length);
    var newURL = currentURL.replace(oldTimePeriod, newTimePeriod);

    window.location.href = newURL;
  });
}
